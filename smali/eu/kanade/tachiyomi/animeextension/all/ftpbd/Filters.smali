.class public Leu/kanade/tachiyomi/animeextension/all/ftpbd/Filters;
.super Ljava/lang/Object;

.method public static getFilterList()Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;
    .locals 4
    new-instance v0, Ljava/util/ArrayList;
    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    new-instance v1, Leu/kanade/tachiyomi/animesource/model/AnimeFilter$Header;
    const-string v2, "--- Category ---"
    invoke-direct {v1, v2}, Leu/kanade/tachiyomi/animesource/model/AnimeFilter$Header;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBdSelect;
    const-string v2, "Select Category"
    sget-object v3, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FilterData;->CATEGORIES:[Ljava/lang/String;
    check-cast v3, [Ljava/lang/Object;
    invoke-direct {v1, v2, v3}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBdSelect;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v1, Leu/kanade/tachiyomi/animesource/model/AnimeFilter$Header;
    const-string v2, "--- Year ---"
    invoke-direct {v1, v2}, Leu/kanade/tachiyomi/animesource/model/AnimeFilter$Header;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBdSelect;
    const-string v2, "Select Year"
    sget-object v3, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FilterData;->YEARS:[Ljava/lang/String;
    check-cast v3, [Ljava/lang/Object;
    invoke-direct {v1, v2, v3}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBdSelect;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v1, Leu/kanade/tachiyomi/animesource/model/AnimeFilter$Header;
    const-string v2, "--- Language (Foreign Lang. only) ---"
    invoke-direct {v1, v2}, Leu/kanade/tachiyomi/animesource/model/AnimeFilter$Header;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBdSelect;
    const-string v2, "Select Language"
    sget-object v3, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FilterData;->LANGUAGES:[Ljava/lang/String;
    check-cast v3, [Ljava/lang/Object;
    invoke-direct {v1, v2, v3}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBdSelect;-><init>(Ljava/lang/String;[Ljava/lang/Object;)V
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v1, Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;
    invoke-direct {v1, v0}, Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;-><init>(Ljava/util/List;)V
    return-object v1
.end method

.method public static getUrl(Ljava/lang/String;Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;)Ljava/lang/String;
    .locals 4

    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_search

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "https://ftpbd.net/?s="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "UTF-8"

    invoke-static {p0, v1}, Ljava/net/URLEncoder;->encode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

:cond_search
    if-nez p1, :cond_default

    const-string p0, "https://server3.ftpbd.net/FTP-3/Hindi%20Movies/2025/"

    return-object p0

:cond_default
    const/4 v0, 0x1
    invoke-virtual {p1, v0}, Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;->get(I)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBdSelect;
    invoke-virtual {v0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBdSelect;->getState()Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Ljava/lang/Integer;
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I
    move-result v0

    const/4 v1, 0x3
    invoke-virtual {p1, v1}, Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;->get(I)Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBdSelect;
    invoke-virtual {v1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBdSelect;->getState()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Ljava/lang/Integer;
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I
    move-result v1

    const/4 v2, 0x5
    invoke-virtual {p1, v2}, Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;->get(I)Ljava/lang/Object;
    move-result-object p1
    check-cast p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBdSelect;
    invoke-virtual {p1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBdSelect;->getState()Ljava/lang/Object;
    move-result-object p1
    check-cast p1, Ljava/lang/Integer;
    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I
    move-result p1

    packed-switch v0, :pswitch_data_cat
    const-string p0, "https://server3.ftpbd.net/FTP-3/"
    goto :goto_year

    :pswitch_cat0 # Hindi Movies
    const-string p0, "https://server3.ftpbd.net/FTP-3/Hindi%20Movies/"
    goto :goto_year
    :pswitch_cat1 # English Movies
    const-string p0, "https://server2.ftpbd.net/FTP-2/English%20Movies/"
    goto :goto_year
    :pswitch_cat2 # Bangla Collection
    const-string p0, "https://server3.ftpbd.net/FTP-3/Bangla%20Collection/"
    goto :goto_year
    :pswitch_cat3 # Foreign Language Movies
    const-string p0, "https://server3.ftpbd.net/FTP-3/Foreign%20Language%20Movies/"
    if-lez p1, :cond_goto_year
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    sget-object p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FilterData;->LANGUAGES:[Ljava/lang/String;
    aget-object p0, p0, p1
    const-string p1, " "
    const-string v2, "%20"
    invoke-virtual {p0, p1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;
    move-result-object p0
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string p0, "/"
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p0
    return-object p0 # Language filter overrides Year
    :cond_goto_year
    goto :goto_year
    :pswitch_cat4 # South Indian Movies
    const-string p0, "https://server3.ftpbd.net/FTP-3/South%20Indian%20Movies/"
    goto :goto_year
    :pswitch_cat5 # Hindi TV Series
    const-string p0, "https://server3.ftpbd.net/FTP-3/Hindi%20TV%20Series/"
    goto :goto_year
    :pswitch_cat6 # South Indian TV Serias
    const-string p0, "https://server3.ftpbd.net/FTP-3/South%20Indian%20TV%20Serias/"
    goto :goto_year
    :pswitch_cat7 # English & Foreign TV Series
    const-string p0, "https://server4.ftpbd.net/FTP-4/English-Foreign-TV-Series/"
    goto :goto_year
    :pswitch_cat8 # Anime & Cartoon TV Series
    const-string p0, "https://server5.ftpbd.net/FTP-5/Anime--Cartoon-TV-Series/"
    goto :goto_year
    :pswitch_cat9 # Animation Movies
    const-string p0, "https://server5.ftpbd.net/FTP-5/Animation%20Movies/"
    goto :goto_year
    :pswitch_cat10 # 3D Movies
    const-string p0, "https://server2.ftpbd.net/FTP-2/3D%20Movies/"
    goto :goto_year
    :pswitch_cat11 # Documentary
    const-string p0, "https://server5.ftpbd.net/FTP-5/Documentary/"
    goto :goto_year
    :pswitch_cat12 # WWE Wrestling
    const-string p0, "https://server7.ftpbd.net/FTP-7/WWE%20Wrestling/"
    goto :goto_year
    :pswitch_cat13 # All Elite Wrestling (AEW)
    const-string p0, "https://server7.ftpbd.net/FTP-7/All%20Elite%20Wrestling%20%28AEW%29/"
    goto :goto_year
    :pswitch_cat14 # UFC
    const-string p0, "https://server7.ftpbd.net/FTP-7/Ultimate%20Fighting%20Championship%20%28UFC%29/"
    goto :goto_year
    :pswitch_cat15 # Awards & TV Shows
    const-string p0, "https://server7.ftpbd.net/FTP-7/Awards--TV-Shows/"
    goto :goto_year
    :pswitch_cat16 # Hindi 4K Movies
    const-string p0, "https://server3.ftpbd.net/FTP-3/Hindi%20Movies/Hindi-4K-Movies/"
    goto :goto_year
    :pswitch_cat17 # English 4K Movies
    const-string p0, "https://server2.ftpbd.net/FTP-2/English%20Movies/English-Movies-4K/"
    goto :goto_year
    :pswitch_cat18 # Dual Audio Movies
    const-string p0, "https://server2.ftpbd.net/FTP-2/English%20Movies/Dual-Audio/"
    goto :goto_year
    :pswitch_cat19 # IMDb Top 250
    const-string p0, "https://server2.ftpbd.net/FTP-2/English%20Movies/IMDB%20TOP%20250/"
    goto :goto_year
    :pswitch_cat20 # Tutorial
    const-string p0, "https://server4.ftpbd.net/FTP-4/Tutorial/"
    goto :goto_year
    :pswitch_cat21 # Today's Upload
    const-string p0, "https://server3.ftpbd.net/FTP-3/%5BToday%27s%20Upload%5D/"
    return-object p0

:goto_year
    if-lez v1, :cond_finish
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    sget-object p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FilterData;->YEARS:[Ljava/lang/String;
    aget-object p0, p0, v1
    const-string v1, " "
    const-string v2, "%20"
    invoke-virtual {p0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;
    move-result-object p0
    const-string v1, "&"
    const-string v2, "%26"
    invoke-virtual {p0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;
    move-result-object p0
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string p0, "/"
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p0

:cond_finish
    return-object p0

    :pswitch_data_cat
    .packed-switch 0x0
        :pswitch_cat0
        :pswitch_cat1
        :pswitch_cat2
        :pswitch_cat3
        :pswitch_cat4
        :pswitch_cat5
        :pswitch_cat6
        :pswitch_cat7
        :pswitch_cat8
        :pswitch_cat9
        :pswitch_cat10
        :pswitch_cat11
        :pswitch_cat12
        :pswitch_cat13
        :pswitch_cat14
        :pswitch_cat15
        :pswitch_cat16
        :pswitch_cat17
        :pswitch_cat18
        :pswitch_cat19
        :pswitch_cat20
        :pswitch_cat21
    .end packed-switch
.end method
