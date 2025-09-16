#########################################
# === Flutter Baseline ProGuard Rules ===
#########################################

# Keep Flutter engine and embedding classes
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# Keep classes used by Flutter plugins (reflection heavy)
-keep class io.flutter.plugin.** { *; }
-dontwarn io.flutter.plugin.**

# Keep generated registrant (plugins registration)
-keep class io.flutter.plugins.GeneratedPluginRegistrant { *; }

#########################################
# === Firebase / Google Services Rules ===
#########################################

# Keep Firebase & Google Play services
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

#########################################
# === Gson / JSON Deserialization Rules ===
#########################################

# If you use Gson (or any reflection-based JSON parser)
-keep class com.google.gson.** { *; }
-dontwarn com.google.gson.**

# Keep model classes annotated with @SerializedName (replace your.package.model)
-keepclassmembers class your.package.model.** {
    <fields>;
}

#########################################
# === Retrofit / OkHttp Rules (if used) ===
#########################################

-keep class retrofit2.** { *; }
-dontwarn retrofit2.**
-keep class okhttp3.** { *; }
-dontwarn okhttp3.**

#########################################
# === General Safe Shrinking ===
#########################################

# Keep annotations (some libs depend on them)
-keepattributes *Annotation*

# Don’t obfuscate native method names (Flutter calls into them)
-keepclasseswithmembers class * {
    native <methods>;
}

# Keep all public constructors (reflection)
-keepclassmembers class * {
    public <init>(...);
}

#########################################
# === Optional aggressive shrinking ===
#########################################

# Don’t print notes about missing classes
-dontnote

# You can allow obfuscation but keep class members for reflection-heavy libs
# (Already covered above for Firebase, Gson, Retrofit)
