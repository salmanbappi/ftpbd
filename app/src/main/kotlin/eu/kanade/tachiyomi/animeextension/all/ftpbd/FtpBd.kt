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

    override val lang = "all"

    override val supportsLatest = true

    override val id: Long = 0x53334654504244L

    private val preferences: SharedPreferences by getPreferencesLazy()

    private val cm by lazy { CookieManager(network.client) }

    override val client: OkHttpClient = network.client.newBuilder()
        .addInterceptor { chain ->
            val request = chain.request()
            val url = request.url.toString()
            val host = try { url.toHttpUrl().host } catch (e: Exception) { "" }
            
            if (host.isNotBlank()) {
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
        screen.addEditTextPreference(
            key = "base_url",
            title = "Base URL",
            summary = "The server URL to use (e.g., https://server3.ftpbd.net)",
            default = "https://server3.ftpbd.net",
        )
    }

    // ============================== Popular ===============================
    override fun popularAnimeRequest(page: Int): Request = GET("$baseUrl/FTP-3/Hindi%20Movies/2025/", getGlobalHeaders())

    override fun popularAnimeParse(response: Response): AnimesPage {
        val document = response.asJsoup()
        val animeList = mutableListOf<SAnime>()
        val isSearch = response.request.url.toString().contains("?s=")

        // Optimized directory parsing (no images)
        val docUrl = document.location()
        document.select("td.fb-n a, div.entry-content a, table tr a").forEach { it ->
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
                this.thumbnail_url = "" // No images
            }
            animeList.add(anime)
        }
        return AnimesPage(animeList, false)
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

        return coroutineScope {
            val host = try { baseUrl.toHttpUrl().host } catch (e: Exception) { "server3.ftpbd.net" }
            val searchPaths = listOf(
                "https://$host/FTP-3/Hindi%20Movies/2025/",
                "https://$host/FTP-3/Hindi%20Movies/2024/",
                "https://$host/FTP-3/Hindi%20TV%20Series/",
                "https://$host/FTP-3/South%20Indian%20Movies/2025/",
                "https://$host/FTP-3/Foreign%20Language%20Movies/2025/",
                "https://$host/FTP-3/Bangla%20Collection/BANGLA/"
            )

            val semaphore = Semaphore(10)
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

            AnimesPage(sortByTitle(results, query), false)
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
        return list.sortedByDescending { it.title.lowercase().startsWith(normalizedQuery) }
    }

    private fun diceCoefficient(s1: String, s2: String): Double {
        val str1 = s1.lowercase()
        val str2 = s2.lowercase()
        if (str1.length < 2 || str2.length < 2) return if (str1.contains(str2) || str2.contains(str1)) 0.5 else 0.0
        val pairs1 = (0 until str1.length - 1).map { str1.substring(it, it + 2) }.toSet()
        val pairs2 = (0 until str2.length - 1).map { str2.substring(it, it + 2) }
        var intersection = 0
        for (pair in pairs2) if (pair in pairs1) intersection++
        return 2.0 * intersection / (pairs1.size + pairs2.size)
    }

    override fun searchAnimeRequest(page: Int, query: String, filters: AnimeFilterList): Request {
        return GET(Filters.getUrl(baseUrl, query, filters), getGlobalHeaders())
    }

    override fun searchAnimeParse(response: Response): AnimesPage = popularAnimeParse(response)

    // ============================== Details ===============================
    override fun animeDetailsParse(response: Response): SAnime {
        val document = response.asJsoup()
        return SAnime.create().apply {
            status = SAnime.UNKNOWN
            thumbnail_url = ""
            description = document.select("p.storyline").text().trim().ifBlank { "No description available." }
        }
    }

    // ============================== Episodes ==============================
    override suspend fun getEpisodeList(anime: SAnime): List<SEpisode> {
        val response = client.newCall(GET(anime.url, getGlobalHeaders())).awaitSuccess()
        val document = response.asJsoup()
        return getDirectoryEpisodes(document)
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
        return listOf(Video(episode.url, "Video", episode.url))
    }

    override fun videoListParse(response: Response): List<Video> = throw UnsupportedOperationException()

    override fun getFilterList() = Filters.getFilterList()

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

    fun getUrl(baseUrl: String, query: String, filters: AnimeFilterList): String {
        val cat = (filters[1] as CategorySelect).state
        val year = (filters[3] as YearSelect).state
        val lang = (filters[5] as LanguageSelect).state

        var url = when (cat) {
            0 -> "$baseUrl/FTP-3/Hindi%20Movies/"
            1 -> "$baseUrl/../FTP-2/English%20Movies/" // Hacky path but following logic
            2 -> "$baseUrl/FTP-3/Bangla%20Collection/"
            3 -> {
                if (lang > 0) {
                    return "$baseUrl/FTP-3/Foreign%20Language%20Movies/${FilterData.LANGUAGES[lang].replace(" ", "%20")}/"
                }
                "$baseUrl/FTP-3/Foreign%20Language%20Movies/"
            }
            4 -> "$baseUrl/FTP-3/South%20Indian%20Movies/"
            5 -> "$baseUrl/FTP-3/Hindi%20TV%20Series/"
            else -> "$baseUrl/"
        }

        if (year > 0) {
            url += "${FilterData.YEARS[year].replace(" ", "%20")}/"
        }
        return url
    }
}

object FilterData {
    val CATEGORIES = arrayOf(
        "Hindi Movies", "English Movies", "Bangla Collection", "Foreign Language Movies",
        "South Indian Movies", "Hindi TV Series"
    )

    val YEARS = arrayOf(
        "Any", "2025", "2024", "2023", "2022", "2021", "2020", "2019", "2018", "2017"
    )

    val LANGUAGES = arrayOf(
        "Any", "Arabic Language", "Chinese-Language", "French-Language", "German-Language", "Japanese-Language", "Korean-Language"
    )
}
