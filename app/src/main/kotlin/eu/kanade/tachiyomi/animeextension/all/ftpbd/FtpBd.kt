package eu.kanade.tachiyomi.animeextension.all.ftpbd

import android.app.Application
import android.content.SharedPreferences
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
import extensions.utils.addEditTextPreference
import extensions.utils.asJsoup
import extensions.utils.getPreferencesLazy
import okhttp3.Cookie
import okhttp3.Headers
import okhttp3.HttpUrl
import okhttp3.HttpUrl.Companion.toHttpUrl
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import org.jsoup.nodes.Document
import java.net.URLDecoder
import java.net.URLEncoder
import kotlin.text.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.sync.Semaphore
import kotlinx.coroutines.sync.withPermit
import uy.kohesive.injekt.Injekt
import uy.kohesive.injekt.api.get
import java.io.IOException

class FtpBd : ConfigurableAnimeSource, AnimeHttpSource() {

    override val name = "FtpBd"

    override val baseUrl: String
        get() = preferences.getString("base_url", "https://server3.ftpbd.net")!!.removeSuffix("/")

    private val baseDomain: String
        get() = try { baseUrl.toHttpUrl().host.let { h -> if (h.contains(".") && !h.first().isDigit()) h.substring(h.indexOf(".") + 1) else h } } catch (e: Exception) { "ftpbd.net" }

    override val lang = "all"

    override val supportsLatest = true

    override val id: Long = 0x53334654504244L

    private val preferences: SharedPreferences by getPreferencesLazy()

    private val cm by lazy { CookieManager(network.client) }

    override val client: OkHttpClient = network.client.newBuilder()
        .addInterceptor { chain ->
            val request = chain.request()
            val url = request.url
            
            if (url.host.contains(baseDomain)) {
                val newRequest = request.newBuilder()
                    .apply {
                        val cookie = cm.getCookiesHeaders(url.toString())
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

    private fun fixUrl(url: String): String {
        if (url.isBlank()) return url
        return runCatching {
            var u = url.trim()
            val lastHttp = u.lastIndexOf("http://", ignoreCase = true)
            val lastHttps = u.lastIndexOf("https://", ignoreCase = true)
            val lastProtocol = maxOf(lastHttp, lastHttps)
            if (lastProtocol > 0) u = u.substring(lastProtocol)
            u.replace(Regex("http(s)?://http(s)?://", RegexOption.IGNORE_CASE), "http$1://")
                .replace(" ", "%20")
        }.getOrDefault(url)
    }

    override fun animeDetailsRequest(anime: SAnime): Request {
        return GET(fixUrl(anime.url), getGlobalHeaders())
    }

    override fun setupPreferenceScreen(screen: PreferenceScreen) {
        screen.addEditTextPreference(
            key = "base_url",
            title = "Base URL (Main Server)",
            summary = "The main server URL (default: https://server3.ftpbd.net)",
            default = "https://server3.ftpbd.net",
        )
    }

    // ============================== Popular ===============================
    override fun popularAnimeRequest(page: Int): Request {
        val url = baseUrl.toHttpUrl().newBuilder()
            .addPathSegments("FTP-3/Hindi Movies/2025/")
            .build()
        return GET(url, getGlobalHeaders())
    }

    override fun popularAnimeParse(response: Response): AnimesPage {
        return runCatching {
            val document = response.asJsoup()
            val animeList = mutableListOf<SAnime>()
            val isSearch = response.request.url.queryParameter("s") != null

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
                    
                    animeList.add(SAnime.create().apply {
                        this.title = title
                        this.url = fixUrl(url)
                        this.thumbnail_url = "" // Optimized: No images
                    })
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
                        
                        animeList.add(SAnime.create().apply {
                            this.title = title
                            this.url = fixUrl(url)
                            this.thumbnail_url = "" // Optimized: No images
                        })
                    }
                }
            }
            AnimesPage(animeList, false)
        }.getOrElse { AnimesPage(emptyList(), false) }
    }

    private fun isIgnored(text: String): Boolean {
        val ignored = listOf("Parent Directory", "modern browsers", "Name", "Last modified", "Size", "Description", "Index of", "JavaScript", "powered by", "_h5ai")
        return ignored.any { text.contains(it, ignoreCase = true) }
    }

    // =============================== Latest ===============================
    override fun latestUpdatesRequest(page: Int): Request = popularAnimeRequest(page)
    override fun latestUpdatesParse(response: Response): AnimesPage = popularAnimeParse(response)

    // =============================== Search ===============================
    override suspend fun getSearchAnime(page: Int, query: String, filters: AnimeFilterList): AnimesPage {
        if (query.isBlank()) return super.getSearchAnime(page, query, filters)

        val cacheKey = "search_${query.hashCode()}"
        preferences.getString(cacheKey, null)?.let { cached ->
            runCatching {
                val results = cached.split("|").map { 
                    SAnime.create().apply {
                        val parts = it.split(">>")
                        url = parts[0]
                        title = parts[1]
                        thumbnail_url = ""
                    }
                }
                return AnimesPage(results, false)
            }
        }

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

            val semaphore = Semaphore(10)
            val results = searchPaths.map { path ->
                async(Dispatchers.IO) {
                    semaphore.withPermit {
                        runCatching {
                            client.newCall(GET(path, getGlobalHeaders())).execute().use { response ->
                                if (!response.isSuccessful) return@runCatching emptyList<SAnime>()
                                parseSearchDocument(response.asJsoup(), query)
                            }
                        }.getOrDefault(emptyList())
                    }
                }
            }.awaitAll().flatten().distinctBy { it.url }.let { sortByTitle(it, query) }

            if (results.isNotEmpty()) {
                val serializable = results.joinToString("|") { "${it.url}>>${it.title}" }
                preferences.edit().putString(cacheKey, serializable).apply()
            }

            AnimesPage(results, false)
        }
    }

    private fun parseSearchDocument(document: Document, query: String): List<SAnime> {
        val normalizedQuery = query.lowercase()
        return document.select("td.fb-n a, div.entry-content a, table tr a").mapNotNull { link ->
            var title = link.text().trim()
            if (title.isBlank() || isIgnored(title)) return@mapNotNull null
            if (title.endsWith("/")) title = title.removeSuffix("/")
            
            if (title.lowercase().contains(normalizedQuery)) {
                val url = link.attr("abs:href")
                if (url.contains("?") || url.endsWith("..")) return@mapNotNull null
                
                SAnime.create().apply {
                    this.title = title
                    this.url = fixUrl(url)
                    this.thumbnail_url = ""
                }
            } else null
        }
    }

    private fun sortByTitle(list: List<SAnime>, query: String): List<SAnime> {
        val normalizedQuery = query.lowercase()
        return list.sortedByDescending { 
            when {
                it.title.lowercase() == normalizedQuery -> 2.0
                it.title.lowercase().startsWith(normalizedQuery) -> 1.5
                it.title.lowercase().contains(normalizedQuery) -> 1.0
                else -> 0.0
            }
        }
    }

    override fun searchAnimeRequest(page: Int, query: String, filters: AnimeFilterList): Request {
        return GET(Filters.getUrl(baseDomain, query, filters), getGlobalHeaders())
    }

    override fun searchAnimeParse(response: Response): AnimesPage = popularAnimeParse(response)

    // ============================== Details ===============================
    override fun animeDetailsParse(response: Response): SAnime {
        val document = response.asJsoup()
        return SAnime.create().apply {
            status = SAnime.UNKNOWN
            thumbnail_url = ""
            description = document.select("p.storyline, .entry-content p").text().trim().takeIf { it.isNotBlank() } ?: "No description available."
            genre = document.select("div.ganre-wrapper a, .entry-content a[href*='/category/']").joinToString { it.text().trim() }
        }
    }

    // ============================== Episodes ==============================
    override suspend fun getEpisodeList(anime: SAnime): List<SEpisode> {
        val currentUrl = fixUrl(anime.url)
        val cacheKey = "ep_cache_" + currentUrl.hashCode()
        
        preferences.getString(cacheKey, null)?.let { cached ->
            runCatching {
                return cached.split("|").filter { it.contains(">>") }.map { 
                    SEpisode.create().apply { 
                        val parts = it.split(">>")
                        url = parts[0]
                        name = parts[1]
                    }
                }
            }
        }

        return runCatching {
            val response = client.newCall(GET(currentUrl, getGlobalHeaders())).awaitSuccess()
            val episodes = getDirectoryEpisodes(response.asJsoup())
            
            if (episodes.isNotEmpty()) {
                val serializable = episodes.joinToString("|") { "${it.url}>>${it.name}" }
                preferences.edit().putString(cacheKey, serializable).apply()
            }
            episodes
        }.getOrDefault(emptyList())
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
            
            val lowerHref = href.lowercase()
            if (VIDEO_EXTENSIONS.any { lowerHref.endsWith(it) }) {
                episodes.add(SEpisode.create().apply {
                    this.name = text
                    this.url = href
                    this.episode_number = -1f
                })
            } else if (depth > 0 && href.endsWith("/") && !href.contains("_h5ai")) {
                runCatching {
                    val subDoc = client.newCall(GET(href, getGlobalHeaders())).awaitSuccess().asJsoup()
                    parseDirectoryRecursive(subDoc, depth - 1, episodes, visited)
                }
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

    private class CookieManager(private val client: OkHttpClient) {
        private var cookies = mutableMapOf<String, List<Cookie>>()
        private val lock = Any()

        fun getCookiesHeaders(url: String): String {
            val host = runCatching { url.toHttpUrl().host }.getOrNull() ?: return ""
            val currentCookies = synchronized(lock) {
                cookies[host] ?: fetchCookies(url).also { cookies[host] = it }
            }
            return currentCookies.joinToString("; ") { "${it.name}=${it.value}" }
        }

        private fun fetchCookies(url: String): List<Cookie> {
            val hostUrl = runCatching { 
                val u = url.toHttpUrl()
                "${u.scheme}://${u.host}/".toHttpUrl()
            }.getOrNull() ?: return emptyList()
            
            val req = Request.Builder()
                .url(hostUrl)
                .header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
                .build()
            return runCatching {
                client.newBuilder().followRedirects(false).build().newCall(req).execute().use { res ->
                    Cookie.parseAll(hostUrl, res.headers)
                }
            }.getOrDefault(emptyList())
        }
    }

    companion object {
        private val VIDEO_EXTENSIONS = listOf(".mkv", ".mp4", ".avi", ".ts", ".m4v", ".webm", ".mov")
    }
}

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

        val urlBuilder = HttpUrl.Builder()
            .scheme("https")
            .host(when (cat) {
                1, 10, 17, 18, 19 -> "server2.$domain"
                7, 20 -> "server4.$domain"
                8, 9, 11 -> "server5.$domain"
                12, 13, 14, 15 -> "server7.$domain"
                else -> "server3.$domain"
            })

        val path = when (cat) {
            0 -> "FTP-3/Hindi Movies"
            1 -> "FTP-2/English Movies"
            2 -> "FTP-3/Bangla Collection"
            3 -> {
                if (lang > 0) "FTP-3/Foreign Language Movies/${FilterData.LANGUAGES[lang]}"
                else "FTP-3/Foreign Language Movies"
            }
            4 -> "FTP-3/South Indian Movies"
            5 -> "FTP-3/Hindi TV Series"
            6 -> "FTP-3/South Indian TV Serias"
            7 -> "FTP-4/English-Foreign-TV-Series"
            8 -> "FTP-5/Anime--Cartoon-TV-Series"
            9 -> "FTP-5/Animation Movies"
            10 -> "FTP-2/3D Movies"
            11 -> "FTP-5/Documentary"
            12 -> "FTP-7/WWE Wrestling"
            13 -> "FTP-7/All Elite Wrestling (AEW)"
            14 -> "FTP-7/Ultimate Fighting Championship (UFC)"
            15 -> "FTP-7/Awards--TV-Shows"
            16 -> "FTP-3/Hindi Movies/Hindi-4K-Movies"
            17 -> "FTP-2/English Movies/English-Movies-4K"
            18 -> "FTP-2/English Movies/Dual-Audio"
            19 -> "FTP-2/English Movies/IMDB TOP 250"
            20 -> "FTP-4/Tutorial"
            21 -> "FTP-3/[Today's Upload]"
            else -> "FTP-3"
        }

        urlBuilder.addPathSegments(path)
        if (year > 0) {
            urlBuilder.addPathSegment(FilterData.YEARS[year])
        }
        
        return urlBuilder.build().toString() + "/"
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
