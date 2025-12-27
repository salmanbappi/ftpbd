.class final Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "FtpBd.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;

# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getSearchAnime(ILjava/lang/String;Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

# instance fields
.field final synthetic $query:Ljava/lang/String;
.field final synthetic $filters:Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;
.field label:I
.field final synthetic this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;


# direct methods
.method constructor <init>(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Ljava/lang/String;Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;Lkotlin/coroutines/Continuation;)V
    .locals 0

    iput-object p1, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;

    iput-object p2, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->$query:Ljava/lang/String;

    iput-object p3, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->$filters:Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p4}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method

.method private final searchOnServer(Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;)V
    .locals 16

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-object/from16 v3, p3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, "/_h5ai/public/index.php"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "{\"action\":\"get\",\"search\":{\"href\":\""

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, "/"

    move-object v7, v2

    check-cast v7, Ljava/lang/CharSequence;

    const/4 v8, 0x0

    const/4 v9, 0x2

    const/4 v10, 0x0

    invoke-static {v7, v6, v8, v9, v10}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_add_pre_slash

    const-string v6, "/"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

:cond_add_pre_slash
    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, "/","pattern":""

    move-object v7, v2

    check-cast v7, Ljava/lang/CharSequence;

    const-string v8, "/"

    check-cast v8, Ljava/lang/CharSequence;

    const/4 v11, 0x0

    const/4 v12, 0x2

    const/4 v13, 0x0

    invoke-static {v7, v8, v11, v12, v13}, Lkotlin/text/StringsKt;->endsWith$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_add_pat_pre

    const-string v6, "pattern":""

:cond_add_pat_pre
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v6, v0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->$query:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, "","ignorecase":true}}"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    const-string v6, "application/json; charset=utf-8"

    invoke-static {v6}, Lokhttp3/MediaType;->parse(Ljava/lang/String;)Lokhttp3/MediaType;

    move-result-object v6

    invoke-static {v6, v5}, Lokhttp3/RequestBody;->create(Lokhttp3/MediaType;Ljava/lang/String;)Lokhttp3/RequestBody;

    move-result-object v12

    iget-object v5, v0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;

    invoke-static {v5}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->access$getGlobalHeaders(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;)Lokhttp3/Headers;

    move-result-object v11

    const/4 v13, 0x0

    const/16 v14, 0x8

    const/4 v15, 0x0

    move-object v10, v4

    invoke-static/range {v10 .. v15}, Leu/kanade/tachiyomi/network/RequestsKt;->POST$default(Ljava/lang/String;Lokhttp3/Headers;Lokhttp3/RequestBody;Lokhttp3/CacheControl;ILjava/lang/Object;)Lokhttp3/Request;

    move-result-object v5

    iget-object v6, v0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;

    invoke-virtual {v6}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getClient()Lokhttp3/OkHttpClient;

    move-result-object v6

    invoke-virtual {v6, v5}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object v5

    :try_start_0
    invoke-interface {v5}, Lokhttp3/Call;->execute()Lokhttp3/Response;

    move-result-object v5

    invoke-virtual {v5}, Lokhttp3/Response;->body()Lokhttp3/ResponseBody;

    move-result-object v6

    if-eqz v6, :cond_close

    invoke-virtual {v6}, Lokhttp3/ResponseBody;->string()Ljava/lang/String;

    move-result-object v6

    const-string v8, "\"href\":\"([^\"]+)\""

    const/4 v9, 0x2

    invoke-static {v8, v9}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;I)Ljava/util/regex/Pattern;

    move-result-object v8

    check-cast v6, Ljava/lang/CharSequence;

    invoke-virtual {v8, v6}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v6

    :cond_loop
    invoke-virtual {v6}, Ljava/util/regex/Matcher;->find()Z

    move-result v8

    if-eqz v8, :cond_close

    const/4 v8, 0x1

    invoke-virtual {v6, v8}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v8

    const/16 v9, 0x5c

    const/16 v10, 0x2f

    invoke-virtual {v8, v9, v10}, Ljava/lang/String;->replace(CC)Ljava/lang/String;

    move-result-object v8

    const-string v9, "/+"

    const-string v10, "/"

    invoke-virtual {v8, v9, v10}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    move-object v9, v8

    :cond_trim_loop
    const-string v10, "/"

    move-object v11, v9

    check-cast v11, Ljava/lang/CharSequence;

    move-object v12, v10

    check-cast v12, Ljava/lang/CharSequence;

    const/4 v13, 0x0

    const/4 v14, 0x2

    const/4 v15, 0x0

    invoke-static {v11, v12, v13, v14, v15}, Lkotlin/text/StringsKt;->endsWith$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_trim_done

    invoke-virtual {v9}, Ljava/lang/String;->length()I

    move-result v11

    const/4 v12, 0x1

    if-le v11, v12, :cond_trim_done

    const/4 v12, 0x0

    add-int/lit8 v11, v11, -0x1

    invoke-virtual {v9, v12, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    goto :cond_trim_loop

    :cond_trim_done

    const-string v10, "/"

    invoke-static {v9, v10, v9}, Lkotlin/text/StringsKt;->substringAfterLast(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    const-string v10, "UTF-8"

    invoke-static {v9, v10}, Ljava/net/URLDecoder;->decode(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v9

    new-instance v10, Leu/kanade/tachiyomi/animesource/model/SAnimeImpl;

    invoke-direct {v10}, Leu/kanade/tachiyomi/animesource/model/SAnimeImpl;-><init>()V

    move-object v11, v10

    check-cast v11, Leu/kanade/tachiyomi/animesource/model/SAnime;

    invoke-interface {v11, v9}, Leu/kanade/tachiyomi/animesource/model/SAnime;->setTitle(Ljava/lang/String;)V

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    move-object v11, v10

    check-cast v11, Leu/kanade/tachiyomi/animesource/model/SAnime;

    invoke-interface {v11, v8}, Leu/kanade/tachiyomi/animesource/model/SAnime;->setUrl(Ljava/lang/String;)V

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v8, "/"

    move-object v12, v8

    check-cast v12, Ljava/lang/CharSequence;

    const/4 v13, 0x0

    const/4 v14, 0x2

    const/4 v15, 0x0

    move-object v11, v10

    invoke-interface {v11}, Leu/kanade/tachiyomi/animesource/model/SAnime;->getUrl()Ljava/lang/String;

    move-result-object v11

    check-cast v11, Ljava/lang/CharSequence;

    invoke-static {v11, v12, v13, v14, v15}, Lkotlin/text/StringsKt;->endsWith$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v11

    if-nez v11, :cond_add_url_slash

    const-string v11, "/"

    invoke-virtual {v5, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

:cond_add_url_slash

    const-string v8, "a11.jpg"

    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    const-string v12, " "

    const-string v13, "%20"

    const/4 v14, 0x0

    const/16 v15, 0x4

    const/16 v16, 0x0

    move-object v11, v8

    invoke-static/range {v11 .. v16}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    move-object v11, v10

    check-cast v11, Leu/kanade/tachiyomi/animesource/model/SAnime;

    invoke-interface {v11, v8}, Leu/kanade/tachiyomi/animesource/model/SAnime;->setThumbnail_url(Ljava/lang/String;)V

    invoke-virtual {v3, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto/16 :cond_loop

    :cond_close
    invoke-virtual {v5}, Lokhttp3/Response;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 4

    new-instance p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;

    iget-object v0, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;

    iget-object v1, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->$query:Ljava/lang/String;

    iget-object v2, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->$filters:Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;

    invoke-direct {p1, v0, v1, v2, p2}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;-><init>(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Ljava/lang/String;Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;Lkotlin/coroutines/Continuation;)V

    check-cast p1, Lkotlin/coroutines/Continuation;

    return-object p1
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1, p2}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object p1

    check-cast p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;

    sget-object p2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {p1, p2}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 6

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    iget v0, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->label:I

    if-nez v0, :cond_err

    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->$filters:Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;

    const-string v2, ""

    invoke-static {v2, v1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/Filters;->getUrl(Ljava/lang/String;Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "https://server3.ftpbd.net/FTP-3/Hindi%20Movies/2025/"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_global

    const-string v1, "https://server2.ftpbd.net"

    const-string v2, "FTP-2"

    invoke-direct {p0, v1, v2, v0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->searchOnServer(Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;)V

    const-string v1, "https://server3.ftpbd.net"

    const-string v2, "FTP-3"

    invoke-direct {p0, v1, v2, v0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->searchOnServer(Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;)V

    const-string v1, "https://server4.ftpbd.net"

    const-string v2, "FTP-4"

    invoke-direct {p0, v1, v2, v0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->searchOnServer(Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;)V

    const-string v1, "https://server5.ftpbd.net"

    const-string v2, "FTP-5"

    invoke-direct {p0, v1, v2, v0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->searchOnServer(Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;)V

    goto :goto_sort

:cond_global
    invoke-static {v1}, Lokhttp3/HttpUrl;->parse(Ljava/lang/String;)Lokhttp3/HttpUrl;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Lokhttp3/HttpUrl;->scheme()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "://"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Lokhttp3/HttpUrl;->host()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1}, Lokhttp3/HttpUrl;->encodedPath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v2, v1, v0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->searchOnServer(Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;)V

:goto_sort
    iget-object v1, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;

    move-object v2, v0

    check-cast v2, Ljava/util/List;

    iget-object v3, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->$query:Ljava/lang/String;

    invoke-static {v1, v2, v3}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->access$sortByTitle(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Ljava/util/List;Ljava/lang/String;)Ljava/util/List;

    move-result-object v1

    new-instance v2, Leu/kanade/tachiyomi/animesource/model/AnimesPage;

    const/4 v3, 0x0

    invoke-direct {v2, v1, v3}, Leu/kanade/tachiyomi/animesource/model/AnimesPage;-><init>(Ljava/util/List;Z)V

    return-object v2

:cond_err
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to 'resume' before 'invoke' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
