plugins {
    id("com.android.library")
    kotlin("android")
    id("kotlinx-serialization")
}

android {
    compileSdk = AndroidConfig.compileSdk

    defaultConfig {
        minSdk = AndroidConfig.minSdk
    }

    namespace = "extensions.core"

    sourceSets {
        named("main") {
            manifest.srcFile("AndroidManifest.xml")
            res.setSrcDirs(listOf("src/main/res"))
        }
    }

    buildFeatures {
        resValues = false
    }
}

dependencies {
    val libs = versionCatalogs.named("libs")
    compileOnly(libs.findBundle("provided").get())
    compileOnly(libs.findBundle("common").get())
}
