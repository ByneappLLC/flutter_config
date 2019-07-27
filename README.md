# Config Variables for your Flutter apps

Plugin that exposes environment variables to your Dart code in Flutter as well as to your native code in iOS and Android.

Inspired by [react-native-config](https://github.com/luggit/react-native-config)

## Basic Usage

Create a new file `.env` in the root of your Flutter app:

```
API_URL=https://myapi.com
FABRIC_ID=abcdefgh
```

load all environment varibles in `main.dart`

```dart
import 'package:flutter_config/flutter_config.dart';

void main() async {

  await FlutterConfig.loadEnvVariables();

  runApp(MyApp());
}
```

Now you can access your environment varibles anywhere in your app.

```dart
import 'package:flutter_config/flutter_config.dart';

FlutterConfig.get('FABRIC_ID') // returns 'abcdefgh'
```

Keep in mind this module doesn't obfuscate or encrypt secrets for packaging, so **do not store sensitive keys in `.env`**. It's [basically impossible to prevent users from reverse engineering mobile app secrets](https://rammic.github.io/2015/07/28/hiding-secrets-in-android-apps/), so design your app (and APIs) with that in mind.

## Getting Started

Install the latest version of the plugin

### Additional step for Android

You need to manually apply a plugin to your app, from `android/app/build.gradle`:

Right below `apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"`

add the following line:

`apply from: project(':flutter_config').projectDir.getPath() + "/dotenv.gradle"`

## Native Usage

### Android

Config variables set in `.env` are available to your Java or Kotlin classes via `BuildConfig`:

```kotlin
fun getApiClient(): HttpURLConnection {
    val url = URL(BuildConfig.API_URL);
    // ...
}
```

You can also read them from your Gradle configuration:

```groovy
defaultConfig {
    applicationId project.env.get("APP_ID")
}
```

And use them to configure libraries in `AndroidManifest.xml` and others:

```xml
<meta-data
  android:name="com.google.android.geo.API_KEY"
  android:value="@string/GOOGLE_MAPS_API_KEY" />
```

All variables are strings, so you may need to cast them. For instance, in Gradle:

```
versionCode project.env.get("VERSION_CODE").toInteger()
```

Once again, remember variables stored in `.env` are published with your code, so **DO NOT put anything sensitive there like your app `signingConfigs`.**

### iOS

Read variables declared in `.env` from your Obj-C classes like:

```objective-c
// import header
#import "FlutterConfigPlugin.h"

// then read individual keys like:
NSString *apiUrl = [FlutterConfigPlugin envFor:@"API_URL"];

// or just fetch the whole config
NSDictionary *config = [FlutterConfigPlugin env];
```

### Different environments

Save config for different environments in different files: `.env.staging`, `.env.production`, etc.

#### Android

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

<a name="ios-multi-scheme"></a>

#### iOS

The basic idea in iOS is to have one scheme per environment file, so you can easily alternate between them.

Start by creating a new scheme:

- In the Xcode menu, go to Product > Scheme > Edit Scheme
- Click Duplicate Scheme on the bottom
- Give it a proper name on the top left. For instance: "Myapp (staging)"

Then edit the newly created scheme to make it use a different env file. From the same "manage scheme" window:

- Expand the "Build" settings on left
- Click "Pre-actions", and under the plus sign select "New Run Script Action"
- Where it says "Type a script or drag a script file", type:
  ```
  echo ".env.staging" > /tmp/envfile   # replace .env.staging for your file
  ```

This is still a bit experimental and dirty – let us know if you have a better idea on how to make iOS use different configurations opening a pull request or issue!


