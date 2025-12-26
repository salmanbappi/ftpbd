.class public Leu/kanade/tachiyomi/animeextension/all/ftpbd/FilterData;
.super Ljava/lang/Object;

.field public static final CATEGORIES:[Ljava/lang/String;

.method static constructor <clinit>()V
    .locals 3

    # Categories
    const/16 v0, 0xb
    new-array v0, v0, [Ljava/lang/String;
    const/16 v1, 0x0
    const-string v2, "All (Home)"
    aput-object v2, v0, v1
    const/16 v1, 0x1
    const-string v2, "English Movies"
    aput-object v2, v0, v1
    const/16 v1, 0x2
    const-string v2, "Hindi Movies"
    aput-object v2, v0, v1
    const/16 v1, 0x3
    const-string v2, "Bengali Movies"
    aput-object v2, v0, v1
    const/16 v1, 0x4
    const-string v2, "South Indian Movies"
    aput-object v2, v0, v1
    const/16 v1, 0x5
    const-string v2, "Animation Movies"
    aput-object v2, v0, v1
    const/16 v1, 0x6
    const-string v2, "English & Foreign TV Series"
    aput-object v2, v0, v1
    const/16 v1, 0x7
    const-string v2, "Anime & Cartoon TV Series"
    aput-object v2, v0, v1
    const/16 v1, 0x8
    const-string v2, "Hindi TV Series"
    aput-object v2, v0, v1
    const/16 v1, 0x9
    const-string v2, "Bengali Web Series"
    aput-object v2, v0, v1
    const/16 v1, 0xa
    const-string v2, "Documentary"
    aput-object v2, v0, v1
    sput-object v0, Leu/kanade/tachiyomi/animeextension/all/ftpbd/FilterData;->CATEGORIES:[Ljava/lang/String;

    return-void
.end method