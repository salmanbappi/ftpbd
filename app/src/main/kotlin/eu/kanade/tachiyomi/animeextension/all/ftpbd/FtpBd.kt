package eu.kanade.tachiyomi.animeextension.all.ftpbd

import android.util.Log
import androidx.preference.EditTextPreference
import androidx.preference.PreferenceScreen
import eu.kanade.tachiyomi.animesource.ConfigurableAnimeSource
import eu.kanade.tachiyomi.animesource.model.AnimeFilter
import eu.kanade.tachiyomi.animesource.model.AnimeFilterList
import eu.kanade.tachiyomi.animesource.model.AnimesPage
import eu.kanade.tachiyomi.animesource.model.SAnime
import eu.kanade.tachiyomi.animesource.model.SEpisode
import eu.kanade.tachiyomi.animesource.model.Video
import eu.kanade.tachiyomi.animesource.online.AnimeHttpSource
import eu.kanade.tachiyomi.network.GET
import eu.kanade.tachiyomi.network.awaitSuccess
import extensions.utils.asJsoup
import extensions.utils.getPreferencesLazy
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.sync.Semaphore
import kotlinx.coroutines.sync.withPermit
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import okhttp3.Cookie
import okhttp3.Headers
import okhttp3.HttpUrl
import okhttp3.HttpUrl.Companion.toHttpUrl
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import org.jsoup.nodes.Document
import uy.kohesive.injekt.Injekt
import uy.kohesive.injekt.api.get
import java.io.IOException
import java.net.URLDecoder
import java.net.URLEncoder
import java.util.concurrent.TimeUnit

class FtpBd : ConfigurableAnimeSource, AnimeHttpSource() {

    override val name = "FtpBd"

    override val baseUrl: String
        get() = preferences.getString("base_url", "https://server3.ftpbd.net")!!.removeSuffix("/")

    private val baseDomain: String
        get() = try { baseUrl.toHttpUrl().host.let { h -> if (h.contains(".") && !h.first().isDigit()) h.substring(h.indexOf(".") + 1) else h } } catch (e: Exception) { "ftpbd.net" }

    override val lang = "all"

    override val supportsLatest = true

    override val id: Long = 0x53334654504244L

    private val preferences: android.content.SharedPreferences by getPreferencesLazy()

    private val omdbJson = Json {
        ignoreUnknownKeys = true
        isLenient = true
    }

    private val cm by lazy { CookieManager(network.client) }

    override val client: OkHttpClient = network.client.newBuilder()
        .connectTimeout(15, TimeUnit.SECONDS)
        .readTimeout(15, TimeUnit.SECONDS)
        .dispatcher(okhttp3.Dispatcher().apply {
            maxRequests = 100
            maxRequestsPerHost = 100
        })
        .addInterceptor { chain ->
            val request = chain.request()
            val url = request.url.toString()
            val host = try { request.url.host } catch (e: Exception) { "" }
            
            if (host.contains(baseDomain)) {
                val newRequest = request.newBuilder()
                    .apply {
                        val cookie = cm.getCookiesHeaders(url)
                        removeHeader("User-Agent")
                        addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
                        if (cookie.isNotBlank()) {
                            removeHeader("Cookie")
                            addHeader("Cookie", cookie)
                        }
                    }
                    .build()
                chain.proceed(newRequest)
            } else {
                chain.proceed(request)
            }
        }
        .build()

    private fun getGlobalHeaders(): Headers {
        return Headers.Builder().apply {
            add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
        }.build()
    }

    private suspend fun enrichAnimes(animes: List<SAnime>) {
        val source = preferences.getString(PREF_POSTER_SOURCE, "tmdb")
        if (source != "tmdb") return

        val apiKey = preferences.getString(PREF_TMDB_API_KEY, "") ?: ""
        if (apiKey.isBlank()) return

        kotlinx.coroutines.withTimeoutOrNull(3000) {
            coroutineScope {
                animes.map { anime ->
                    async {
                        enrichmentSemaphore.withPermit {
                            fetchPosterFromTMDb(anime, apiKey)
                        }
                    }
                }.awaitAll()
            }
        }
    }

    private suspend fun fetchPoster(anime: SAnime, apiKey: String) {
        val cacheKey = "poster_omdb_${anime.title.hashCode()}"
        val cachedPoster = preferences.getString(cacheKey, null)

        if (cachedPoster != null) {
            anime.thumbnail_url = cachedPoster
            return
        }

        try {
            val cleanTitle = anime.title.replace(Regex("""\(?\d{4}\)?"""), "").trim()
            val url = "https://www.omdbapi.com/?apikey=$apiKey&t=${URLEncoder.encode(cleanTitle, "UTF-8")}"
            val response = client.newCall(GET(url)).awaitSuccess()
            val body = response.body?.string().orEmpty()
            val omdb = omdbJson.decodeFromString<OMDbResponse>(body)

            if (omdb.Response == "True" && !omdb.Poster.isNullOrBlank() && omdb.Poster != "N/A") {
                anime.thumbnail_url = omdb.Poster
                preferences.edit().putString(cacheKey, omdb.Poster).apply()
            }
        } catch (e: Exception) {
            Log.e("FtpBd", "OMDb lookup failed: ${e.message}")
        }
    }

    private suspend fun fetchPosterFromTMDb(anime: SAnime, apiKey: String) {
        val cacheKey = "poster_tmdb_${anime.title.hashCode()}"
        val cachedPoster = preferences.getString(cacheKey, null)

        if (cachedPoster != null) {
            anime.thumbnail_url = cachedPoster
            return
        }

        try {
            val cleanTitle = anime.title.replace(Regex("""\(?\d{4}\)?"""), "").trim()
            val url = "https://api.themoviedb.org/3/search/multi?api_key=$apiKey&query=${URLEncoder.encode(cleanTitle, "UTF-8")}"
            val response = client.newCall(GET(url)).awaitSuccess()
            val body = response.body?.string().orEmpty()
            val tmdb = omdbJson.decodeFromString<TMDbResponse>(body)

            val posterPath = tmdb.results?.firstOrNull()?.poster_path
            if (!posterPath.isNullOrBlank()) {
                val posterUrl = "https://image.tmdb.org/t/p/w500$posterPath"
                anime.thumbnail_url = posterUrl
                preferences.edit().putString(cacheKey, posterUrl).apply()
            }
        } catch (e: Exception) {
            Log.e("FtpBd", "TMDb lookup failed: ${e.message}")
        }
    }

    private fun fixUrl(url: String): String {
        if (url.isBlank()) return url
        var u = url.trim()
        val lastHttp = u.lastIndexOf("http://", ignoreCase = true)
        val lastHttps = u.lastIndexOf("https://", ignoreCase = true)
        val lastProtocol = Math.max(lastHttp, lastHttps)
        if (lastProtocol > 0) u = u.substring(lastProtocol)
        u = u.replace(Regex("http(s)?://http(s)?://", RegexOption.IGNORE_CASE), "http$1://")
        return u.replace(" ", "%20")
    }

    override fun animeDetailsRequest(anime: SAnime): Request {
        return GET(fixUrl(anime.url), getGlobalHeaders())
    }

    override fun setupPreferenceScreen(screen: PreferenceScreen) {
        androidx.preference.ListPreference(screen.context).apply {
            key = PREF_POSTER_SOURCE
            title = "Poster Source"
            entries = arrayOf("OMDb", "TMDb")
            entryValues = arrayOf("omdb", "tmdb")
            summary = "%s"
            setDefaultValue("tmdb")
        }.also(screen::addPreference)

        EditTextPreference(screen.context).apply {
            key = PREF_TMDB_API_KEY
            title = "TMDb API Key"
            summary = "Used for TMDb posters. Get one at themoviedb.org"
            setDefaultValue("")
        }.also(screen::addPreference)

        EditTextPreference(screen.context).apply {
            key = PREF_OMDB_API_KEY
            title = "OMDb API Key"
            summary = "Used for OMDb posters. Get one at omdbapi.com"
            setDefaultValue("")
        }.also(screen::addPreference)

        EditTextPreference(screen.context).apply {
            key = "base_url"
            title = "Base URL (Main Server)"
            summary = "The main server URL (default: https://server3.ftpbd.net)"
            setDefaultValue("https://server3.ftpbd.net")
        }.also(screen::addPreference)
    }

    // ============================== Popular ===============================
    override suspend fun getPopularAnime(page: Int): AnimesPage {
        val response = client.newCall(popularAnimeRequest(page)).awaitSuccess()
        return popularAnimeParse(response).also { enrichAnimes(it.animes) }
    }

    override fun popularAnimeRequest(page: Int): Request = GET("$baseUrl/FTP-3/Hindi%20Movies/2025/", getGlobalHeaders())

    override fun popularAnimeParse(response: Response): AnimesPage {
        val document = response.asJsoup()
        val animeList = mutableListOf<SAnime>()
        val isSearch = response.request.url.toString().contains("?s=")

        // Restore grid/item parsing but with empty thumbnails for speed
        val items = document.select("div.card, article, .jws-post-item, .post-item, .movie-item, .jws-post-wrapper")
        if (items.isNotEmpty()) {
            items.forEach { element ->
                val link = element.selectFirst("h5 a, h2 a, h3 a, h4 a, .post-image a, .post-media a, a:has(img), .jws-post-image a") ?: return@forEach
                val url = link.attr("abs:href")
                
                var title = link.text().trim()
                if (title.isBlank()) {
                    title = element.selectFirst("h5, h2, h3, h4, .post-title, .movie-title, .jws-post-title")?.text()?.trim() ?: ""
                }
                if (title.isBlank()) {
                    title = element.selectFirst("img")?.attr("alt")?.trim() ?: ""
                }
                
                if (title.isBlank() || (isSearch && (title.contains("Director", true) || title.contains("Actor", true)))) return@forEach
                
                val anime = SAnime.create().apply {
                    this.title = title
                    this.url = fixUrl(url)
                    this.thumbnail_url = "" // Optimized: No images
                }
                animeList.add(anime)
            }
        } else {
            // Fallback to directory listing
            val docUrl = document.location()
            document.select("#fallback table tr, div.entry-content a, table tr").forEach { it ->
                val link = it.selectFirst("td.fb-n a") ?: if (it.tagName() == "a") it else null
                link?.let {
                    var title = it.text().trim()
                    if (isIgnored(title)) return@forEach
                    if (title.endsWith("/")) title = title.removeSuffix("/")
                    
                    val url = it.attr("abs:href").ifBlank { 
                        val href = it.attr("href")
                        if (href.startsWith("http")) href else docUrl.removeSuffix("/") + "/" + href.removePrefix("/")
                    }
                    if (url.contains("../") || url.contains("?")) return@forEach
                    
                    val anime = SAnime.create().apply {
                        this.title = title
                        this.url = fixUrl(url)
                        this.thumbnail_url = "" // Optimized: No images
                    }
                    animeList.add(anime)
                }
            }
        }
        return AnimesPage(animeList, false)
    }

    private fun isIgnored(text: String): Boolean {
        val ignored = listOf("Parent Directory", "modern browsers", "Name", "Last modified", "Size", "Description", "Index of", "JavaScript", "powered by", "_h5ai")
        return ignored.any { text.contains(it, ignoreCase = true) }
    }

    // =============================== Latest ===============================
    override suspend fun getLatestUpdates(page: Int): AnimesPage {
        val response = client.newCall(latestUpdatesRequest(page)).awaitSuccess()
        return latestUpdatesParse(response).also { enrichAnimes(it.animes) }
    }

    override fun latestUpdatesRequest(page: Int): Request = popularAnimeRequest(page)
    override fun latestUpdatesParse(response: Response): AnimesPage = popularAnimeParse(response)

    // =============================== Search ===============================
    override suspend fun getSearchAnime(page: Int, query: String, filters: AnimeFilterList): AnimesPage {
        if (query.isBlank()) return super.getSearchAnime(page, query, filters).also { enrichAnimes(it.animes) }

        return coroutineScope {
            val domain = baseDomain
            val searchPaths = listOf(
                "https://server3.$domain/FTP-3/Hindi%20Movies/2025/",
                "https://server3.$domain/FTP-3/Hindi%20Movies/2024/",
                "https://server3.$domain/FTP-3/Hindi%20Movies/2023/",
                "https://server3.$domain/FTP-3/Hindi%20Movies/Hindi-4K-Movies/",
                "https://server3.$domain/FTP-3/Hindi%20TV%20Series/",
                "https://server3.$domain/FTP-3/South%20Indian%20Movies/2025/",
                "https://server3.$domain/FTP-3/Foreign%20Language%20Movies/2025/",
                "https://server2.$domain/FTP-2/English%20Movies/2025/",
                "https://server2.$domain/FTP-2/English%20Movies/English-Movies-4K/",
                "https://server4.$domain/FTP-4/English-Foreign-TV-Series/",
                "https://server5.$domain/FTP-5/Anime--Cartoon-TV-Series/",
                "https://server5.$domain/FTP-5/Animation%20Movies/"
            )

            val semaphore = Semaphore(15)
            val results = searchPaths.map { path ->
                async(Dispatchers.IO) {
                    semaphore.withPermit {
                        try {
                            val response = client.newCall(GET(path, getGlobalHeaders())).execute()
                            if (!response.isSuccessful) return@withPermit emptyList<SAnime>()
                            val doc = response.asJsoup()
                            parseSearchDocument(doc, query)
                        } catch (e: Exception) {
                            emptyList<SAnime>()
                        }
                    }
                }
            }.awaitAll().flatten().distinctBy { it.url }

            AnimesPage(sortByTitle(results, query), false).also { enrichAnimes(it.animes) }
        }
    }

    private fun parseSearchDocument(document: Document, query: String): List<SAnime> {
        val animeList = mutableListOf<SAnime>()
        val normalizedQuery = query.lowercase()
        
        document.select("td.fb-n a, div.entry-content a, table tr a").forEach { link ->
            var title = link.text().trim()
            if (title.isBlank() || isIgnored(title)) return@forEach
            if (title.endsWith("/")) title = title.removeSuffix("/")
            
            if (title.lowercase().contains(normalizedQuery)) {
                val url = link.attr("abs:href")
                if (url.contains("?") || url.endsWith("..")) return@forEach
                
                animeList.add(SAnime.create().apply {
                    this.title = title
                    this.url = fixUrl(url)
                    this.thumbnail_url = ""
                })
            }
        }
        return animeList
    }

    private fun sortByTitle(list: List<SAnime>, query: String): List<SAnime> {
        val normalizedQuery = query.lowercase()
        return list.sortedByDescending { 
            if (it.title.lowercase() == normalizedQuery) 2.0
            else if (it.title.lowercase().startsWith(normalizedQuery)) 1.5
            else if (it.title.lowercase().contains(normalizedQuery)) 1.0
            else 0.0
        }
    }

    override fun searchAnimeRequest(page: Int, query: String, filters: AnimeFilterList): Request {
        return GET(Filters.getUrl(baseDomain, query, filters), getGlobalHeaders())
    }

    override fun searchAnimeParse(response: Response): AnimesPage = popularAnimeParse(response)

    // ============================== Details ===============================
    override suspend fun getAnimeDetails(anime: SAnime): SAnime {
        val source = preferences.getString(PREF_POSTER_SOURCE, "tmdb")
        if (source == "omdb") {
            val apiKey = preferences.getString(PREF_OMDB_API_KEY, "") ?: ""
            if (apiKey.isNotBlank()) fetchPoster(anime, apiKey)
        } else {
            val apiKey = preferences.getString(PREF_TMDB_API_KEY, "") ?: ""
            if (apiKey.isNotBlank()) fetchPosterFromTMDb(anime, apiKey)
        }
        return super.getAnimeDetails(anime)
    }

    override fun animeDetailsParse(response: Response): SAnime {
        val document = response.asJsoup()
        return SAnime.create().apply {
            status = SAnime.UNKNOWN
            thumbnail_url = ""
            description = document.select("p.storyline, .entry-content p").text().trim().ifBlank { "No description available." }
            genre = document.select("div.ganre-wrapper a, .entry-content a[href*='/category/']").joinToString { it.text().trim() }
        }
    }

    // ============================== Episodes ==============================
    override suspend fun getEpisodeList(anime: SAnime): List<SEpisode> {
        val currentUrl = fixUrl(anime.url)
        val cacheKey = "cache_" + currentUrl.hashCode()
        
        // Try to load from Persistent Cache
        val cachedData = preferences.getString(cacheKey, null)
        if (cachedData != null) {
            return cachedData.split("|").filter { it.contains(">>") }.map { 
                SEpisode.create().apply { 
                    val parts = it.split(">>")
                    url = parts[0]
                    name = parts[1]
                }
            }
        }

        val response = client.newCall(GET(currentUrl, getGlobalHeaders())).awaitSuccess()
        val episodes = getDirectoryEpisodes(response.asJsoup())
        
        // Save to Persistent Cache
        val serializable = episodes.joinToString("|") { "${it.url}>>${it.name}" }
        preferences.edit().putString(cacheKey, serializable).apply()
        
        return episodes
    }

    private suspend fun getDirectoryEpisodes(document: Document): List<SEpisode> {
        val episodes = mutableListOf<SEpisode>()
        parseDirectoryRecursive(document, 3, episodes, mutableSetOf())
        return episodes.sortedBy { it.name }.reversed()
    }

    private suspend fun parseDirectoryRecursive(document: Document, depth: Int, episodes: MutableList<SEpisode>, visited: MutableSet<String>) {
        val currentUrl = document.location()
        if (!visited.add(currentUrl)) return

        document.select("a[href]").forEach { link ->
            val href = link.attr("abs:href").ifBlank {
                val r = link.attr("href")
                if (r.startsWith("http")) r else currentUrl.removeSuffix("/") + "/" + r.removePrefix("/")
            }
            val text = link.text().trim()
            if (isIgnored(text) || href.contains("?")) return@forEach
            
            val lowerHref = href.toLowerCase()
            if (listOf(".mkv", ".mp4", ".avi", ".ts", ".m4v", ".webm", ".mov").any { lowerHref.endsWith(it) }) {
                episodes.add(SEpisode.create().apply {
                    this.name = text
                    this.url = href
                    this.episode_number = -1f
                })
            } else if (depth > 0 && href.endsWith("/") && !href.contains("_h5ai")) {
                try {
                    val subDoc = client.newCall(GET(href, getGlobalHeaders())).awaitSuccess().asJsoup()
                    parseDirectoryRecursive(subDoc, depth - 1, episodes, visited)
                } catch (e: Exception) {}
            }
        }
    }

    override fun episodeListParse(response: Response): List<SEpisode> = throw UnsupportedOperationException()

    // ============================ Video Links =============================
    override suspend fun getVideoList(episode: SEpisode): List<Video> {
        val videoUrl = fixUrl(episode.url)
        val headers = Headers.Builder()
            .add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
            .add("Referer", baseUrl + "/")
            .build()
        return listOf(Video(videoUrl, "Direct Video", videoUrl, headers = headers))
    }

    override fun videoListParse(response: Response): List<Video> = throw UnsupportedOperationException()

    override fun getFilterList() = Filters.getFilterList()

    private val enrichmentSemaphore = Semaphore(10)

    private class CookieManager(private val client: OkHttpClient) {
        private var cookies = mutableMapOf<String, List<Cookie>>()
        private val lock = Any()

        fun getCookiesHeaders(url: String): String {
            val host = try { url.toHttpUrl().host } catch (e: Exception) { return "" }
            val currentCookies = synchronized(lock) {
                cookies[host] ?: fetchCookies(url).also { cookies[host] = it }
            }
            return currentCookies.joinToString("; ") { "${it.name}=${it.value}" }
        }

        private fun fetchCookies(url: String): List<Cookie> {
            val hostUrl = try { 
                val u = url.toHttpUrl()
                "${u.scheme}://${u.host}/".toHttpUrl()
            } catch (e: Exception) { return emptyList() }
            
            val req = Request.Builder()
                .url(hostUrl)
                .header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
                .build()
            return try {
                val res = client.newBuilder().followRedirects(false).build().newCall(req).execute()
                val cookieList = Cookie.parseAll(hostUrl, res.headers)
                res.close()
                cookieList
            } catch (e: IOException) {
                emptyList()
            }
        }
    }
    companion object {
        private const val PREF_OMDB_API_KEY = "omdb_api_key"
        private const val PREF_TMDB_API_KEY = "tmdb_api_key"
        private const val PREF_POSTER_SOURCE = "poster_source"
    }
}

@Serializable
data class OMDbResponse(
    val Response: String,
    val Poster: String? = null,
    val Error: String? = null
)

@Serializable
data class TMDbResponse(
    val results: List<TMDbResult>? = null
)

@Serializable
data class TMDbResult(
    val poster_path: String? = null
)

object Filters {
    fun getFilterList() = AnimeFilterList(
        AnimeFilter.Header("--- Category ---"),
        CategorySelect(),
        AnimeFilter.Header("--- Year ---"),
        YearSelect(),
        AnimeFilter.Header("--- Language (Foreign Lang. only) ---"),
        LanguageSelect()
    )

    class CategorySelect : AnimeFilter.Select<String>("Select Category", FilterData.CATEGORIES)
    class YearSelect : AnimeFilter.Select<String>("Select Year", FilterData.YEARS)
    class LanguageSelect : AnimeFilter.Select<String>("Select Language", FilterData.LANGUAGES)

    fun getUrl(domain: String, query: String, filters: AnimeFilterList): String {
        val cat = (filters[1] as CategorySelect).state
        val year = (filters[3] as YearSelect).state
        val lang = (filters[5] as LanguageSelect).state

        var url = when (cat) {
            0 -> "https://server3.$domain/FTP-3/Hindi%20Movies/"
            1 -> "https://server2.$domain/FTP-2/English%20Movies/"
            2 -> "https://server3.$domain/FTP-3/Bangla%20Collection/"
            3 -> {
                if (lang > 0) {
                    return "https://server3.$domain/FTP-3/Foreign%20Language%20Movies/${FilterData.LANGUAGES[lang].replace(" ", "%20")}/"
                }
                "https://server3.$domain/FTP-3/Foreign%20Language%20Movies/"
            }
            4 -> "https://server3.$domain/FTP-3/South%20Indian%20Movies/"
            5 -> "https://server3.$domain/FTP-3/Hindi%20TV%20Series/"
            6 -> "https://server3.$domain/FTP-3/South%20Indian%20TV%20Serias/"
            7 -> "https://server4.$domain/FTP-4/English-Foreign-TV-Series/"
            8 -> "https://server5.$domain/FTP-5/Anime--Cartoon-TV-Series/"
            9 -> "https://server5.$domain/FTP-5/Animation%20Movies/"
            10 -> "https://server2.$domain/FTP-2/3D%20Movies/"
            11 -> "https://server5.$domain/FTP-5/Documentary/"
            12 -> "https://server7.$domain/FTP-7/WWE%20Wrestling/"
            13 -> "https://server7.$domain/FTP-7/All%20Elite%20Wrestling%20%28AEW%29/"
            14 -> "https://server7.$domain/FTP-7/Ultimate%20Fighting%20Championship%20%28UFC%29/"
            15 -> "https://server7.$domain/FTP-7/Awards--TV-Shows/"
            16 -> "https://server3.$domain/FTP-3/Hindi%20Movies/Hindi-4K-Movies/"
            17 -> "https://server2.$domain/FTP-2/English%20Movies/English-Movies-4K/"
            18 -> "https://server2.$domain/FTP-2/English%20Movies/Dual-Audio/"
            19 -> "https://server2.$domain/FTP-2/English%20Movies/IMDB%20TOP%20250/"
            20 -> "https://server4.$domain/FTP-4/Tutorial/"
            21 -> return "https://server3.$domain/FTP-3/%5BToday%27s%20Upload%5D/"
            else -> "https://server3.$domain/FTP-3/"
        }

        if (year > 0) {
            url += "${FilterData.YEARS[year].replace(" ", "%20").replace("&", "%26")}/"
        }
        return url
    }
}

object FilterData {
    val CATEGORIES = arrayOf(
        "Hindi Movies", "English Movies", "Bangla Collection", "Foreign Language Movies",
        "South Indian Movies", "Hindi TV Series", "South Indian TV Serias",
        "English & Foreign TV Series", "Anime & Cartoon TV Series", "Animation Movies",
        "3D Movies", "Documentary", "WWE Wrestling", "All Elite Wrestling (AEW)", "UFC",
        "Awards & TV Shows", "Hindi 4K Movies", "English 4K Movies", "Dual Audio Movies",
        "IMDb Top 250", "Tutorial", "Today's Upload"
    )

    val YEARS = arrayOf(
        "Any", "2025", "2024", "2023", "2022", "2021", "2020", "2019", "2018", "2017",
        "2016", "2015", "2014", "2013", "2012", "2011", "2001--2010", "1991--2000", "1990-&-Before"
    )

    val LANGUAGES = arrayOf(
        "Any", "Arabic Language", "Brazilian-Movie", "Chinese-Language", "Denmark-Movies",
        "Dutch-Language", "French-Language", "German-Language", "Hong-Kong", "Indonesian-Movie",
        "Iranian-Movies", "Italian-Movie", "Japanese-Language", "Korean-Language",
        "Mexico-Language", "Norwegian-Language", "Pakistani-Language", "Polish-Language",
        "Portuguese-Language", "Russian-Language", "Spanish-Language", "Swedish-Language",
        "Taiwan", "Thai-Language", "Turkish-Language", "Vietnamese-Language", "Other-Language"
    )
}
