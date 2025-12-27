.class public Leu/kanade/tachiyomi/animeextension/all/ftpbd/Filters;
.super Ljava/lang/Object;
.source "Filters.smali"

.method public static getFilterList()Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;
    .locals 4
    new-instance v0, Ljava/util/ArrayList;
    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V
    new-instance v1, Leu/kanade/tachiyomi/animesource/model/AnimeFilter$Header;
    const-string v2, "Category"
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

    if-eqz p0, :cond_check_empty
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z
    move-result v0
    if-nez v0, :cond_check_empty
    const-string p0, "https://server3.ftpbd.net/"
    return-object p0

:cond_check_empty
    const/4 v0, 0x1
    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;
    move-result-object p1
    check-cast p1, Leu/kanade/tachiyomi/animesource/model/AnimeFilter$Select;
    invoke-virtual {p1}, Leu/kanade/tachiyomi/animesource/model/AnimeFilter;->getState()Ljava/lang/Object;
    move-result-object p1
    check-cast p1, Ljava/lang/Integer;
    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I
    move-result p1
    packed-switch p1, :pswitch_data_0

    :pswitch_0
    const-string p0, "https://server3.ftpbd.net/"
    return-object p0

    :pswitch_1
    const-string p0, "https://server2.ftpbd.net/FTP-2/English%20Movies/"
    return-object p0

    :pswitch_2
    const-string p0, "https://server3.ftpbd.net/FTP-3/Hindi%20Movies/"
    return-object p0

    :pswitch_3
    const-string p0, "https://server3.ftpbd.net/FTP-3/Bangla%20Collection/BANGLA/"
    return-object p0

    :pswitch_4
    const-string p0, "https://server3.ftpbd.net/FTP-3/South%20Indian%20Movies/"
    return-object p0

    :pswitch_5
    const-string p0, "https://server5.ftpbd.net/FTP-5/Animation%20Movies/"
    return-object p0

    :pswitch_6
    const-string p0, "https://server4.ftpbd.net/FTP-4/English-Foreign-TV-Series/"
    return-object p0

    :pswitch_7
    const-string p0, "https://server5.ftpbd.net/FTP-5/Anime--Cartoon-TV-Series/"
    return-object p0

    :pswitch_8
    const-string p0, "https://server3.ftpbd.net/FTP-3/Hindi%20TV%20Series/"
    return-object p0

    :pswitch_9
    const-string p0, "https://server3.ftpbd.net/FTP-3/Bangla%20Collection/BANGLA/Web%20Series/"
    return-object p0

    :pswitch_10
    const-string p0, "https://server5.ftpbd.net/FTP-5/Documentary/"
    return-object p0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_8
        :pswitch_9
        :pswitch_10
    .end packed-switch
.end method