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
import extensions.utils.parseAs
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import okhttp3.Cookie
import okhttp3.Headers
import okhttp3.HttpUrl
import okhttp3.HttpUrl.Companion.toHttpUrl
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import org.jsoup.nodes.Document
import java.net.URLEncoder
import kotlin.text.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.Semaphore
import kotlinx.coroutines.sync.withLock
import kotlinx.coroutines.sync.withPermit
import uy.kohesive.injekt.Injekt
import uy.kohesive.injekt.api.get
import java.io.IOException

class FtpBd : ConfigurableAnimeSource, AnimeHttpSource() {

    override val name = "FtpBd"

    override val baseUrl = "https://ftpbd.net"

    override val lang = "all"

    override val supportsLatest = true

    override val id: Long = 0x53334654504244L

    private val preferences: SharedPreferences by getPreferencesLazy()

    private val cm by lazy { CookieManager(network.client) }

    override val client: OkHttpClient = network.client.newBuilder()
        .addInterceptor { chain ->
            val request = chain.request()
            val url = request.url.toString()
            if (url.contains("tmdb.org") || url.contains("ftpbd.net")) {
                val newRequest = request.newBuilder()
                    .apply {
                        if (url.contains("tmdb.org")) {
                            if (url.contains("api.themoviedb.org")) {
                                addHeader("Authorization", "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1Y2Q0OWFlYWY5NDE2MWIxZTdiYWRiMjM4MjBmNmVhOSIsIm5iZiI6MTc1MTYzNTQzNS44NzM5OTk4LCJzdWIiOiI2ODY3ZDVlYmUzZDMxMmU1OGI2NzczNmYiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.etziZE5AbWlUmsjFWwTWJ5C0GKYHqLb31kYzS6IwFXU")
                            }
                            removeHeader("User-Agent")
                            addHeader("User-Agent", "Mozilla/5.0")
                        } else if (url.contains("ftpbd.net")) {
                            val cookie = cm.getCookiesHeaders()
                            removeHeader("User-Agent")
                            addHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
                            if (cookie.isNotBlank()) {
                                removeHeader("Cookie")
                                addHeader("Cookie", cookie)
                            }
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
        val cookie = cm.getCookiesHeaders()
        return Headers.Builder().apply {
            add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
            if (cookie.isNotBlank()) {
                add("Cookie", cookie)
            }
        }.build()
    }

    private fun fixUrl(url: String): String {
        if (url.isBlank()) return url
        var u = url.trim()
        
        // Handle baseUrl + absoluteUrl concatenation: https://ftpbd.nethttps://...
        val lastHttp = u.lastIndexOf("http://", ignoreCase = true)
        val lastHttps = u.lastIndexOf("https://", ignoreCase = true)
        val lastProtocol = Math.max(lastHttp, lastHttps)
        
        if (lastProtocol > 0) {
            u = u.substring(lastProtocol)
        }
        
        // Remove double protocol prefix
        u = u.replace(Regex("http(s)?://http(s)?://", RegexOption.IGNORE_CASE), "http$1://")
        
        return u.replace(" ", "%20")
    }

    override fun animeDetailsRequest(anime: SAnime): Request {
        return GET(fixUrl(anime.url))
    }

    private val tmdbHeaders by lazy {
        Headers.Builder()
            .add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
            .add("Authorization", "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1Y2Q0OWFlYWY5NDE2MWIxZTdiYWRiMjM4MjBmNmVhOTIsIm5iZiI6MTc1MTYzNTQzNS44NzM5OTk4LCJzdWIiOiI2ODY3ZDVlYmUzZDMxMmU1OGI2NzczNmYiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.etziZE5AbWlUmsjFWwTWJ5C0GKYHqLb31kYzS6IwFXU")
            .build()
    }

    private fun getBetterImageUrl(url: String): String {
        if (url.isBlank()) return ""
        if (url.contains("ftpbd.net/wp-content/uploads/")) {
            // Extract TMDb hash
            val filename = url.substringAfterLast("/")
            val hash = filename.substringBefore("-").substringBefore(".")
            if (hash.length >= 20) {
                return "https://image.tmdb.org/t/p/w500/$hash.jpg"
            }
        }
        return fixUrl(url)
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

    @Serializable
    data class TmdbData(
        val id: Int? = null,
        val title: String? = null,
        val name: String? = null,
        val overview: String? = null,
        @SerialName("poster_path") val posterPath: String? = null,
        @SerialName("vote_average") val voteAverage: Double? = null,
        @SerialName("release_date") val releaseDate: String? = null,
        @SerialName("first_air_date") val firstAirDate: String? = null
    ) {
        val displayTitle: String get() = title ?: name ?: ""
    }

    @Serializable
    data class TmdbSearchResponse(
        val results: List<TmdbData>
    )

    @Serializable
    data class TmdbFindResponse(
        @SerialName("movie_results") val movieResults: List<TmdbData>,
        @SerialName("tv_results") val tvResults: List<TmdbData>
    )

    @Serializable
    data class TmdbEpisodeData(
        val name: String? = null,
        val overview: String? = null,
        @SerialName("episode_number") val episodeNumber: Int? = null,
        @SerialName("still_path") val stillPath: String? = null,
        @SerialName("vote_average") val voteAverage: Double? = null
    )

    @Serializable
    data class TmdbSeasonData(
        val episodes: List<TmdbEpisodeData>? = null
    )

    // ============================== Popular ===============================
    override fun popularAnimeRequest(page: Int): Request = GET("https://server3.ftpbd.net/FTP-3/Hindi%20Movies/2025/")

    override suspend fun getPopularAnime(page: Int): AnimesPage {
        val response = client.newCall(popularAnimeRequest(page)).awaitSuccess()
        val pageResults = popularAnimeParse(response)
        val animeList = pageResults.anime
        
        return coroutineScope {
            val updatedList = animeList.map { sAnime ->
                async(Dispatchers.IO) {
                    val thumb = sAnime.thumbnail_url
                    if (thumb == null || thumb.isBlank() || thumb.contains("a11.jpg")) {
                        val betterThumb = getTmdbImageUrl(sAnime.title)
                        if (betterThumb != null) {
                            sAnime.thumbnail_url = betterThumb
                        }
                    }
                    sAnime
                }
            }.awaitAll()
            AnimesPage(updatedList, pageResults.hasNextPage)
        }
    }

    override fun popularAnimeParse(response: Response): AnimesPage {
        val document = response.asJsoup()
        val animeList = mutableListOf<SAnime>()
        val isSearch = response.request.url.toString().contains("?s=")

        // Check for directory listing or WordPress grid
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
                    
                    val img = element.selectFirst("img[src~=(?i)a11|a_al|poster|banner|thumb], .post-image img, .post-media img, .jws-post-image img, img:not([src~=(?i)back|folder|parent|icon|/icons/])")
                    val rawThumb = img?.attr("abs:data-src")?.ifBlank { null }
                        ?: img?.attr("abs:data-lazy-src")?.ifBlank { null }
                        ?: img?.attr("abs:src")
                    
                    this.thumbnail_url = getBetterImageUrl(rawThumb ?: "")
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
                        val thumbBase = if (url.endsWith("/")) url else "$url/"
                        this.thumbnail_url = getBetterImageUrl(thumbBase + "a11.jpg")
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
    
    override suspend fun getLatestUpdates(page: Int): AnimesPage {
        val response = client.newCall(latestUpdatesRequest(page)).awaitSuccess()
        val pageResults = latestUpdatesParse(response)
        val animeList = pageResults.anime
        
        return coroutineScope {
            val updatedList = animeList.map { sAnime ->
                async(Dispatchers.IO) {
                    val thumb = sAnime.thumbnail_url
                    if (thumb == null || thumb.isBlank() || thumb.contains("a11.jpg")) {
                        val betterThumb = getTmdbImageUrl(sAnime.title)
                        if (betterThumb != null) {
                            sAnime.thumbnail_url = betterThumb
                        }
                    }
                    sAnime
                }
            }.awaitAll()
            AnimesPage(updatedList, pageResults.hasNextPage)
        }
    }

    override fun latestUpdatesParse(response: Response): AnimesPage = popularAnimeParse(response)

    // =============================== Search ===============================
    override suspend fun getSearchAnime(page: Int, query: String, filters: AnimeFilterList): AnimesPage {
        if (query.isBlank()) return super.getSearchAnime(page, query, filters)

        return coroutineScope {
            val searchPaths = listOf(
                "https://server3.ftpbd.net/FTP-3/Hindi%20Movies/2025/",
                "https://server3.ftpbd.net/FTP-3/Hindi%20Movies/2024/",
                "https://server3.ftpbd.net/FTP-3/Hindi%20Movies/2023/",
                "https://server3.ftpbd.net/FTP-3/Hindi%20Movies/2022/",
                "https://server3.ftpbd.net/FTP-3/Hindi%20Movies/2021/",
                "https://server3.ftpbd.net/FTP-3/Hindi%20Movies/2020/",
                "https://server3.ftpbd.net/FTP-3/Hindi%20Movies/Hindi-4K-Movies/",
                "https://server3.ftpbd.net/FTP-3/Hindi%20TV%20Series/",
                "https://server3.ftpbd.net/FTP-3/South%20Indian%20Movies/2025/",
                "https://server3.ftpbd.net/FTP-3/South%20Indian%20Movies/2024/",
                "https://server3.ftpbd.net/FTP-3/South%20Indian%20TV%20Serias/",
                "https://server3.ftpbd.net/FTP-3/Foreign%20Language%20Movies/2025/",
                "https://server3.ftpbd.net/FTP-3/Foreign%20Language%20Movies/2024/",
                "https://server3.ftpbd.net/FTP-3/Bangla%20Collection/BANGLA/",
                "https://server2.ftpbd.net/FTP-2/English%20Movies/2025/",
                "https://server2.ftpbd.net/FTP-2/English%20Movies/2024/",
                "https://server2.ftpbd.net/FTP-2/English%20Movies/2023/",
                "https://server2.ftpbd.net/FTP-2/English%20Movies/2022/",
                "https://server2.ftpbd.net/FTP-2/English%20Movies/English-Movies-4K/",
                "https://server4.ftpbd.net/FTP-4/English-Foreign-TV-Series/",
                "https://server5.ftpbd.net/FTP-5/Anime--Cartoon-TV-Series/",
                "https://server5.ftpbd.net/FTP-5/Animation%20Movies/"
            )

            val semaphore = Semaphore(20)
            val results = searchPaths.map { path ->
                async(Dispatchers.IO) {
                    semaphore.withPermit {
                        try {
                            val response = client.newCall(GET(path, getGlobalHeaders())).execute()
                            if (!response.isSuccessful) return@withPermit emptyList<SAnime>()
                            val doc = response.asJsoup()
                            parseSearchDocument(doc, query, path)
                        } catch (e: Exception) {
                            emptyList<SAnime>()
                        }
                    }
                }
            }.awaitAll().flatten().distinctBy { it.url }

            val finalResults = results.map { sAnime ->
                async(Dispatchers.IO) {
                    if (sAnime.thumbnail_url?.contains("a11.jpg") == true) {
                        val betterThumb = getTmdbImageUrl(sAnime.title)
                        if (betterThumb != null) {
                            sAnime.thumbnail_url = betterThumb
                        }
                    }
                    sAnime
                }
            }.awaitAll()

            AnimesPage(sortByTitle(finalResults, query), false)
        }
    }

    private fun parseSearchDocument(document: Document, query: String, path: String): List<SAnime> {
        val animeList = mutableListOf<SAnime>()
        val isSeries = path.contains("Series", true) || path.contains("Serias", true) || path.contains("Anime", true)
        val normalizedQuery = query.lowercase()
        
        document.select("td.fb-n a, div.entry-content a, table tr a").forEach { link ->
            var title = link.text().trim()
            if (title.isBlank() || isIgnored(title) || title == "Parent Directory") return@forEach
            if (title.endsWith("/")) title = title.removeSuffix("/")
            
            // Dice coefficient check for fuzzy matching
            val score = diceCoefficient(title, normalizedQuery)
            if (score > 0.3 || title.lowercase().contains(normalizedQuery)) {
                val url = link.attr("abs:href")
                if (url.contains("?") || url.endsWith("..")) return@forEach
                
                animeList.add(SAnime.create().apply {
                    this.title = title
                    this.url = fixUrl(url)
                    this.status = if (isSeries) SAnime.ONGOING else SAnime.COMPLETED
                    val finalUrl = if (this.url.endsWith("/")) this.url else "${this.url}/"
                    this.thumbnail_url = getBetterImageUrl("${finalUrl}a11.jpg")
                })
            }
        }
        return animeList
    }

    private fun sortByTitle(list: List<SAnime>, query: String): List<SAnime> {
        return list.sortedByDescending { diceCoefficient(it.title, query) }
    }

    private fun cleanTitle(name: String): String {
        return name
            // Remove anything in parentheses
            .replace(Regex("\\([^)]*\\)"), "")
            // Remove anything in square brackets
            .replace(Regex("\[[^\]]*\]"), "")
            // Remove quality indicators
            .replace(Regex("(?i)(480p|720p|1080p|2160p|4k|uhd|hdr|web-?dl|blu-?ray|dvdrip|brrip|webrip).*?(?=\\s|$)"), "")
            // Remove episode/season markers
            .replace(Regex("(?i)(s\\d{1,2}e\\d{1,2}|season\\s*\\d+|episode\\s*\\d+).*?(?=\\s|$)"), "")
            // Remove status indicators
            .replace(Regex("(?i)(complete|completed|ongoing|batch|repack|dual.audio|multi.sub|subtitle).*?(?=\\s|$)"), "")
            // Remove file extensions
            .replace(Regex("\\.(?:mp4|mkv|avi|mov|wmv)$"), "")
            // Remove multiple spaces and trim
            .replace(Regex("\\s+"), " ")
            .trim()
    }

    private fun calculateSimilarity(s1: String, s2: String): Double {
        val shorter = if (s1.length < s2.length) s1.lowercase() else s2.lowercase()
        val longer = if (s1.length < s2.length) s2.lowercase() else s1.lowercase()
        
        if (shorter.length < 2) return if (longer.contains(shorter)) 0.5 else 0.0
        
        // If the longer string contains the shorter one entirely
        if (longer.contains(shorter)) return 1.0
        
        // Count matching words
        val words1 = s1.lowercase().split(" ").filter { it.length > 2 }
        val words2 = s2.lowercase().split(" ").filter { it.length > 2 }
        
        if (words1.isEmpty() || words2.isEmpty()) return 0.0
        
        var matches = 0
        for (word in words1) {
            if (words2.any { it.contains(word) || word.contains(it) }) {
                matches++
            }
        }
        
        return matches.toDouble() / maxOf(words1.size, words2.size)
    }

    private fun diceCoefficient(s1: String, s2: String): Double {
        val str1 = s1.lowercase()
        val str2 = s2.lowercase()
        if (str1.length < 2 || str2.length < 2) return if (str1.contains(str2) || str2.contains(str1)) 0.5 else 0.0
        
        val pairs1 = (0 until str1.length - 1).map { str1.substring(it, it + 2) }.toSet()
        val pairs2 = (0 until str2.length - 1).map { str2.substring(it, it + 2) }
        
        var intersection = 0
        for (pair in pairs2) {
            if (pair in pairs1) intersection++
        }
        
        return 2.0 * intersection / (pairs1.size + pairs2.size)
    }

    override fun searchAnimeRequest(page: Int, query: String, filters: AnimeFilterList): Request {
        return GET(Filters.getUrl(query, filters), getGlobalHeaders())
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
                       val img = document.selectFirst("div.jws-images img, img[src~=(?i)a11|a_al|poster|banner|thumb], img:not([src~=(?i)back|folder|parent|icon|/icons/])")
                       var thumb = img?.attr("abs:src")
                       if (thumb.isNullOrBlank()) {
                           thumb = document.selectFirst("a[href~=(?i)\\.(jpg|jpeg|png|webp)]:not([href~=(?i)back|folder|parent|icon])")?.attr("abs:href")
                       }
                       thumbnail_url = getBetterImageUrl(thumb ?: "")
                   }
        
        val tmdbData = runBlocking { getTmdbData(anime.title, document) }
        if (tmdbData != null) {
            tmdbData.posterPath?.let { anime.thumbnail_url = "https://image.tmdb.org/t/p/w500$it" }
            tmdbData.overview?.let { if (anime.description.isNullOrBlank()) anime.description = it }
            tmdbData.voteAverage?.let { anime.status = if (it > 0) SAnime.COMPLETED else SAnime.UNKNOWN }
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
        thumbnail_url = getBetterImageUrl(document.select("div.jws-images img, figure.movie-detail-banner img, .movie-detail-banner img, .col-md-3 img, .poster img")
            .attr("abs:src"))
        genre = document.select("div.ganre-wrapper a").joinToString { it.text().replace(",", "").trim() }
        description = document.select("p.storyline").text().trim()
    }

    private fun getSeriesDetails(document: Document) = SAnime.create().apply {
        status = SAnime.ONGOING
        thumbnail_url = getBetterImageUrl(document.select("div.jws-images img, figure.movie-detail-banner img, .movie-detail-banner img, .col-md-3 img, .poster img")
            .attr("abs:src"))
        genre = document.select("div.ganre-wrapper a").joinToString { it.text().replace(",", "").trim() }
        description = document.select("p.storyline").text().trim()
    }

    private fun getTmdbImageUrl(title: String, document: Document? = null): String? {
        return runBlocking { getTmdbData(title, document)?.posterPath?.let { "https://image.tmdb.org/t/p/w500$it" } }
    }

    private suspend fun getTmdbData(title: String, document: Document? = null): TmdbData? {
        val key = tmdbApiKey
        if (key.isBlank()) return null
        
        if (document != null) {
            val html = document.html()
            
            // 1. Try TMDb ID from HTML
            val tmdbIdMatch = Regex("""themoviedb\\.org/(movie|tv)/(\\d+)""" ).find(html)
            if (tmdbIdMatch != null) {
                val type = tmdbIdMatch.groupValues[1]
                val id = tmdbIdMatch.groupValues[2]
                try {
                    delay(250)
                    val res = client.newCall(GET("https://api.themoviedb.org/3/$type/$id", tmdbHeaders)).execute()
                    if (res.isSuccessful) return res.parseAs<TmdbData>()
                } catch (e: Exception) {}
            }

            // 2. Try IMDb ID from HTML
            val imdbIdMatch = Regex("""imdb\\.com/title/(tt\\d+)""" ).find(html) ?: Regex("(tt\\d{7,9})" ).find(html)
            if (imdbIdMatch != null) {
                val imdbId = imdbIdMatch.groupValues[1]
                try {
                    delay(250)
                    val res = client.newCall(GET("https://api.themoviedb.org/3/find/$imdbId?external_source=imdb_id", tmdbHeaders)).execute()
                    if (res.isSuccessful) {
                        val findRes = res.parseAs<TmdbFindResponse>()
                        return findRes.movieResults.firstOrNull() ?: findRes.tvResults.firstOrNull()
                    }
                } catch (e: Exception) {}
            }
        }

        // 3. Fallback to title search
        val cleaned = cleanTitle(title)
        val yearMatch = Regex("\\((\\d{4})\\)").find(title)
        val year = yearMatch?.groupValues?.get(1)
        
        // Try Movie search
        var movieUrl = "https://api.themoviedb.org/3/search/movie?query=${URLEncoder.encode(cleaned, "UTF-8")}"
        if (year != null) movieUrl += "&primary_release_year=$year"
        
        try {
            delay(250)
            val res = client.newCall(GET(movieUrl, tmdbHeaders)).execute()
            if (res.isSuccessful) {
                val searchRes = res.parseAs<TmdbSearchResponse>()
                val best = pickBestTmdbResult(searchRes.results, cleaned)
                if (best != null) return best
            }
        } catch (e: Exception) {}

        // Try TV search
        var tvUrl = "https://api.themoviedb.org/3/search/tv?query=${URLEncoder.encode(cleaned, "UTF-8")}"
        if (year != null) tvUrl += "&first_air_date_year=$year"
        
        try {
            delay(250)
            val res = client.newCall(GET(tvUrl, tmdbHeaders)).execute()
            if (res.isSuccessful) {
                val searchRes = res.parseAs<TmdbSearchResponse>()
                val best = pickBestTmdbResult(searchRes.results, cleaned)
                if (best != null) return best
            }
        } catch (e: Exception) {}

        return null
    }

    private fun pickBestTmdbResult(results: List<TmdbData>, query: String): TmdbData? {
        return results.map {
            val similarity = calculateSimilarity(query, it.displayTitle)
            Pair(it, similarity)
        }.filter { it.second > 0.5 }
         .maxByOrNull { it.second }
         ?.first
    }

    // ============================== Episodes ==============================
    override suspend fun getEpisodeList(anime: SAnime): List<SEpisode> {
        val response = client.newCall(GET(anime.url, getGlobalHeaders())).awaitSuccess()
        val document = response.asJsoup()
        val mediaType = getMediaType(document)
        
        val tmdbData = getTmdbData(anime.title, document)
        
        val episodes = when (mediaType) {
            "s" -> {
                val list = extractEpisode(document)
                if (list.isEmpty()) getDirectoryEpisodes(document) else list.reversed()
            }
            "m" -> getMovieMedia(document)
            else -> getDirectoryEpisodes(document)
        }

        if (tmdbData != null && tmdbData.id != null) {
            return mapTmdbEpisodes(episodes, tmdbData.id)
        }
        
        return episodes
    }

    private val seasonMap = mutableMapOf<Int, TmdbSeasonData?>()
    private val seasonMutex = Mutex()

    private suspend fun mapTmdbEpisodes(episodes: List<SEpisode>, tmdbId: Int): List<SEpisode> {
        return coroutineScope {
            episodes.map { episode ->
                async(Dispatchers.IO) {
                    val sEp = parseSeasonEpisode(episode.name)
                    if (sEp != null) {
                        val seasonNum = sEp.first
                        val episodeNum = sEp.second
                        
                        val seasonData = seasonMutex.withLock {
                            seasonMap[seasonNum]
                        } ?: fetchTmdbSeason(tmdbId, seasonNum).also {
                            seasonMutex.withLock {
                                seasonMap[seasonNum] = it
                            }
                        }
                        
                        val tmdbEp = seasonData?.episodes?.find { it.episodeNumber == episodeNum }
                        if (tmdbEp != null) {
                            episode.name = "S${seasonNum}E${episodeNum} - ${tmdbEp.name}"
                            if (episode.scanlator.isNullOrBlank()) {
                                episode.scanlator = tmdbEp.voteAverage?.toString()
                            }
                        }
                    }
                    episode
                }
            }.awaitAll()
        }
    }

    private fun parseSeasonEpisode(name: String): Pair<Int, Int>? {
        val pattern = Regex("(?i)S(\\d{1,2})\\s*E(\\d{1,3})")
        val match = pattern.find(name)
        if (match != null) {
            return Pair(match.groupValues[1].toInt(), match.groupValues[2].toInt())
        }
        
        val pattern2 = Regex("(?i)Season\\s*(\\d+).*?Episode\\s*(\\d+)", RegexOption.IGNORE_CASE)
        val match2 = pattern2.find(name)
        if (match2 != null) {
            return Pair(match2.groupValues[1].toInt(), match2.groupValues[2].toInt())
        }
        
        return null
    }

    private suspend fun fetchTmdbSeason(tmdbId: Int, seasonNum: Int): TmdbSeasonData? {
        val url = "https://api.themoviedb.org/3/tv/$tmdbId/season/$seasonNum"
        return try {
            delay(250)
            val res = client.newCall(GET(url, tmdbHeaders)).execute()
            if (res.isSuccessful) res.parseAs<TmdbSeasonData>() else null
        } catch (e: Exception) {
            null
        }
    }

    private fun extractEpisode(document: Document): List<SEpisode> {
        val docUrl = document.location()
        return document.select("div.card, div.episode-item, div.download-link").mapNotNull { element ->
            val titleElement = element.selectFirst("h5")
            val name = titleElement?.ownText()?.substringBefore("&nbsp;")?.trim() ?: ""
            val url = element.selectFirst("h5 a")?.let {
                val href = it.attr("abs:href")
                if (href.isBlank()) {
                    val r = it.attr("href")
                    if (r.startsWith("http")) r else docUrl.removeSuffix("/") + "/" + r.removePrefix("/")
                } else href
            }?.trim() ?: ""
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
        val docUrl = document.location()
        val link = document.select("div.col-md-12 a.btn, .movie-buttons a, a[href*=/m/lazyload/], a[href*=/s/lazyload/], .download-link a").lastOrNull()
        val url = link?.let {
            val href = it.attr("abs:href")
            if (href.isBlank()) {
                val r = it.attr("href")
                if (r.startsWith("http")) r else docUrl.removeSuffix("/") + "/" + r.removePrefix("/")
            } else href
        }?.replace(" ", "%20") ?: ""
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

        document.select("a[href]").forEach {
            val href = it.attr("abs:href").ifBlank {
                val r = it.attr("href")
                if (r.startsWith("http")) r else currentUrl.removeSuffix("/") + "/" + r.removePrefix("/")
            }
            val text = it.text().trim()
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