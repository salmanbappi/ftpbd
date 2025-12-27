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
.field label:I
.field final synthetic this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;


# direct methods
.method constructor <init>(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V
    .locals 0

    iput-object p1, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;

    iput-object p2, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->$query:Ljava/lang/String;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p3}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 3

    new-instance p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;

    iget-object v0, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;

    iget-object v1, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->$query:Ljava/lang/String;

    invoke-direct {p1, v0, v1, p2}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;-><init>(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

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
    .locals 12

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    iget v1, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->label:I

    if-nez v1, :cond_err

    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "https://ftpbd.net/?s="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->$query:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;

    invoke-static {v2}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->access$getGlobalHeaders(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;)Lokhttp3/Headers;

    move-result-object v2

    const/4 v3, 0x0

    const/4 v4, 0x4

    invoke-static {v1, v2, v3, v4, v3}, Leu/kanade/tachiyomi/network/RequestsKt;->GET$default(Ljava/lang/String;Lokhttp3/Headers;Lokhttp3/CacheControl;ILjava/lang/Object;)Lokhttp3/Request;

    move-result-object v1

    iget-object v2, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;->this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;

    invoke-virtual {v2}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getClient()Lokhttp3/OkHttpClient;

    move-result-object v2

    invoke-virtual {v2, v1}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object v1

    invoke-interface {v1}, Lokhttp3/Call;->execute()Lokhttp3/Response;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v1, v3, v2, v3}, Leu/kanade/tachiyomi/util/JsoupExtensionsKt;->asJsoup$default(Lokhttp3/Response;Ljava/lang/String;ILjava/lang/Object;)Lorg/jsoup/nodes/Document;

    move-result-object p1

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    const-string v4, "article, .post-item, .card"

    invoke-virtual {p1, v4}, Lorg/jsoup/nodes/Document;->select(Ljava/lang/String;)Lorg/jsoup/select/Elements;

    move-result-object p1

    invoke-virtual {p1}, Lorg/jsoup/select/Elements;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :cond_loop
    :goto_loop
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_finish

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lorg/jsoup/nodes/Element;

    const-string v6, "h2 a, h3 a, .post-image a, a"

    invoke-virtual {v5, v6}, Lorg/jsoup/nodes/Element;->selectFirst(Ljava/lang/String;)Lorg/jsoup/nodes/Element;

    move-result-object v6

    if-nez v6, :cond_skip_item

    goto :goto_loop

:cond_skip_item
    const-string v7, "abs:href"

    invoke-virtual {v6, v7}, Lorg/jsoup/nodes/Element;->attr(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v8, "img"

    invoke-virtual {v5, v8}, Lorg/jsoup/nodes/Element;->selectFirst(Ljava/lang/String;)Lorg/jsoup/nodes/Element;

    move-result-object v8

    const-string v9, ""

    if-eqz v8, :cond_no_thumb

    const-string v9, "abs:src"

    invoke-virtual {v8, v9}, Lorg/jsoup/nodes/Element;->attr(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    const-string v10, "alt"

    invoke-virtual {v8, v10}, Lorg/jsoup/nodes/Element;->attr(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    goto :goto_title

:cond_no_thumb
    invoke-virtual {v6}, Lorg/jsoup/nodes/Element;->text()Ljava/lang/String;

    move-result-object v8

    :goto_title
    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {v8}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v10

    if-eqz v10, :cond_use_link_text

    invoke-virtual {v6}, Lorg/jsoup/nodes/Element;->text()Ljava/lang/String;

    move-result-object v8

    :cond_use_link_text
    check-cast v8, Ljava/lang/CharSequence;

    invoke-static {v8}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v10

    if-eqz v10, :cond_add_item

    goto :goto_loop

:cond_add_item
    const-string v10, "ftpbd.net"

    check-cast v10, Ljava/lang/CharSequence;

    check-cast v7, Ljava/lang/CharSequence;

    const/4 v11, 0x0

    const/4 v12, 0x2

    invoke-static {v7, v10, v11, v12, v3}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v10

    if-nez v10, :cond_actual_add

    goto :goto_loop

:cond_actual_add
    new-instance v10, Leu/kanade/tachiyomi/animesource/model/SAnimeImpl;

    invoke-direct {v10}, Leu/kanade/tachiyomi/animesource/model/SAnimeImpl;-><init>()V

    move-object v11, v10

    check-cast v11, Leu/kanade/tachiyomi/animesource/model/SAnime;

    invoke-virtual {v8}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-interface {v11, v8}, Leu/kanade/tachiyomi/animesource/model/SAnime;->setTitle(Ljava/lang/String;)V

    invoke-virtual {v7}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v11, v7}, Leu/kanade/tachiyomi/animesource/model/SAnime;->setUrl(Ljava/lang/String;)V

    invoke-interface {v11, v9}, Leu/kanade/tachiyomi/animesource/model/SAnime;->setThumbnail_url(Ljava/lang/String;)V

    invoke-virtual {v1, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto/16 :cond_loop

:cond_finish
    new-instance p1, Leu/kanade/tachiyomi/animesource/model/AnimesPage;

    const/4 v0, 0x0

    invoke-direct {p1, v1, v0}, Leu/kanade/tachiyomi/animesource/model/AnimesPage;-><init>(Ljava/util/List;Z)V

    return-object p1

:cond_err
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to 'resume' before 'invoke' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method