## Android Setup

**The following steps are required for Android**

You need to manually apply a plugin to your app, from `android/app/build.gradle`:

Right below `apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"`

add the following line:

`apply from: project(':flutter_config').projectDir.getPath() + "/dotenv.gradle"`

## Usage in Java/Kotlin Code

Config variables set in `.env` are available to your Java or Kotlin classes via `BuildConfig`:

```kotlin
fun getApiClient(): HttpURLConnection {
    val url = URL(BuildConfig.API_URL);
    // ...
}
```

## Usage in Gradle

You can read environment varibles from your Gradle configuration:

```groovy
defaultConfig {
    applicationId project.env.get("APP_ID")
}
```

## Usage in XML files

You can use env variables to configure libraries in `AndroidManifest.xml` and other xml files:

```xml
<meta-data
  android:name="com.google.android.geo.API_KEY"
  android:value="@string/GOOGLE_MAPS_API_KEY" />
```

## Different environments

Save config for different environments in different files: `.env.staging`, `.env.production`, etc.

The same environment variable can be used to assemble releases with a different config:

```
$ cd android && ENVFILE=.env.staging ./gradlew assembleRelease
```

Alternatively, you can define a map in `build.gradle` associating builds with env files. Do it before the `apply from` call, and use build cases in lowercase, like:

```
project.ext.envConfigFiles = [
    debug: ".env.development",
    release: ".env.production",
    anothercustombuild: ".env",
]

apply from: project(':flutter_config').projectDir.getPath() + "/dotenv.gradle"
```

## Different Package Names

In `android/app/build.gradle`, if you use `applicationIdSuffix` or `applicationId` that is different from the package name indicated in `AndroidManifest.xml` in `<manifest package="...">` tag, for example, to support different build variants:
Add this in `android/app/build.gradle`

```
defaultConfig {
    ...
    resValue "string", "build_config_package", "YOUR_PACKAGE_NAME_IN_ANDROIDMANIFEST.XML"
}
```

## Note

All variables are strings, so you may need to cast them. For instance, in Gradle:

```
versionCode project.env.get("VERSION_CODE").toInteger()
```

Once again, remember variables stored in `.env` are published with your code, so **DO NOT put anything sensitive there like your app `signingConfigs`.**
