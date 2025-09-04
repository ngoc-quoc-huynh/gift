import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val releaseKeystoreProperties = Properties()
val releaseKeystorePropertiesFile = rootProject.file(".signing/keystore.properties")
if (releaseKeystorePropertiesFile.exists()) {
    releaseKeystoreProperties.load(FileInputStream(releaseKeystorePropertiesFile))
}

android {
    namespace = "dev.huynh.gift.box"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_21
        targetCompatibility = JavaVersion.VERSION_21
    }

    kotlin {
        jvmToolchain(21)
    }

    defaultConfig {
        applicationId = "dev.huynh.gift.box"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = releaseKeystoreProperties["keyAlias"] as String?
            keyPassword = releaseKeystoreProperties["keyPassword"] as String?
            storeFile = rootProject.file(".signing/keystore.jks")
            storePassword = releaseKeystoreProperties["keyPassword"] as String?
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            ndk {
                abiFilters.add("arm64-v8a")
            }
            isMinifyEnabled = true
            isShrinkResources = true
        }
    }
}

base {
    archivesName = "gift_box_v${android.defaultConfig.versionName}"
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.window:window-core-android:1.5.0")
}
