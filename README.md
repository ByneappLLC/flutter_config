# Config Variables for your Flutter apps

Plugin that exposes environment variables to your Dart code in Flutter as well as to your native code in iOS and Android.

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

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
