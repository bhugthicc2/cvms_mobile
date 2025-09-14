plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.jrmsukcdrrmsu.cvms_mobile"
    compileSdk = 35 
    ndkVersion = "27.0.12077973"


    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.jrmsukcdrrmsu.cvms_mobile"
        minSdk = 23 
        targetSdk = 35 
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
        isMinifyEnabled = true
        isShrinkResources = true
        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )
    }
    }

    externalNativeBuild {
    cmake {
        version = "3.31.5"
    }
}

}

flutter {
    source = "../.."
}
