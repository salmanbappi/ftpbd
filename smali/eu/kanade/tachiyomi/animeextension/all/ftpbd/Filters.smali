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

    new-instance v1, Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;
    invoke-direct {v1, v0}, Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;-><init>(Ljava/util/List;)V
    return-object v1
.end method

.method public static getUrl(Ljava/lang/String;Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;)Ljava/lang/String;
    .locals 2

    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_search
    return-object p0

:cond_search
    if-nez p1, :cond_default
    const-string p0, "https://server3.ftpbd.net/"
    return-object p0

:cond_default
    const/4 v0, 0x1
    invoke-virtual {p1, v0}, Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;->get(I)Ljava/lang/Object;
    move-result-object p1
    check-cast p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBdSelect;
    invoke-virtual {p1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBdSelect;->getState()Ljava/lang/Object;
    move-result-object p1
    check-cast p1, Ljava/lang/Integer;
    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I
    move-result p1

    packed-switch p1, :pswitch_data_cat
    const-string p0, "https://server3.ftpbd.net/"
    return-object p0

    :pswitch_cat0 # All
    const-string p0, "https://server3.ftpbd.net/"
    return-object p0
    :pswitch_cat1 # Bangla Collection
    const-string p0, "https://server3.ftpbd.net/FTP-3/Bangla%20Collection/"
    return-object p0
    :pswitch_cat2 # Foreign Language Movies
    const-string p0, "https://server3.ftpbd.net/FTP-3/Foreign%20Language%20Movies/"
    return-object p0
    :pswitch_cat3 # Hindi Movies
    const-string p0, "https://server3.ftpbd.net/FTP-3/Hindi%20Movies/"
    return-object p0
    :pswitch_cat4 # Hindi TV Series
    const-string p0, "https://server3.ftpbd.net/FTP-3/Hindi%20TV%20Series/"
    return-object p0
    :pswitch_cat5 # South Indian Movies
    const-string p0, "https://server3.ftpbd.net/FTP-3/South%20Indian%20Movies/"
    return-object p0
    :pswitch_cat6 # South Indian TV Serias
    const-string p0, "https://server3.ftpbd.net/FTP-3/South%20Indian%20TV%20Serias/"
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
    .end packed-switch
.end method
