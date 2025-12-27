package eu.kanade.tachiyomi.animeextension.bn.ftpbd

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
import uy.kohesive.injekt.Injekt
import uy.kohesive.injekt.api.get
import java.io.IOException

class FtpBd : ConfigurableAnimeSource, AnimeHttpSource() {

    override val name = "FtpBd"

    override val baseUrl: String
        get() = if (System.currentTimeMillis() >= 1751673600000L) "https://server3.ftpbd.net" else "https://server3.ftpbd.net"

    override val lang = "all"

    override val supportsLatest = true

    override val id: Long = 0x53334654504244L

    private val preferences: SharedPreferences by getPreferencesLazy()

    private val cm by lazy { CookieManager(client) }

    private val globalHeaders by lazy {
        val cookie = cm.getCookiesHeaders()
        Headers.Builder().apply {
            add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
            if (cookie.isNotBlank()) {
                add("Cookie", cookie)
            }
        }.build()
    }

    override fun setupPreferenceScreen(screen: PreferenceScreen) {
        screen.addEditTextPreference(
            key = "tmdb_api_key",
            title = "TMDb API Key",
            summary = "Enter TMDb API key for high quality images (Optional)",
            default = "",
        )
    }

    private val tmdbApiKey: String
        get() = preferences.getString("tmdb_api_key", "")?.takeIf { it.isNotBlank() } ?: "5cd49aeaf94161b1e7badb23820f6ea9"

    // ============================== Popular ===============================
    override fun popularAnimeRequest(page: Int): Request = GET("$baseUrl/FTP-3/Hindi%20Movies/2025/", globalHeaders)

    override fun popularAnimeParse(response: Response): AnimesPage {
        val document = response.asJsoup()
        val animeList = mutableListOf<SAnime>()

        // Check for directory listing or WordPress grid
        val items = document.select("div.card, article, .jws-post-item")
        if (items.isNotEmpty()) {
            items.forEach { element ->
                val link = element.selectFirst("h5 a, h2 a, h3 a, h4 a, .post-image a, .post-media a") ?: return@forEach
                val title = link.text().trim()
                if (title.isBlank()) return@forEach
                
                val url = link.attr("abs:href")
                val anime = SAnime.create().apply {
                    this.title = title
                    this.url = url
                    
                    val img = element.selectFirst("img[src~=(?i)a11|a_al|poster|banner|thumb], .post-image img, .post-media img, img:not([src~=(?i)back|folder|parent|icon|/icons/])")
                    val rawThumb = img?.attr("abs:data-src")?.ifBlank { null }
                        ?: img?.attr("abs:data-lazy-src")?.ifBlank { null }
                        ?: img?.attr("abs:src")
                    
                    this.thumbnail_url = rawThumb?.replace(" ", "%20")
                }
                animeList.add(anime)
            }
        } else {
            // Fallback to directory listing
            document.select("#fallback table tr, div.entry-content a").forEach { it ->
                val link = it.selectFirst("td.fb-n a") ?: if (it.tagName() == "a") it else null
                link?.let {
                    var title = it.text().trim()
                    if (isIgnored(title)) return@forEach
                    if (title.endsWith("/")) title = title.removeSuffix("/")
                    
                    val url = it.attr("abs:href")
                    if (url.contains("../") || url.contains("?")) return@forEach
                    
                    val anime = SAnime.create().apply {
                        this.title = title
                        this.url = url
                        val thumbBase = if (url.endsWith("/")) url else "$url/"
                        this.thumbnail_url = (thumbBase + "a11.jpg").replace(" ", "%20")
                    }
                    animeList.add(anime)
                }
            }
        }
        return AnimesPage(animeList, false)
    }

    private fun isIgnored(text: String): Boolean {
        val ignored = listOf("Parent Directory", "modern browsers", "Name", "Last modified", "Size", "Description", "Index of", "JavaScript", "powered by")
        return ignored.any { text.contains(it, ignoreCase = true) }
    }

    // =============================== Latest ===============================
    override fun latestUpdatesRequest(page: Int): Request = popularAnimeRequest(page)
    override fun latestUpdatesParse(response: Response): AnimesPage = popularAnimeParse(response)

    // =============================== Search ===============================
    override fun searchAnimeRequest(page: Int, query: String, filters: AnimeFilterList): Request {
        val url = if (query.isNotBlank()) {
            baseUrl.toHttpUrl().newBuilder().apply {
                addPathSegment("search")
                addQueryParameter("term", query)
                addQueryParameter("types", "movies")
            }.build().toString()
        } else {
            Filters.getUrl(query, filters)
        }
        return GET(url, globalHeaders)
    }

    override fun searchAnimeParse(response: Response): AnimesPage = popularAnimeParse(response)

    // ============================== Details ===============================
    override fun animeDetailsParse(response: Response): SAnime {
        val document = response.asJsoup()
        val mediaType = getMediaType(document)
        
        val anime = if (mediaType == "m") getMovieDetails(document)
                   else if (mediaType == "s") getSeriesDetails(document)
                   else SAnime.create().apply {
                       status = SAnime.COMPLETED
                       val img = document.selectFirst("img[src~=(?i)a11|a_al|poster|banner|thumb], img:not([src~=(?i)back|folder|parent|icon|/icons/])")
                       var thumb = img?.attr("abs:src")
                       if (thumb.isNullOrBlank()) {
                           thumb = document.selectFirst("a[href~=(?i)\\.(jpg|jpeg|png|webp)]:not([href~=(?i)back|folder|parent|icon])")?.attr("abs:href")
                       }
                       thumbnail_url = thumb
                   }
        
        val tmdbImg = getTmdbImageUrl(anime.title)
        if (tmdbImg != null) {
            anime.thumbnail_url = tmdbImg
        }
        
        return anime
    }

    private fun getMediaType(document: Document): String? {
        val html = document.select("script").html()
        return when {
            html.contains("/m/lazyload/") -> "m"
            html.contains("/s/lazyload/") -> "s"
            else -> null
        }
    }

    private fun getMovieDetails(document: Document) = SAnime.create().apply {
        status = SAnime.COMPLETED
        thumbnail_url = document.select("figure.movie-detail-banner img, .movie-detail-banner img, .col-md-3 img, .poster img")
            .attr("abs:src").replace(" ", "%20")
        genre = document.select("div.ganre-wrapper a").joinToString { it.text().replace(",", "").trim() }
        description = document.select("p.storyline").text().trim()
    }

    private fun getSeriesDetails(document: Document) = SAnime.create().apply {
        status = SAnime.ONGOING
        thumbnail_url = document.select("figure.movie-detail-banner img, .movie-detail-banner img, .col-md-3 img, .poster img")
            .attr("abs:src").replace(" ", "%20")
        genre = document.select("div.ganre-wrapper a").joinToString { it.text().replace(",", "").trim() }
        description = document.select("p.storyline").text().trim()
    }

    private fun getTmdbImageUrl(title: String): String? {
        val key = tmdbApiKey
        if (key.isBlank()) return null
        val url = "https://api.themoviedb.org/3/search/multi?api_key=$key&query=".plus(java.net.URLEncoder.encode(title, "UTF-8"))
        return try {
            val response = client.newCall(GET(url)).execute()
            val json = response.body?.string() ?: ""
            val regex = """poster_path":"([^"]+)"""".toRegex()
            regex.find(json)?.groupValues?.get(1)?.let { "https://image.tmdb.org/t/p/w500$it" }
        } catch (e: Exception) {
            null
        }
    }

    // ============================== Episodes ==============================
    override suspend fun getEpisodeList(anime: SAnime): List<SEpisode> {
        val response = client.newCall(GET(anime.url, globalHeaders)).awaitSuccess()
        val document = response.asJsoup()
        val mediaType = getMediaType(document)
        
        return when (mediaType) {
            "s" -> {
                val list = extractEpisode(document)
                if (list.isEmpty()) getDirectoryEpisodes(document) else list.reversed()
            }
            "m" -> getMovieMedia(document)
            else -> getDirectoryEpisodes(document)
        }
    }

    private fun extractEpisode(document: Document): List<SEpisode> {
        return document.select("div.card, div.episode-item, div.download-link").mapNotNull { element ->
            val titleElement = element.selectFirst("h5")
            val name = titleElement?.ownText()?.substringBefore("&nbsp;")?.trim() ?: ""
            val url = element.selectFirst("h5 a")?.attr("abs:href")?.trim() ?: ""
            val quality = element.select("h5 .badge-fill").text().trim()
            val seasonEpisode = element.selectFirst("h4")?.ownText()?.trim() ?: ""
            val size = element.selectFirst("h4 .badge-outline")?.text()?.trim() ?: ""
            
            if (name.isBlank() || url.isBlank()) return@mapNotNull null
            
            SEpisode.create().apply {
                this.url = url
                this.name = if (seasonEpisode.isNotBlank()) "$seasonEpisode - $name" else name
                this.scanlator = "$quality  $size".trim()
                this.episode_number = -1f
            }
        }
    }

    private fun getMovieMedia(document: Document): List<SEpisode> {
        val link = document.select("div.col-md-12 a.btn, .movie-buttons a, a[href*=/m/lazyload/], a[href*=/s/lazyload/], .download-link a").lastOrNull()
        val url = link?.attr("abs:href")?.replace(" ", "%20") ?: ""
        val quality = document.select(".badge-wrapper .badge-fill").lastOrNull()?.text()?.replace("|", "")?.trim() ?: ""
        
        return listOf(SEpisode.create().apply {
            this.url = url
            this.name = "Movie"
            this.episode_number = 1f
            this.scanlator = quality
        })
    }

    private suspend fun getDirectoryEpisodes(document: Document): List<SEpisode> {
        val episodes = mutableListOf<SEpisode>()
        parseDirectoryRecursive(document, 4, episodes, mutableSetOf())
        return episodes
    }

    private suspend fun parseDirectoryRecursive(document: Document, depth: Int, episodes: MutableList<SEpisode>, visited: MutableSet<String>) {
        val currentUrl = document.location()
        if (!visited.add(currentUrl)) return

        document.select("a[href]").forEach { link ->
            val href = link.attr("abs:href")
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
                    val subDoc = client.newCall(GET(href, globalHeaders)).awaitSuccess().asJsoup()
                    parseDirectoryRecursive(subDoc, depth - 1, episodes, visited)
                } catch (e: Exception) {}
            }
        }
    }

    override fun episodeListParse(response: Response): List<SEpisode> = throw UnsupportedOperationException()

    // ============================ Video Links =============================
    override suspend fun getVideoList(episode: SEpisode): List<Video> {
        return listOf(Video(episode.url, "Video", episode.url))
    }

    override fun videoListParse(response: Response): List<Video> = throw UnsupportedOperationException()

    override fun getFilterList() = Filters.getFilterList()

    private class CookieManager(private val client: OkHttpClient) {
        private val cookieUrl = "https://ftpbd.net/".toHttpUrl()
        private var cookies: List<Cookie>? = null
        private val lock = Any()

        fun getCookiesHeaders(): String {
            val currentCookies = synchronized(lock) {
                cookies ?: fetchCookies().also { cookies = it }
            }
            return currentCookies.joinToString("; ") { "${it.name}=${it.value}" }
        }

        private fun fetchCookies(): List<Cookie> {
            val req = Request.Builder()
                .url(cookieUrl)
                .header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
                .build()
            return try {
                val res = client.newBuilder().followRedirects(false).build().newCall(req).execute()
                val cookieList = Cookie.parseAll(cookieUrl, res.headers)
                res.close()
                cookieList
            } catch (e: IOException) {
                emptyList()
            }
        }
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

    fun getUrl(query: String, filters: AnimeFilterList): String {
        val cat = (filters[1] as CategorySelect).state
        val year = (filters[3] as YearSelect).state
        val lang = (filters[5] as LanguageSelect).state

        var url = when (cat) {
            0 -> "https://server3.ftpbd.net/FTP-3/Hindi%20Movies/"
            1 -> "https://server2.ftpbd.net/FTP-2/English%20Movies/"
            2 -> "https://server3.ftpbd.net/FTP-3/Bangla%20Collection/"
            3 -> {
                if (lang > 0) {
                    return "https://server3.ftpbd.net/FTP-3/Foreign%20Language%20Movies/${FilterData.LANGUAGES[lang].replace(" ", "%20")}/"
                }
                "https://server3.ftpbd.net/FTP-3/Foreign%20Language%20Movies/"
            }
            4 -> "https://server3.ftpbd.net/FTP-3/South%20Indian%20Movies/"
            5 -> "https://server3.ftpbd.net/FTP-3/Hindi%20TV%20Series/"
            6 -> "https://server3.ftpbd.net/FTP-3/South%20Indian%20TV%20Serias/"
            7 -> "https://server4.ftpbd.net/FTP-4/English-Foreign-TV-Series/"
            8 -> "https://server5.ftpbd.net/FTP-5/Anime--Cartoon-TV-Series/"
            9 -> "https://server5.ftpbd.net/FTP-5/Animation%20Movies/"
            10 -> "https://server2.ftpbd.net/FTP-2/3D%20Movies/"
            11 -> "https://server5.ftpbd.net/FTP-5/Documentary/"
            12 -> "https://server7.ftpbd.net/FTP-7/WWE%20Wrestling/"
            13 -> "https://server7.ftpbd.net/FTP-7/All%20Elite%20Wrestling%20%28AEW%29/"
            14 -> "https://server7.ftpbd.net/FTP-7/Ultimate%20Fighting%20Championship%20%28UFC%29/"
            15 -> "https://server7.ftpbd.net/FTP-7/Awards--TV-Shows/"
            16 -> "https://server3.ftpbd.net/FTP-3/Hindi%20Movies/Hindi-4K-Movies/"
            17 -> "https://server2.ftpbd.net/FTP-2/English%20Movies/English-Movies-4K/"
            18 -> "https://server2.ftpbd.net/FTP-2/English%20Movies/Dual-Audio/"
            19 -> "https://server2.ftpbd.net/FTP-2/English%20Movies/IMDB%20TOP%20250/"
            20 -> "https://server4.ftpbd.net/FTP-4/Tutorial/"
            21 -> return "https://server3.ftpbd.net/FTP-3/%5BToday%27s%20Upload%5D/"
            else -> "https://server3.ftpbd.net/FTP-3/"
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