.class final Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "FtpBd.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getEpisodeList(Leu/kanade/tachiyomi/animesource/model/SAnime;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation




# instance fields
.field final synthetic $anime:Leu/kanade/tachiyomi/animesource/model/SAnime;

.field label:I

.field final synthetic this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;


# direct methods
.method constructor <init>(Leu/kanade/tachiyomi/animesource/model/SAnime;Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Lkotlin/coroutines/Continuation;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Leu/kanade/tachiyomi/animesource/model/SAnime;",
            "Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;->$anime:Leu/kanade/tachiyomi/animesource/model/SAnime;

    iput-object p2, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;->this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p3}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Lkotlin/coroutines/Continuation<",
            "*>;)",
            "Lkotlin/coroutines/Continuation<",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation

    new-instance p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;

    iget-object v0, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;->$anime:Leu/kanade/tachiyomi/animesource/model/SAnime;

    iget-object v1, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;->this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;

    invoke-direct {p1, v0, v1, p2}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;-><init>(Leu/kanade/tachiyomi/animesource/model/SAnime;Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Lkotlin/coroutines/Continuation;)V

    check-cast p1, Lkotlin/coroutines/Continuation;

    return-object p1
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlinx/coroutines/CoroutineScope;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Ljava/util/List<",
            "+",
            "Leu/kanade/tachiyomi/animesource/model/SEpisode;",
            ">;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    invoke-virtual {p0, p1, p2}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object p1

    check-cast p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;

    sget-object p2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {p1, p2}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
        .locals 6

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v0

    iget v1, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;->label:I

    const/4 v2, 0x1

    if-eqz v1, :cond_1

    if-ne v1, v2, :cond_0

    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto/16 :goto_1

    :cond_0
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to 'resume' before 'invoke' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_1
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    iget-object p1, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;->$anime:Leu/kanade/tachiyomi/animesource/model/SAnime;

    invoke-interface {p1}, Leu/kanade/tachiyomi/animesource/model/SAnime;->getUrl()Ljava/lang/String;

    move-result-object p1

    iget-object v1, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;->this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;

    invoke-static {v1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->access$getGlobalHeaders(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;)Lokhttp3/Headers;

    move-result-object v1

    const/4 v3, 0x4

    const/4 v4, 0x0

    invoke-static {p1, v1, v4, v3, v4}, Leu/kanade/tachiyomi/network/RequestsKt;->GET$default(Ljava/lang/String;Lokhttp3/Headers;Lokhttp3/CacheControl;ILjava/lang/Object;)Lokhttp3/Request;

    move-result-object p1

    iget-object v1, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;->this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;

    invoke-virtual {v1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getClient()Lokhttp3/OkHttpClient;

    move-result-object v1

    invoke-virtual {v1, p1}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object p1

    invoke-interface {p1}, Lokhttp3/Call;->execute()Lokhttp3/Response;

    move-result-object p1

    invoke-static {p1, v4, v2, v4}, Leu/kanade/tachiyomi/util/JsoupExtensionsKt;->asJsoup$default(Lokhttp3/Response;Ljava/lang/String;ILjava/lang/Object;)Lorg/jsoup/nodes/Document;

    move-result-object v1

    invoke-virtual {p1}, Lokhttp3/Response;->close()V

    iget-object p1, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;->this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;

    invoke-static {p1, v1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->access$getMediaType(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Lorg/jsoup/nodes/Document;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_5

    const-string v3, "m"

    invoke-static {p1, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;->this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;

    invoke-static {p1, v1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->access$getMovieMedia(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Lorg/jsoup/nodes/Document;)Ljava/util/List;

    move-result-object p1

    goto :goto_2

    :cond_2
    const-string p1, "div.entry-content a[href*='ftpbd.net/FTP-']"

    invoke-virtual {v1, p1}, Lorg/jsoup/nodes/Document;->select(Ljava/lang/String;)Lorg/jsoup/select/Elements;

    move-result-object p1

    const-string v1, "document.select(\"div.ent\u2026[href*='ftpbd.net/FTP-']\")"

    invoke-static {p1, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast p1, Ljava/lang/Iterable;

    new-instance v1, Ljava/util/ArrayList;

    const/16 v3, 0xa

    invoke-static {p1, v3}, Lkotlin/collections/CollectionsKt;->collectionSizeOrDefault(Ljava/lang/Iterable;I)I

    move-result v3

    invoke-direct {v1, v3}, Ljava/util/ArrayList;-><init>(I)V

    check-cast v1, Ljava/util/Collection;

    invoke-interface {p1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lorg/jsoup/nodes/Element;

    const-string v5, "href"

    invoke-virtual {v3, v5}, Lorg/jsoup/nodes/Element;->attr(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_3
    check-cast v1, Ljava/util/List;

    check-cast v1, Ljava/lang/Iterable;

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->reversed(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object p1

    const/4 v1, 0x0

    const/4 v3, 0x2

    const/4 v5, 0x3

    invoke-static {v5, v1, v3, v4}, Lkotlinx/coroutines/sync/SemaphoreKt;->Semaphore$default(IIILjava/lang/Object;)Lkotlinx/coroutines/sync/Semaphore;

    move-result-object v1

    new-instance v3, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2$1;

    iget-object v5, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;->this$0:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;

    invoke-direct {v3, p1, v5, v1, v4}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2$1;-><init>(Ljava/util/List;Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Lkotlinx/coroutines/sync/Semaphore;Lkotlin/coroutines/Continuation;)V

    check-cast v3, Lkotlin/jvm/functions/Function2;

    move-object p1, p0

    check-cast p1, Lkotlin/coroutines/Continuation;

    iput v2, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;->label:I

    invoke-static {v3, p1}, Lkotlinx/coroutines/CoroutineScopeKt;->coroutineScope(Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p1

    if-ne p1, v0, :cond_4

    return-object v0

    :cond_4
    :goto_1
    check-cast p1, Ljava/util/List;

    :goto_2
    return-object p1

    :cond_5
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "Unknown media type"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
