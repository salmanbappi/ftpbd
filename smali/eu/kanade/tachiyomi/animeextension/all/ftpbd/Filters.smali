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
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    const-string v1, "https://old.ftpbd.net/?s="
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, " "
    const-string v2, "+"
    invoke-virtual {p0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;
    move-result-object p0
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p0
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
    const-string p0, "https://old.ftpbd.net/page/1/"
    return-object p0

    :pswitch_1
    const-string p0, "https://old.ftpbd.net/category/movies/english-movies/"
    return-object p0

    :pswitch_2
    const-string p0, "https://old.ftpbd.net/category/movies/hindi-movies/"
    return-object p0

    :pswitch_3
    const-string p0, "https://old.ftpbd.net/category/movies/bangla-movies/"
    return-object p0

    :pswitch_4
    const-string p0, "https://old.ftpbd.net/category/movies/south-indian-movies/"
    return-object p0

    :pswitch_5
    const-string p0, "https://old.ftpbd.net/category/animation-movies/"
    return-object p0

    :pswitch_6
    const-string p0, "https://old.ftpbd.net/category/tv-series/"
    return-object p0

    :pswitch_7
    const-string p0, "https://old.ftpbd.net/category/animation-movies/anime-cartoon-tv-series/"
    return-object p0

    :pswitch_8
    const-string p0, "https://old.ftpbd.net/category/hindi-tv-series/"
    return-object p0

    :pswitch_9
    const-string p0, "https://old.ftpbd.net/category/movies/bangla-movies/bangla-web-series/"
    return-object p0

    :pswitch_10
    const-string p0, "https://old.ftpbd.net/category/documentary/"
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