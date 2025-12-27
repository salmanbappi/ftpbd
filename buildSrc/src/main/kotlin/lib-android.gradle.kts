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

    namespace = "eu.kanade.tachiyomi.lib.${project.name.replace("-", "")}"

    buildFeatures {
        androidResources = false
    }
}

dependencies {
    val libs = versionCatalogs.named("libs")
    compileOnly(libs.findBundle("provided").get())
    compileOnly(libs.findBundle("common").get())
}

tasks.register("printDependentExtensions") {
    doLast {
        project.printDependentExtensions()
    }
}
