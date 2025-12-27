.class public final Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;
.super Leu/kanade/tachiyomi/animesource/online/AnimeHttpSource;
.source "FtpBd.kt"

# interfaces
.implements Leu/kanade/tachiyomi/animesource/AnimeCatalogueSource;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$Companion;,
        Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$EpisodeData;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nFtpBd.kt\nKotlin\n*S Kotlin\n*F\n+ 1 FtpBd.kt\neu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,364:1\n1557#2:365\n1628#2,3:366\n1557#2:369\n1628#2,3:370\n1557#2:373\n1628#2,3:374\n1062#2:377\n1863#2,2:378\n*S KotlinDebug\n*F\n+ 1 FtpBd.kt\neu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd\n*L\n71#1:365\n71#1:366,3\n177#1:369\n177#1:370,3\n189#1:373\n189#1:374,3\n269#1:377\n293#1:378,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0084\u0001\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0008\n\u0002\u0018\u0002\n\u0002\u0008\t\n\u0002\u0010\u000b\n\u0002\u0008\u0003\n\u0002\u0010\t\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u000e\u0018\u0000 N2\u00020\u00012\u00020\u0002:\u0002NOB\u0005\u00a2\u0006\u0002\u0010\u0003J\u0010\u0010\"\u001a\u00020#2\u0006\u0010$\u001a\u00020%H\u0014J\u0010\u0010&\u001a\u00020\'2\u0006\u0010(\u001a\u00020#H\u0016J\u0016\u0010)\u001a\u0008\u0012\u0004\u0012\u00020+0*2\u0006\u0010$\u001a\u00020%H\u0014J\u0010\u0010,\u001a\u00020\'2\u0006\u0010(\u001a\u00020#H\u0014J\u0016\u0010-\u001a\u0008\u0012\u0004\u0012\u00020.0*2\u0006\u0010/\u001a\u000200H\u0002J\u001f\u00101\u001a\u0008\u0012\u0004\u0012\u00020+0*2\u0006\u0010(\u001a\u00020#H\u0096@\u00f8\u0001\u0000\u00a2\u0006\u0002\u00102J\u0012\u00103\u001a\u0004\u0018\u00010\u00052\u0006\u0010/\u001a\u000200H\u0002J\u0010\u00104\u001a\u00020#2\u0006\u0010/\u001a\u000200H\u0002J\u0016\u00105\u001a\u0008\u0012\u0004\u0012\u00020+0*2\u0006\u0010/\u001a\u000200H\u0002J\u0019\u00106\u001a\u0002072\u0006\u00108\u001a\u000209H\u0096@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010:J)\u0010;\u001a\u0002072\u0006\u00108\u001a\u0002092\u0006\u0010<\u001a\u00020\u00052\u0006\u0010=\u001a\u00020>H\u0096@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010?J\u0010\u0010@\u001a\u00020#2\u0006\u0010/\u001a\u000200H\u0002J\u001f\u0010A\u001a\u0008\u0012\u0004\u0012\u00020B0*2\u0006\u0010C\u001a\u00020+H\u0096@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010DJ\u0010\u0010E\u001a\u0002072\u0006\u0010$\u001a\u00020%H\u0014J\u0010\u0010F\u001a\u00020\'2\u0006\u00108\u001a\u000209H\u0014J\u0010\u0010G\u001a\u0002072\u0006\u0010$\u001a\u00020%H\u0014J\u0010\u0010H\u001a\u00020\'2\u0006\u00108\u001a\u000209H\u0014J\u0010\u0010I\u001a\u0002072\u0006\u0010$\u001a\u00020%H\u0014J \u0010J\u001a\u00020\'2\u0006\u00108\u001a\u0002092\u0006\u0010<\u001a\u00020\u00052\u0006\u0010=\u001a\u00020>H\u0014J\u001c\u0010K\u001a\u0008\u0012\u0004\u0012\u00020+0*2\u000c\u0010L\u001a\u0008\u0012\u0004\u0012\u00020.0*H\u0002J \u0010M\u001a\u0008\u0012\u0004\u0012\u00020#0**\u0008\u0012\u0004\u0012\u00020#0*2\u0006\u0010<\u001a\u00020\u0005H\u0002R\u0014\u0010\u0004\u001a\u00020\u00058VX\u0096\u0004\u00a2\u0006\u0006\u001a\u0004\u0008\u0006\u0010\u0007R\u001b\u0010\u0008\u001a\u00020\t8BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u000c\u0010\r\u001a\u0004\u0008\n\u0010\u000bR\u001b\u0010\u000e\u001a\u00020\u00058BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u0010\u0010\r\u001a\u0004\u0008\u000f\u0010\u0007R\u001b\u0010\u0011\u001a\u00020\u00128BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u0015\u0010\r\u001a\u0004\u0008\u0013\u0010\u0014R\u0014\u0010\u0016\u001a\u00020\u0005X\u0096D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0017\u0010\u0007R\u0014\u0010\u0018\u001a\u00020\u0005X\u0096D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0019\u0010\u0007R\u000e\u0010\u001a\u001a\u00020\u0005X\u0082D\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u001b\u001a\u00020\u001cX\u0096D\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u001d\u0010\u001eR\u000e\u0010\u001f\u001a\u00020 X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010!\u001a\u00020\u0005X\u0082D\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006P"
    }
    d2 = {
        "Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;",
        "Leu/kanade/tachiyomi/animesource/AnimeCatalogueSource;",
        "Leu/kanade/tachiyomi/animesource/online/AnimeHttpSource;",
        "()V",
        "baseUrl",
        "",
        "getBaseUrl",
        "()Ljava/lang/String;",
        "cm",
        "Leu/kanade/tachiyomi/animeextension/all/ftpbd/CookieManager;",
        "getCm",
        "()Leu/kanade/tachiyomi/animeextension/all/ftpbd/CookieManager;",
        "cm$delegate",
        "Lkotlin/Lazy;",
        "cookieHeader",
        "getCookieHeader",
        "cookieHeader$delegate",
        "globalHeaders",
        "Lokhttp3/Headers;",
        "getGlobalHeaders",
        "()Lokhttp3/Headers;",
        "globalHeaders$delegate",
        "lang",
        "getLang",
        "name",
        "getName",
        "rick",
        "supportsLatest",
        "",
        "getSupportsLatest",
        "()Z",
        "time",
        "",
        "url",
        "animeDetailsParse",
        "Leu/kanade/tachiyomi/animesource/model/SAnime;",
        "response",
        "Lokhttp3/Response;",
        "animeDetailsRequest",
        "Lokhttp3/Request;",
        "anime",
        "episodeListParse",
        "",
        "Leu/kanade/tachiyomi/animesource/model/SEpisode;",
        "episodeListRequest",
        "extractEpisode",
        "Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$EpisodeData;",
        "document",
        "Lorg/jsoup/nodes/Document;",
        "getEpisodeList",
        "(Leu/kanade/tachiyomi/animesource/model/SAnime;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "getMediaType",
        "getMovieDetails",
        "getMovieMedia",
        "getPopularAnime",
        "Leu/kanade/tachiyomi/animesource/model/AnimesPage;",
        "page",
        "",
        "(ILkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "getSearchAnime",
        "query",
        "filters",
        "Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;",
        "(ILjava/lang/String;Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "getSeriesDetails",
        "getVideoList",
        "Leu/kanade/tachiyomi/animesource/model/Video;",
        "episode",
        "(Leu/kanade/tachiyomi/animesource/model/SEpisode;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "latestUpdatesParse",
        "latestUpdatesRequest",
        "popularAnimeParse",
        "popularAnimeRequest",
        "searchAnimeParse",
        "searchAnimeRequest",
        "sortEpisodes",
        "episodes",
        "sortByTitle",
        "Companion",
        "EpisodeData",
        "aniyomi-all.ftpbd-v1.0_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final Companion:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$Companion;

.field private static final EPISODE_PATTERN:Lkotlin/text/Regex;

.field private static final SEASON_PATTERN:Lkotlin/text/Regex;

.field private static final SIZE_REGEX:Lkotlin/text/Regex;


# instance fields
.field private final cm$delegate:Lkotlin/Lazy;

.field private final cookieHeader$delegate:Lkotlin/Lazy;

.field private final globalHeaders$delegate:Lkotlin/Lazy;

.field private final lang:Ljava/lang/String;

.field private final name:Ljava/lang/String;

.field private final rick:Ljava/lang/String;

.field private final supportsLatest:Z

.field private final time:J

.field private final url:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->Companion:Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$Companion;

    .line 351
    new-instance v0, Lkotlin/text/Regex;

    const-string v1, "S(\\d+)"

    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    sput-object v0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->SEASON_PATTERN:Lkotlin/text/Regex;

    .line 352
    new-instance v0, Lkotlin/text/Regex;

    const-string v1, "EP (\\d+)"

    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    sput-object v0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->EPISODE_PATTERN:Lkotlin/text/Regex;

    .line 353
    new-instance v0, Lkotlin/text/Regex;

    const-string v1, ".*\\s(\\d+\\.\\d+\\s+MB)$"

    invoke-direct {v0, v1}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    sput-object v0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->SIZE_REGEX:Lkotlin/text/Regex;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 27
    invoke-direct {p0}, Leu/kanade/tachiyomi/animesource/online/AnimeHttpSource;-><init>()V

    const-string v0, "FtpBd"

    iput-object v0, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->name:Ljava/lang/String;

    const-wide v0, 0x0L

    iput-wide v0, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->time:J

    const-string v0, "https://server3.ftpbd.net"

    iput-object v0, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->rick:Ljava/lang/String;

    const-string v0, "https://server3.ftpbd.net"

    iput-object v0, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->url:Ljava/lang/String;

    const-string v0, "all"

    iput-object v0, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->lang:Ljava/lang/String;

    const/4 v0, 0x1

    iput-boolean v0, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->supportsLatest:Z

    .line 43
    new-instance v0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$cm$2;

    invoke-direct {v0, p0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$cm$2;-><init>(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;)V

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->cm$delegate:Lkotlin/Lazy;

    .line 45
    new-instance v0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$cookieHeader$2;

    invoke-direct {v0, p0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$cookieHeader$2;-><init>(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;)V

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->cookieHeader$delegate:Lkotlin/Lazy;

    .line 47
    new-instance v0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$globalHeaders$2;

    invoke-direct {v0, p0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$globalHeaders$2;-><init>(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;)V

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    iput-object v0, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->globalHeaders$delegate:Lkotlin/Lazy;

    return-void
.end method




.method private final extractEpisode(Lorg/jsoup/nodes/Document;)Ljava/util/List;
    .locals 14
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lorg/jsoup/nodes/Document;",
            ")",
            "Ljava/util/List<",
            "Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$EpisodeData;",
            ">;"
        }
    .end annotation

    new-instance v0, Ljava/util/ArrayList;
    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V
    check-cast v0, Ljava/util/List;

    const-string v1, "div#fallback table tr, div.entry-content a"
    invoke-virtual {p1, v1}, Lorg/jsoup/nodes/Document;->select(Ljava/lang/String;)Lorg/jsoup/select/Elements;
    move-result-object v1
    invoke-virtual {v1}, Lorg/jsoup/select/Elements;->iterator()Ljava/util/Iterator;
    move-result-object v1

    :link_loop
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z
    move-result v2
    if-nez v2, :goto_done
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Lorg/jsoup/nodes/Element;

    const-string v3, "td.fb-n a"
    invoke-virtual {v2, v3}, Lorg/jsoup/nodes/Element;->selectFirst(Ljava/lang/String;)Lorg/jsoup/nodes/Element;
    move-result-object v3
    if-eqz v3, :goto_extracted_a
    move-object v3, v2
    :goto_extracted_a
    const-string v4, "tag"
    invoke-virtual {v3}, Lorg/jsoup/nodes/Element;->tagName()Ljava/lang/String;
    move-result-object v4
    const-string v5, "a"
    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z
    move-result v4
    if-nez v4, :goto_skip

    invoke-virtual {v3}, Lorg/jsoup/nodes/Element;->text()Ljava/lang/String;
    move-result-object v4
    const-string v5, "Parent Directory"
    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z
    move-result v5
    if-eqz v5, :goto_skip

        const-string v5, "abs:href"

    

        invoke-virtual {v3, v5}, Lorg/jsoup/nodes/Element;->attr(Ljava/lang/String;)Ljava/lang/String;

    

        move-result-object v2

    

        const-string v3, "\\"

    

        const-string v4, "/"

    

        const/4 v5, 0x0

    

        const/4 v6, 0x4

    

        const/4 v7, 0x0

    

        invoke-static/range {v2 .. v7}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    

        move-result-object v2

    

        const-string v3, "(?i).*[.](mkv|mp4|avi|webm)$"

    

        new-instance v4, Lkotlin/text/Regex;

    

        invoke-direct {v4, v3}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V

    

        move-object v3, v2

    

        check-cast v3, Ljava/lang/CharSequence;

    

        invoke-virtual {v4, v3}, Lkotlin/text/Regex;->matches(Ljava/lang/CharSequence;)Z

    

        move-result v3

    

        if-eqz v3, :cond_is_file

    

        const/4 v3, 0x0

    

        if-eqz v3, :cond_check_dir

    

    :cond_is_file
    const-string v3, "https://old.ftpbd.net"
    const-string v4, "https://server3.ftpbd.net"
    const/4 v5, 0x0
    const/4 v6, 0x4
    const/4 v7, 0x0
    invoke-static/range {v2 .. v7}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;
    move-result-object v5
        const-string v3, "/"
    
        invoke-static {v5, v3}, Lkotlin/text/StringsKt;->substringAfterLast(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    
        move-result-object v4
    
        new-instance v3, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$EpisodeData;
    
        const-string v6, ""
    
        const-string v7, "File"
    
        const-string v8, "Direct"
    
        invoke-direct/range {v3 .. v8}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$EpisodeData;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    
    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    goto :link_loop

            :cond_check_dir

            const-string v3, "/"

        

            invoke-virtual {v2, v3}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

        

            move-result v3

        

            if-nez v3, :cond_check_dir_skip

        

            goto :cond_really_dir

        

            :cond_check_dir_skip

            goto :link_loop

        

    

        goto :link_loop

    

    :cond_really_dir
    :try_start
    new-instance v3, Lokhttp3/Request$Builder;
    invoke-direct {v3}, Lokhttp3/Request$Builder;-><init>()V
    invoke-virtual {v3, v2}, Lokhttp3/Request$Builder;->url(Ljava/lang/String;)Lokhttp3/Request$Builder;
    move-result-object v3
    invoke-virtual {v3}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;
    move-result-object v3
    invoke-virtual {p0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getClient()Lokhttp3/OkHttpClient;
    move-result-object v4
    invoke-virtual {v4, v3}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;
    move-result-object v3
    invoke-interface {v3}, Lokhttp3/Call;->execute()Lokhttp3/Response;
    move-result-object v3
    const/4 v4, 0x0
    const/4 v5, 0x1
    invoke-static {v3, v4, v5, v4}, Leu/kanade/tachiyomi/util/JsoupExtensionsKt;->asJsoup$default(Lokhttp3/Response;Ljava/lang/String;ILjava/lang/Object;)Lorg/jsoup/nodes/Document;
    move-result-object v3
    const-string v4, "div#fallback table tr"
    invoke-virtual {v3, v4}, Lorg/jsoup/nodes/Document;->select(Ljava/lang/String;)Lorg/jsoup/select/Elements;
    move-result-object v3
    invoke-virtual {v3}, Lorg/jsoup/select/Elements;->iterator()Ljava/util/Iterator;
    move-result-object v3
    :dir_loop
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z
    move-result v4
    if-nez v4, :goto_dir_done
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v4
    check-cast v4, Lorg/jsoup/nodes/Element;
    const-string v5, "td.fb-n a"
    invoke-virtual {v4, v5}, Lorg/jsoup/nodes/Element;->selectFirst(Ljava/lang/String;)Lorg/jsoup/nodes/Element;
    move-result-object v5
    if-nez v5, :cond_has_link
    goto :dir_loop
    :cond_has_link
    const-string v6, "abs:href"
    invoke-virtual {v5, v6}, Lorg/jsoup/nodes/Element;->attr(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v8
    invoke-virtual {v5}, Lorg/jsoup/nodes/Element;->text()Ljava/lang/String;
    move-result-object v10
        const-string v5, "(?i).*[.](mkv|mp4|avi|webm)$"
    
        new-instance v6, Lkotlin/text/Regex;
    
        invoke-direct {v6, v5}, Lkotlin/text/Regex;-><init>(Ljava/lang/String;)V
    
        move-object v5, v8
    
        check-cast v5, Ljava/lang/CharSequence;
    
        invoke-virtual {v6, v5}, Lkotlin/text/Regex;->matches(Ljava/lang/CharSequence;)Z
    
        move-result v5
    
        if-nez v5, :cond_dir_loop_skip
    
        goto :cond_is_dir_file
    
        :cond_dir_loop_skip
        goto :dir_loop
    
        :cond_is_dir_file
    
    const-string v5, "td.fb-s"
    invoke-virtual {v4, v5}, Lorg/jsoup/nodes/Element;->selectFirst(Ljava/lang/String;)Lorg/jsoup/nodes/Element;
    move-result-object v4
    if-eqz v4, :cond_no_size
    invoke-virtual {v4}, Lorg/jsoup/nodes/Element;->text()Ljava/lang/String;
    move-result-object v4
    goto :goto_has_size
    :cond_no_size
    const-string v4, ""
    :goto_has_size
    move-object v9, v4
    new-instance v4, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$EpisodeData;
    const-string v7, "Episode"
    const-string v11, "HD"
    move-object v6, v4
    invoke-direct/range {v6 .. v11}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$EpisodeData;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    invoke-interface {v0, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    goto :dir_loop
    :goto_dir_done
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch_dir
    :catch_dir
    goto :link_loop

    :goto_skip
    goto :link_loop

    :goto_done
    return-object v0
.end method
.method public static final synthetic access$getCm(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;)Leu/kanade/tachiyomi/animeextension/all/ftpbd/CookieManager;
    .locals 0

    .line 27
    invoke-direct {p0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getCm()Leu/kanade/tachiyomi/animeextension/all/ftpbd/CookieManager;

    move-result-object p0

    return-object p0
.end method

.method public static final synthetic access$getCookieHeader(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;)Ljava/lang/String;
    .locals 0

    .line 27
    invoke-direct {p0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getCookieHeader()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static final synthetic access$getGlobalHeaders(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;)Lokhttp3/Headers;
    .locals 0

    .line 27
    invoke-direct {p0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getGlobalHeaders()Lokhttp3/Headers;

    move-result-object p0

    return-object p0
.end method

.method public static final synthetic access$getMediaType(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Lorg/jsoup/nodes/Document;)Ljava/lang/String;
    .locals 0

    .line 27
    invoke-direct {p0, p1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getMediaType(Lorg/jsoup/nodes/Document;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static final synthetic access$getMovieMedia(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Lorg/jsoup/nodes/Document;)Ljava/util/List;
    .locals 0

    .line 27
    invoke-direct {p0, p1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getMovieMedia(Lorg/jsoup/nodes/Document;)Ljava/util/List;

    move-result-object p0

    return-object p0
.end method

.method public static final synthetic access$getSearchAnime$fetchAnimeByType(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Ljava/lang/String;Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 0

    .line 27
    invoke-static {p0, p1, p2, p3}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getSearchAnime$fetchAnimeByType(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Ljava/lang/String;Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method public static final synthetic access$sortByTitle$diceCoefficient(Ljava/lang/String;Ljava/lang/String;)D
    .locals 0

    .line 27
    invoke-static {p0, p1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->sortByTitle$diceCoefficient(Ljava/lang/String;Ljava/lang/String;)D

    move-result-wide p0

    return-wide p0
.end method

.method public static final synthetic access$sortEpisodes(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Ljava/util/List;)Ljava/util/List;
    .locals 0

    .line 27
    invoke-direct {p0, p1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->sortEpisodes(Ljava/util/List;)Ljava/util/List;

    move-result-object p0

    return-object p0
.end method

.method private final getCm()Leu/kanade/tachiyomi/animeextension/all/ftpbd/CookieManager;
    .locals 1

    iget-object v0, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->cm$delegate:Lkotlin/Lazy;

    .line 43
    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/CookieManager;

    return-object v0
.end method

.method private final getCookieHeader()Ljava/lang/String;
    .locals 1

    const-string v0, ""

    return-object v0
.end method

.method private final getGlobalHeaders()Lokhttp3/Headers;
    .locals 4

    .line 48
    new-instance v0, Lokhttp3/Headers$Builder;

    invoke-direct {v0}, Lokhttp3/Headers$Builder;-><init>()V

    const-string v2, "Accept"

    const-string v3, "*/*"

    .line 49
    invoke-virtual {v0, v2, v3}, Lokhttp3/Headers$Builder;->add(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Headers$Builder;

    const-string v2, "User-Agent"
    const-string v3, "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    invoke-virtual {v0, v2, v3}, Lokhttp3/Headers$Builder;->add(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Headers$Builder;

    const-string v2, "Cookie"

    .line 50
    invoke-direct {p0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getCookieHeader()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lokhttp3/Headers$Builder;->add(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Headers$Builder;

    .line 51
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getBaseUrl()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/16 v1, 0x2f

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "Referer"

    invoke-virtual {v0, v2, v1}, Lokhttp3/Headers$Builder;->add(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Headers$Builder;

    .line 52
    invoke-virtual {v0}, Lokhttp3/Headers$Builder;->build()Lokhttp3/Headers;

    move-result-object v0

    return-object v0
.end method


.method private final getMediaType(Lorg/jsoup/nodes/Document;)Ljava/lang/String;
    .locals 2

    invoke-virtual {p1}, Lorg/jsoup/nodes/Document;->location()Ljava/lang/String;

    move-result-object v0

    const-string v1, "/movies/"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "m"

    goto :goto_0

    :cond_0
    const-string v0, "s"

    :goto_0
    return-object v0
.end method

.method private final getMovieDetails(Lorg/jsoup/nodes/Document;)Leu/kanade/tachiyomi/animesource/model/SAnime;
    .locals 12

    .line 172
    sget-object v0, Leu/kanade/tachiyomi/animesource/model/SAnime;->Companion:Leu/kanade/tachiyomi/animesource/model/SAnime$Companion;

    invoke-virtual {v0}, Leu/kanade/tachiyomi/animesource/model/SAnime$Companion;->create()Leu/kanade/tachiyomi/animesource/model/SAnime;

    move-result-object v0

    const/4 v1, 0x2

    .line 173
    invoke-interface {v0, v1}, Leu/kanade/tachiyomi/animesource/model/SAnime;->setStatus(I)V

    const-string v1, "div.post-image img"

    .line 174
    invoke-virtual {p1, v1}, Lorg/jsoup/nodes/Document;->select(Ljava/lang/String;)Lorg/jsoup/select/Elements;

    move-result-object v1

    const-string v2, "src"

    invoke-virtual {v1, v2}, Lorg/jsoup/select/Elements;->attr(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v1, "thumbString"

    .line 175
    invoke-static {v3, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v4, " "

    const-string v5, "%20"

    const/4 v6, 0x0

    const/4 v7, 0x4

    const/4 v8, 0x0

    invoke-static/range {v3 .. v8}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Leu/kanade/tachiyomi/animesource/model/SAnime;->setThumbnail_url(Ljava/lang/String;)V

    const-string v1, ".cat-links a"

    .line 176
    invoke-virtual {p1, v1}, Lorg/jsoup/nodes/Document;->select(Ljava/lang/String;)Lorg/jsoup/select/Elements;

    move-result-object v1

    const-string v2, "genreElements"

    .line 177
    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v1, Ljava/lang/Iterable;

    .line 369
    new-instance v2, Ljava/util/ArrayList;

    const/16 v3, 0xa

    invoke-static {v1, v3}, Lkotlin/collections/CollectionsKt;->collectionSizeOrDefault(Ljava/lang/Iterable;I)I

    move-result v3

    invoke-direct {v2, v3}, Ljava/util/ArrayList;-><init>(I)V

    check-cast v2, Ljava/util/Collection;

    .line 370
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .line 371
    check-cast v3, Lorg/jsoup/nodes/Element;

    .line 177
    invoke-virtual {v3}, Lorg/jsoup/nodes/Element;->text()Ljava/lang/String;

    move-result-object v4

    const-string v3, "it.text()"

    invoke-static {v4, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v5, ","

    const-string v6, ""

    const/4 v7, 0x0

    const/4 v8, 0x4

    const/4 v9, 0x0

    invoke-static/range {v4 .. v9}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    check-cast v3, Ljava/lang/CharSequence;

    invoke-static {v3}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    .line 371
    invoke-interface {v2, v3}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 372
    :cond_0
    check-cast v2, Ljava/util/List;

    .line 178
    move-object v3, v2

    check-cast v3, Ljava/lang/Iterable;

    const-string v1, ", "

    move-object v4, v1

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/16 v10, 0x3e

    const/4 v11, 0x0

    invoke-static/range {v3 .. v11}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Leu/kanade/tachiyomi/animesource/model/SAnime;->setGenre(Ljava/lang/String;)V

    const-string v1, "div.entry-content"

    .line 179
    invoke-virtual {p1, v1}, Lorg/jsoup/nodes/Document;->select(Ljava/lang/String;)Lorg/jsoup/select/Elements;

    move-result-object p1

    invoke-virtual {p1}, Lorg/jsoup/select/Elements;->text()Ljava/lang/String;

    move-result-object p1

    const-string v1, "document.select(\"p.storyline\").text()"

    invoke-static {p1, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast p1, Ljava/lang/CharSequence;

    invoke-static {p1}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Leu/kanade/tachiyomi/animesource/model/SAnime;->setDescription(Ljava/lang/String;)V

    return-object v0
.end method

.method private final getMovieMedia(Lorg/jsoup/nodes/Document;)Ljava/util/List;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lorg/jsoup/nodes/Document;",
            ")",
            "Ljava/util/List<",
            "Leu/kanade/tachiyomi/animesource/model/SEpisode;",
            ">;"
        }
    .end annotation

    const-string v0, "div.entry-content a[href*='ftpbd.net/FTP-']"

    .line 275
    invoke-virtual {p1, v0}, Lorg/jsoup/nodes/Document;->select(Ljava/lang/String;)Lorg/jsoup/select/Elements;

    move-result-object v0

    invoke-virtual {v0}, Lorg/jsoup/select/Elements;->last()Lorg/jsoup/nodes/Element;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const-string v2, "href"

    invoke-virtual {v0, v2}, Lorg/jsoup/nodes/Element;->attr(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_0

    const-string v3, " "

    const-string v4, "%20"

    const/4 v5, 0x0

    const/4 v6, 0x4

    const/4 v7, 0x0

    invoke-static/range {v2 .. v7}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    move-object v0, v1

    :goto_0
    const-string v2, ".badge-wrapper .badge-fill"

    .line 276
    invoke-virtual {p1, v2}, Lorg/jsoup/nodes/Document;->select(Ljava/lang/String;)Lorg/jsoup/select/Elements;

    move-result-object p1

    const-string v2, "document.select(\".badge-wrapper .badge-fill\")"

    invoke-static {p1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast p1, Ljava/util/List;

    invoke-static {p1}, Lkotlin/collections/CollectionsKt;->lastOrNull(Ljava/util/List;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lorg/jsoup/nodes/Element;

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Lorg/jsoup/nodes/Element;->text()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_1

    const-string v3, "|"

    const-string v4, "\u2022"

    const/4 v5, 0x0

    const/4 v6, 0x4

    const/4 v7, 0x0

    invoke-static/range {v2 .. v7}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 279
    :cond_1
    sget-object p1, Leu/kanade/tachiyomi/animesource/model/SEpisode;->Companion:Leu/kanade/tachiyomi/animesource/model/SEpisode$Companion;

    invoke-virtual {p1}, Leu/kanade/tachiyomi/animesource/model/SEpisode$Companion;->create()Leu/kanade/tachiyomi/animesource/model/SEpisode;

    move-result-object p1

    const-string v2, ""

    if-nez v0, :cond_2

    move-object v0, v2

    .line 280
    :cond_2
    invoke-interface {p1, v0}, Leu/kanade/tachiyomi/animesource/model/SEpisode;->setUrl(Ljava/lang/String;)V

    const-string v0, "Movie"

    .line 281
    invoke-interface {p1, v0}, Leu/kanade/tachiyomi/animesource/model/SEpisode;->setName(Ljava/lang/String;)V

    const/high16 v0, 0x3f800000    # 1.0f

    .line 282
    invoke-interface {p1, v0}, Leu/kanade/tachiyomi/animesource/model/SEpisode;->setEpisode_number(F)V

    if-nez v1, :cond_3

    move-object v1, v2

    .line 283
    :cond_3
    invoke-interface {p1, v1}, Leu/kanade/tachiyomi/animesource/model/SEpisode;->setScanlator(Ljava/lang/String;)V

    .line 278
    invoke-static {p1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method private static final getSearchAnime$fetchAnimeByType(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Ljava/lang/String;Ljava/lang/String;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Ljava/util/List<",
            "+",
            "Leu/kanade/tachiyomi/animesource/model/SAnime;",
            ">;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 92
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$fetchAnimeByType$2;

    const/4 v2, 0x0

    invoke-direct {v1, p0, p1, p2, v2}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$fetchAnimeByType$2;-><init>(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Ljava/lang/String;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    check-cast v1, Lkotlin/jvm/functions/Function2;

    invoke-static {v0, v1, p3}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method private final getSeriesDetails(Lorg/jsoup/nodes/Document;)Leu/kanade/tachiyomi/animesource/model/SAnime;
    .locals 12

    .line 184
    sget-object v0, Leu/kanade/tachiyomi/animesource/model/SAnime;->Companion:Leu/kanade/tachiyomi/animesource/model/SAnime$Companion;

    invoke-virtual {v0}, Leu/kanade/tachiyomi/animesource/model/SAnime$Companion;->create()Leu/kanade/tachiyomi/animesource/model/SAnime;

    move-result-object v0

    const/4 v1, 0x0

    .line 185
    invoke-interface {v0, v1}, Leu/kanade/tachiyomi/animesource/model/SAnime;->setStatus(I)V

    const-string v1, "div.movie-detail-banner img"

    .line 186
    invoke-virtual {p1, v1}, Lorg/jsoup/nodes/Document;->select(Ljava/lang/String;)Lorg/jsoup/select/Elements;

    move-result-object v1

    const-string v2, "src"

    invoke-virtual {v1, v2}, Lorg/jsoup/select/Elements;->attr(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v1, "thumbString"

    .line 187
    invoke-static {v3, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v4, " "

    const-string v5, "%20"

    const/4 v6, 0x0

    const/4 v7, 0x4

    const/4 v8, 0x0

    invoke-static/range {v3 .. v8}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Leu/kanade/tachiyomi/animesource/model/SAnime;->setThumbnail_url(Ljava/lang/String;)V

    const-string v1, "div.ganre-wrapper a"

    .line 188
    invoke-virtual {p1, v1}, Lorg/jsoup/nodes/Document;->select(Ljava/lang/String;)Lorg/jsoup/select/Elements;

    move-result-object v1

    const-string v2, "genreElements"

    .line 189
    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v1, Ljava/lang/Iterable;

    .line 373
    new-instance v2, Ljava/util/ArrayList;

    const/16 v3, 0xa

    invoke-static {v1, v3}, Lkotlin/collections/CollectionsKt;->collectionSizeOrDefault(Ljava/lang/Iterable;I)I

    move-result v3

    invoke-direct {v2, v3}, Ljava/util/ArrayList;-><init>(I)V

    check-cast v2, Ljava/util/Collection;

    .line 374
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .line 375
    check-cast v3, Lorg/jsoup/nodes/Element;

    .line 189
    invoke-virtual {v3}, Lorg/jsoup/nodes/Element;->text()Ljava/lang/String;

    move-result-object v4

    const-string v3, "it.text()"

    invoke-static {v4, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v5, ","

    const-string v6, ""

    const/4 v7, 0x0

    const/4 v8, 0x4

    const/4 v9, 0x0

    invoke-static/range {v4 .. v9}, Lkotlin/text/StringsKt;->replace$default(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    check-cast v3, Ljava/lang/CharSequence;

    invoke-static {v3}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    .line 375
    invoke-interface {v2, v3}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 376
    :cond_0
    check-cast v2, Ljava/util/List;

    .line 190
    move-object v3, v2

    check-cast v3, Ljava/lang/Iterable;

    const-string v1, ", "

    move-object v4, v1

    check-cast v4, Ljava/lang/CharSequence;

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/16 v10, 0x3e

    const/4 v11, 0x0

    invoke-static/range {v3 .. v11}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Leu/kanade/tachiyomi/animesource/model/SAnime;->setGenre(Ljava/lang/String;)V

    const-string v1, "p.storyline"

    .line 191
    invoke-virtual {p1, v1}, Lorg/jsoup/nodes/Document;->select(Ljava/lang/String;)Lorg/jsoup/select/Elements;

    move-result-object p1

    invoke-virtual {p1}, Lorg/jsoup/select/Elements;->text()Ljava/lang/String;

    move-result-object p1

    const-string v1, "document.select(\"p.storyline\").text()"

    invoke-static {p1, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast p1, Ljava/lang/CharSequence;

    invoke-static {p1}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Leu/kanade/tachiyomi/animesource/model/SAnime;->setDescription(Ljava/lang/String;)V

    return-object v0
.end method

.method private final sortByTitle(Ljava/util/List;Ljava/lang/String;)Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "+",
            "Leu/kanade/tachiyomi/animesource/model/SAnime;",
            ">;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Leu/kanade/tachiyomi/animesource/model/SAnime;",
            ">;"
        }
    .end annotation

    .line 269
    check-cast p1, Ljava/lang/Iterable;

    .line 377
    new-instance v0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$sortByTitle$$inlined$sortedByDescending$1;

    invoke-direct {v0, p2}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$sortByTitle$$inlined$sortedByDescending$1;-><init>(Ljava/lang/String;)V

    check-cast v0, Ljava/util/Comparator;

    invoke-static {p1, v0}, Lkotlin/collections/CollectionsKt;->sortedWith(Ljava/lang/Iterable;Ljava/util/Comparator;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method private static final sortByTitle$diceCoefficient(Ljava/lang/String;Ljava/lang/String;)D
    .locals 7

    .line 253
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x2

    if-lt v0, v1, :cond_4

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-ge v0, v1, :cond_0

    goto :goto_2

    .line 255
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    .line 256
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    .line 258
    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    const/4 v3, 0x0

    const/4 v4, 0x0

    :goto_0
    const-string v5, "substring(...)"

    if-ge v4, v0, :cond_1

    add-int/lit8 v6, v4, 0x2

    .line 261
    invoke-virtual {p0, v4, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v2, v6}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_1
    const/4 p0, 0x0

    :goto_1
    if-ge v3, v1, :cond_3

    add-int/lit8 v4, v3, 0x2

    .line 264
    invoke-virtual {p1, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 265
    invoke-virtual {v2, v4}, Ljava/util/HashSet;->remove(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    add-int/lit8 p0, p0, 0x1

    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_3
    const-wide/high16 v2, 0x4000000000000000L    # 2.0

    int-to-double p0, p0

    mul-double p0, p0, v2

    add-int/2addr v0, v1

    int-to-double v0, v0

    div-double/2addr p0, v0

    return-wide p0

    :cond_4
    :goto_2
    const-wide/16 p0, 0x0

    return-wide p0
.end method

.method private final sortEpisodes(Ljava/util/List;)Ljava/util/List;
    .locals 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$EpisodeData;",
            ">;)",
            "Ljava/util/List<",
            "Leu/kanade/tachiyomi/animesource/model/SEpisode;",
            ">;"
        }
    .end annotation

    .line 319
    new-instance v0, Ljava/util/ArrayList;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    .line 322
    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_7

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$EpisodeData;

    .line 323
    invoke-virtual {v4}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$EpisodeData;->getSeasonEpisode()Ljava/lang/String;

    move-result-object v5

    sget-object v6, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->SEASON_PATTERN:Lkotlin/text/Regex;

    .line 324
    check-cast v5, Ljava/lang/CharSequence;

    const/4 v7, 0x2

    const/4 v8, 0x0

    invoke-static {v6, v5, v1, v7, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v6

    sget-object v9, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->EPISODE_PATTERN:Lkotlin/text/Regex;

    .line 325
    invoke-static {v9, v5, v1, v7, v8}, Lkotlin/text/Regex;->find$default(Lkotlin/text/Regex;Ljava/lang/CharSequence;IILjava/lang/Object;)Lkotlin/text/MatchResult;

    move-result-object v5

    const/4 v7, 0x1

    if-eqz v6, :cond_0

    .line 326
    invoke-interface {v6}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v6

    if-eqz v6, :cond_0

    invoke-interface {v6, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    if-eqz v6, :cond_0

    invoke-static {v6}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v6

    goto :goto_1

    :cond_0
    move v6, v2

    :goto_1
    if-eqz v5, :cond_1

    .line 327
    invoke-interface {v5}, Lkotlin/text/MatchResult;->getGroupValues()Ljava/util/List;

    move-result-object v5

    if-eqz v5, :cond_1

    invoke-interface {v5, v7}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    if-eqz v5, :cond_1

    invoke-static {v5}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    :cond_1
    if-nez v6, :cond_2

    if-eqz v8, :cond_2

    .line 329
    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v2

    int-to-float v2, v2

    const/high16 v5, 0x41200000    # 10.0f

    div-float/2addr v2, v5

    goto :goto_3

    :cond_2
    if-eqz v8, :cond_4

    if-le v6, v2, :cond_3

    add-int/lit8 v3, v3, 0x1

    :cond_3
    if-le v6, v2, :cond_4

    goto :goto_2

    :cond_4
    add-int/lit8 v3, v3, 0x1

    :goto_2
    int-to-float v2, v3

    .line 338
    :goto_3
    sget-object v5, Leu/kanade/tachiyomi/animesource/model/SEpisode;->Companion:Leu/kanade/tachiyomi/animesource/model/SEpisode$Companion;

    invoke-virtual {v5}, Leu/kanade/tachiyomi/animesource/model/SEpisode$Companion;->create()Leu/kanade/tachiyomi/animesource/model/SEpisode;

    move-result-object v5

    .line 339
    invoke-virtual {v4}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$EpisodeData;->getVideoUrl()Ljava/lang/String;

    move-result-object v7

    const-string v8, ""

    if-nez v7, :cond_5

    move-object v7, v8

    :cond_5
    invoke-interface {v5, v7}, Leu/kanade/tachiyomi/animesource/model/SEpisode;->setUrl(Ljava/lang/String;)V

    .line 340
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$EpisodeData;->getSeasonEpisode()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v9, " - "

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$EpisodeData;->getEpisodeName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-interface {v5, v7}, Leu/kanade/tachiyomi/animesource/model/SEpisode;->setName(Ljava/lang/String;)V

    .line 341
    invoke-interface {v5, v2}, Leu/kanade/tachiyomi/animesource/model/SEpisode;->setEpisode_number(F)V

    .line 342
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$EpisodeData;->getQuality()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v7, " \u2022 "

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$EpisodeData;->getSize()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_6

    goto :goto_4

    :cond_6
    move-object v8, v4

    :goto_4
    invoke-virtual {v2, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v5, v2}, Leu/kanade/tachiyomi/animesource/model/SEpisode;->setScanlator(Ljava/lang/String;)V

    .line 337
    invoke-virtual {v0, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move v2, v6

    goto/16 :goto_0

    .line 347
    :cond_7
    check-cast v0, Ljava/util/List;

    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->asReversedMutable(Ljava/util/List;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method protected animeDetailsParse(Lokhttp3/Response;)Leu/kanade/tachiyomi/animesource/model/SAnime;
    .locals 3

    const-string v0, "response"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v0, 0x0

    const/4 v1, 0x1

    .line 150
    invoke-static {p1, v0, v1, v0}, Leu/kanade/tachiyomi/util/JsoupExtensionsKt;->asJsoup$default(Lokhttp3/Response;Ljava/lang/String;ILjava/lang/Object;)Lorg/jsoup/nodes/Document;

    move-result-object p1

    .line 152
    invoke-direct {p0, p1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getMediaType(Lorg/jsoup/nodes/Document;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_2

    const-string v1, "m"

    .line 155
    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-direct {p0, p1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getMovieDetails(Lorg/jsoup/nodes/Document;)Leu/kanade/tachiyomi/animesource/model/SAnime;

    move-result-object p1

    goto :goto_0

    :cond_0
    const-string v1, "s"

    .line 156
    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-direct {p0, p1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getSeriesDetails(Lorg/jsoup/nodes/Document;)Leu/kanade/tachiyomi/animesource/model/SAnime;

    move-result-object p1

    :goto_0
    return-object p1

    .line 157
    :cond_1
    new-instance p1, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Unsupported media type: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1

    .line 152
    :cond_2
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "Unknown media type"

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method protected animeDetailsRequest(Leu/kanade/tachiyomi/animesource/model/SAnime;)Lokhttp3/Request;
    .locals 4

    invoke-interface {p1}, Leu/kanade/tachiyomi/animesource/model/SAnime;->getUrl()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getGlobalHeaders()Lokhttp3/Headers;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x4

    invoke-static {p1, v0, v1, v2, v1}, Leu/kanade/tachiyomi/network/RequestsKt;->GET$default(Ljava/lang/String;Lokhttp3/Headers;Lokhttp3/CacheControl;ILjava/lang/Object;)Lokhttp3/Request;

    move-result-object p1

    return-object p1
.end method

.method protected episodeListParse(Lokhttp3/Response;)Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lokhttp3/Response;",
            ")",
            "Ljava/util/List<",
            "Leu/kanade/tachiyomi/animesource/model/SEpisode;",
            ">;"
        }
    .end annotation

    const-string v0, "response"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 235
    new-instance p1, Lkotlin/NotImplementedError;

    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-direct {p1, v0, v1, v0}, Lkotlin/NotImplementedError;-><init>(Ljava/lang/String;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    throw p1
.end method

.method protected episodeListRequest(Leu/kanade/tachiyomi/animesource/model/SAnime;)Lokhttp3/Request;
    .locals 1

    invoke-virtual {p0, p1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->animeDetailsRequest(Leu/kanade/tachiyomi/animesource/model/SAnime;)Lokhttp3/Request;

    move-result-object p1

    return-object p1
.end method

.method public getBaseUrl()Ljava/lang/String;
    .locals 1

    const-string v0, "https://old.ftpbd.net"

    return-object v0
.end method

.method public getEpisodeList(Leu/kanade/tachiyomi/animesource/model/SAnime;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Leu/kanade/tachiyomi/animesource/model/SAnime;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Ljava/util/List<",
            "+",
            "Leu/kanade/tachiyomi/animesource/model/SEpisode;",
            ">;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 197
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;

    const/4 v2, 0x0

    invoke-direct {v1, p1, p0, v2}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getEpisodeList$2;-><init>(Leu/kanade/tachiyomi/animesource/model/SAnime;Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Lkotlin/coroutines/Continuation;)V

    check-cast v1, Lkotlin/jvm/functions/Function2;

    invoke-static {v0, v1, p2}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public getLang()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->lang:Ljava/lang/String;

    return-object v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->name:Ljava/lang/String;

    return-object v0
.end method

.method public getPopularAnime(ILkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Leu/kanade/tachiyomi/animesource/model/AnimesPage;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 57
    invoke-virtual {p0, p1, p2}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getLatestUpdates(ILkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public getSearchAnime(ILjava/lang/String;Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            "Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Leu/kanade/tachiyomi/animesource/model/AnimesPage;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    if-nez p2, :cond_q_not_null

    const-string p2, ""

    :cond_q_not_null
    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_filter_search

    if-nez p3, :cond_f_not_null

    goto :cond_filter_search

    :cond_f_not_null
    invoke-virtual {p3}, Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_filter_search

    invoke-virtual {p0, p1, p2, p3}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->searchAnimeRequest(ILjava/lang/String;Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;)Lokhttp3/Request;

    move-result-object p1

    invoke-virtual {p0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getClient()Lokhttp3/OkHttpClient;

    move-result-object p2

    invoke-virtual {p2, p1}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object p1

    invoke-interface {p1}, Lokhttp3/Call;->execute()Lokhttp3/Response;

    move-result-object p1

    invoke-virtual {p0, p1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->latestUpdatesParse(Lokhttp3/Response;)Leu/kanade/tachiyomi/animesource/model/AnimesPage;

    move-result-object p1

    return-object p1

    :cond_filter_search
    instance-of p1, p4, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$1;

    if-eqz p1, :cond_0

    move-object p1, p4

    check-cast p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$1;

    iget p3, p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$1;->label:I

    const/high16 v0, -0x80000000

    and-int/2addr p3, v0

    if-eqz p3, :cond_0

    iget p3, p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$1;->label:I

    sub-int/2addr p3, v0

    iput p3, p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$1;->label:I

    goto :goto_0

    :cond_0
    new-instance p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$1;

    invoke-direct {p1, p0, p4}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$1;-><init>(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Lkotlin/coroutines/Continuation;)V

    :goto_0
    iget-object p3, p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$1;->result:Ljava/lang/Object;

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object p4

    .line 91
    iget v0, p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$1;->label:I

    const/4 v1, 0x1

    if-eqz v0, :cond_2

    if-ne v0, v1, :cond_1

    iget-object p2, p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$1;->L$1:Ljava/lang/Object;

    check-cast p2, Ljava/lang/String;

    iget-object p1, p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$1;->L$0:Ljava/lang/Object;

    check-cast p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;

    invoke-static {p3}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    goto :goto_1

    :cond_1
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_2
    invoke-static {p3}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    .line 128
    new-instance p3, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;

    const/4 v0, 0x0

    invoke-direct {p3, p0, p2, v0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$2;-><init>(Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    check-cast p3, Lkotlin/jvm/functions/Function2;

    iput-object p0, p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$1;->L$0:Ljava/lang/Object;

    iput-object p2, p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$1;->L$1:Ljava/lang/Object;

    iput v1, p1, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd$getSearchAnime$1;->label:I

    invoke-static {p3, p1}, Lkotlinx/coroutines/CoroutineScopeKt;->coroutineScope(Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p3

    if-ne p3, p4, :cond_3

    return-object p4

    :cond_3
    move-object p1, p0

    :goto_1
    check-cast p3, Lkotlin/Pair;

    invoke-virtual {p3}, Lkotlin/Pair;->component1()Ljava/lang/Object;

    move-result-object p4

    check-cast p4, Ljava/util/List;

    invoke-virtual {p3}, Lkotlin/Pair;->component2()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Ljava/util/List;

    .line 133
    check-cast p4, Ljava/util/Collection;

    check-cast p3, Ljava/lang/Iterable;

    invoke-static {p4, p3}, Lkotlin/collections/CollectionsKt;->plus(Ljava/util/Collection;Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object p3

    .line 135
    new-instance p4, Leu/kanade/tachiyomi/animesource/model/AnimesPage;

    invoke-direct {p1, p3, p2}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->sortByTitle(Ljava/util/List;Ljava/lang/String;)Ljava/util/List;

    move-result-object p1

    const/4 p2, 0x0

    invoke-direct {p4, p1, p2}, Leu/kanade/tachiyomi/animesource/model/AnimesPage;-><init>(Ljava/util/List;Z)V

    return-object p4
.end method

.method public getSupportsLatest()Z
    .locals 1

    iget-boolean v0, p0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->supportsLatest:Z

    return v0
.end method

.method public getVideoList(Leu/kanade/tachiyomi/animesource/model/SEpisode;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Leu/kanade/tachiyomi/animesource/model/SEpisode;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Ljava/util/List<",
            "Leu/kanade/tachiyomi/animesource/model/Video;",
            ">;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 242
    invoke-interface {p1}, Leu/kanade/tachiyomi/animesource/model/SEpisode;->getUrl()Ljava/lang/String;

    move-result-object p2

    const-string v0, ""

    if-nez p2, :cond_0

    move-object v2, v0

    goto :goto_0

    :cond_0
    move-object v2, p2

    .line 243
    :goto_0
    move-object v4, v2

    invoke-interface {p1}, Leu/kanade/tachiyomi/animesource/model/SEpisode;->getScanlator()Ljava/lang/String;

    move-result-object p2

    if-eqz p2, :cond_use_default_quality

    move-object v3, p2

    goto :goto_1

    :cond_use_default_quality
    const-string v3, "Default"

    .line 244
    :goto_1
            new-instance v6, Lokhttp3/Headers$Builder;
        
            invoke-direct {v6}, Lokhttp3/Headers$Builder;-><init>()V
        
            const-string v0, "User-Agent"
        
            const-string v1, "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        
            invoke-virtual {v6, v0, v1}, Lokhttp3/Headers$Builder;->add(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Headers$Builder;
        
            const-string v0, "Referer"
        
            const-string v1, "https://server3.ftpbd.net/"
        
            invoke-virtual {v6, v0, v1}, Lokhttp3/Headers$Builder;->add(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Headers$Builder;
        
            invoke-virtual {v6}, Lokhttp3/Headers$Builder;->build()Lokhttp3/Headers;
        
            move-result-object v6        .line 241
    :goto_2
    new-instance p1, Leu/kanade/tachiyomi/animesource/model/Video;

    const/4 v5, 0x0

    const/16 v7, 0x8

    const/4 v8, 0x0

    move-object v1, p1

    invoke-direct/range {v1 .. v8}, Leu/kanade/tachiyomi/animesource/model/Video;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/net/Uri;Lokhttp3/Headers;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 240
    invoke-static {p1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method
























.method public getFilterList()Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;
    .locals 1

    invoke-static {}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/Filters;->getFilterList()Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;

    move-result-object v0

    return-object v0
.end method


.method protected latestUpdatesParse(Lokhttp3/Response;)Leu/kanade/tachiyomi/animesource/model/AnimesPage;
    .locals 10
    const-string v0, "response"
    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V
    const/4 v0, 0x0
    const/4 v1, 0x1
    invoke-static {p1, v0, v1, v0}, Leu/kanade/tachiyomi/util/JsoupExtensionsKt;->asJsoup$default(Lokhttp3/Response;Ljava/lang/String;ILjava/lang/Object;)Lorg/jsoup/nodes/Document;
    move-result-object v1
    invoke-virtual {p1}, Lokhttp3/Response;->close()V
    const-string p1, "article"
    invoke-virtual {v1, p1}, Lorg/jsoup/nodes/Document;->select(Ljava/lang/String;)Lorg/jsoup/select/Elements;
    move-result-object p1
    check-cast p1, Ljava/lang/Iterable;
    new-instance v2, Ljava/util/ArrayList;
    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V
    check-cast v2, Ljava/util/Collection;
    invoke-interface {p1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;
    move-result-object v3
    :goto_loop
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z
    move-result p1
    if-eqz p1, :cond_loop_end
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object p1
    check-cast p1, Lorg/jsoup/nodes/Element;
    sget-object v4, Leu/kanade/tachiyomi/animesource/model/SAnime;->Companion:Leu/kanade/tachiyomi/animesource/model/SAnime$Companion;
    invoke-virtual {v4}, Leu/kanade/tachiyomi/animesource/model/SAnime$Companion;->create()Leu/kanade/tachiyomi/animesource/model/SAnime;
    move-result-object v4
    const-string v5, "div.post-image img"
    invoke-virtual {p1, v5}, Lorg/jsoup/nodes/Element;->selectFirst(Ljava/lang/String;)Lorg/jsoup/nodes/Element;
    move-result-object v5
    if-eqz v5, :cond_img_skip
    const-string v6, "src"
    invoke-virtual {v5, v6}, Lorg/jsoup/nodes/Element;->attr(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v6
    invoke-interface {v4, v6}, Leu/kanade/tachiyomi/animesource/model/SAnime;->setThumbnail_url(Ljava/lang/String;)V
    const-string v6, "alt"
    invoke-virtual {v5, v6}, Lorg/jsoup/nodes/Element;->attr(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v5
    invoke-interface {v4, v5}, Leu/kanade/tachiyomi/animesource/model/SAnime;->setTitle(Ljava/lang/String;)V
    :cond_img_skip
    const-string v5, "div.post-image a"
    invoke-virtual {p1, v5}, Lorg/jsoup/nodes/Element;->selectFirst(Ljava/lang/String;)Lorg/jsoup/nodes/Element;
    move-result-object p1
    if-eqz p1, :cond_link_skip
    const-string v5, "abs:href"
    invoke-virtual {p1, v5}, Lorg/jsoup/nodes/Element;->attr(Ljava/lang/String;)Ljava/lang/String;
    move-result-object p1
    invoke-interface {v4, p1}, Leu/kanade/tachiyomi/animesource/model/SAnime;->setUrl(Ljava/lang/String;)V
    :cond_link_skip
    invoke-interface {v4}, Leu/kanade/tachiyomi/animesource/model/SAnime;->getTitle()Ljava/lang/String;
    move-result-object p1
    if-eqz p1, :cond_goto_loop
    invoke-interface {v2, v4}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z
    :cond_goto_loop
    goto :goto_loop
    :cond_loop_end
    check-cast v2, Ljava/util/List;
    const-string p1, "a.next.page-numbers"
    invoke-virtual {v1, p1}, Lorg/jsoup/nodes/Document;->selectFirst(Ljava/lang/String;)Lorg/jsoup/nodes/Element;
    move-result-object p1
    if-eqz p1, :cond_no_next
    const/4 p1, 0x1
    goto :goto_next
    :cond_no_next
    const/4 p1, 0x0
    :goto_next
    new-instance v0, Leu/kanade/tachiyomi/animesource/model/AnimesPage;
    invoke-direct {v0, v2, p1}, Leu/kanade/tachiyomi/animesource/model/AnimesPage;-><init>(Ljava/util/List;Z)V
    return-object v0
.end method

.method protected latestUpdatesRequest(I)Lokhttp3/Request;
    .locals 4

    const/4 v0, 0x1

    if-ne p1, v0, :cond_page_one

    invoke-virtual {p0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getBaseUrl()Ljava/lang/String;

    move-result-object p1

    goto :goto_build

    :cond_page_one
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getBaseUrl()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "/page/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, "/"

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :goto_build
    invoke-direct {p0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getGlobalHeaders()Lokhttp3/Headers;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x4

    invoke-static {p1, v0, v1, v2, v1}, Leu/kanade/tachiyomi/network/RequestsKt;->GET$default(Ljava/lang/String;Lokhttp3/Headers;Lokhttp3/CacheControl;ILjava/lang/Object;)Lokhttp3/Request;

    move-result-object p1

    return-object p1
.end method

.method protected popularAnimeParse(Lokhttp3/Response;)Leu/kanade/tachiyomi/animesource/model/AnimesPage;
    .locals 1
    invoke-virtual {p0, p1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->latestUpdatesParse(Lokhttp3/Response;)Leu/kanade/tachiyomi/animesource/model/AnimesPage;
    move-result-object v0
    return-object v0
.end method

.method protected popularAnimeRequest(I)Lokhttp3/Request;
    .locals 1
    invoke-virtual {p0, p1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->latestUpdatesRequest(I)Lokhttp3/Request;
    move-result-object p1
    return-object p1
.end method

.method protected searchAnimeParse(Lokhttp3/Response;)Leu/kanade/tachiyomi/animesource/model/AnimesPage;
    .locals 1
    invoke-virtual {p0, p1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->latestUpdatesParse(Lokhttp3/Response;)Leu/kanade/tachiyomi/animesource/model/AnimesPage;
    move-result-object v0
    return-object v0
.end method

.method protected searchAnimeRequest(ILjava/lang/String;Leu/kanade/tachiyomi/animesource/model/AnimeFilterList;)Lokhttp3/Request;
    .locals 4
    if-eqz p2, :cond_empty
    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z
    move-result v0
    if-eqz v0, :cond_not_empty
    :cond_empty
    invoke-virtual {p0, p1}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->popularAnimeRequest(I)Lokhttp3/Request;
    move-result-object p1
    return-object p1
    :cond_not_empty
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {p0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getBaseUrl()Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const-string v1, "/page/"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v1, "/?s="
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object p1
    invoke-direct {p0}, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FtpBd;->getGlobalHeaders()Lokhttp3/Headers;
    move-result-object v0
    const/4 v1, 0x0
    const/4 v2, 0x4
    invoke-static {p1, v0, v1, v2, v1}, Leu/kanade/tachiyomi/network/RequestsKt;->GET$default(Ljava/lang/String;Lokhttp3/Headers;Lokhttp3/CacheControl;ILjava/lang/Object;)Lokhttp3/Request;
    move-result-object p1
    return-object p1
.end method
