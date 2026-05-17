package eu.kanade.tachiyomi.animeextension.all.ftpbd

import eu.kanade.tachiyomi.animesource.AnimeSource
import eu.kanade.tachiyomi.animesource.AnimeSourceFactory

class FtpBdFactory : AnimeSourceFactory {
    override fun createSources(): List<AnimeSource> = listOf(
        FtpBd(
            "FTPBD (Movies)",
            "https://server3.ftpbd.net",
            0x53334654504244L,
            "FTP-3/Hindi%20Movies/2025/",
            listOf(
                "FTP-3/Hindi%20Movies/2025/",
                "FTP-3/Hindi%20Movies/2024/",
                "FTP-3/Hindi%20Movies/2023/",
                "FTP-3/Hindi%20Movies/Hindi-4K-Movies/",
                "FTP-3/Hindi%20TV%20Series/",
                "FTP-3/South%20Indian%20Movies/2025/",
                "FTP-3/Foreign%20Language%20Movies/2025/",
                "FTP-3/Bangla%20Collection/",
                "FTP-3/%5BToday%27s%20Upload%5D/"
            ),
            FilterData.S3_CATEGORIES
        ),
        FtpBd(
            "FTPBD (English)",
            "https://server2.ftpbd.net",
            0x53324654504244L,
            "FTP-2/English%20Movies/2025/",
            listOf(
                "FTP-2/English%20Movies/2025/",
                "FTP-2/English%20Movies/English-Movies-4K/",
                "FTP-2/English%20Movies/Dual-Audio/",
                "FTP-2/English%20Movies/IMDB%20TOP%20250/",
                "FTP-2/3D%20Movies/"
            ),
            FilterData.S2_CATEGORIES
        ),
        FtpBd(
            "FTPBD (Anime)",
            "https://server5.ftpbd.net",
            0x53354654504244L,
            "FTP-5/Anime--Cartoon-TV-Series/",
            listOf(
                "FTP-5/Anime--Cartoon-TV-Series/",
                "FTP-5/Animation%20Movies/",
                "FTP-5/Documentary/"
            ),
            FilterData.S5_CATEGORIES
        ),
        FtpBd(
            "FTPBD (Series & Tutorial)",
            "https://server4.ftpbd.net",
            0x53344654504244L,
            "FTP-4/English-Foreign-TV-Series/",
            listOf(
                "FTP-4/English-Foreign-TV-Series/",
                "FTP-4/Tutorial/"
            ),
            FilterData.S4_CATEGORIES
        ),
        FtpBd(
            "FTPBD (Sports)",
            "https://server7.ftpbd.net",
            0x53374654504244L,
            "FTP-7/WWE%20Wrestling/",
            listOf(
                "FTP-7/WWE%20Wrestling/",
                "FTP-7/All%20Elite%20Wrestling%20%28AEW%29/",
                "FTP-7/Ultimate%20Fighting%20Championship%20%28UFC%29/",
                "FTP-7/Awards--TV-Shows/"
            ),
            FilterData.S7_CATEGORIES
        )
    )
}
