import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// Flutter config writes environment variables to `BuildConfig` class for android
/// and as a `NSDictionary` for iOS
class FlutterConfig {
  /// An instance of all environment variables
  late Map<String, dynamic> _variables;

  // Private Constructor
  FlutterConfig._internal();

  // Instance of FlutterConfig
  static final FlutterConfig _instance = FlutterConfig._internal();

  static const MethodChannel _channel = const MethodChannel('flutter_config');

  /// Variables need to be loaded on app startup, recommend to do it `main.dart`
  static loadEnvVariables() async {
    final Map<String, dynamic>? loadedVariables =
        await _channel.invokeMapMethod('loadEnvVariables');
    _instance._variables = loadedVariables ?? {};
  }

  /// Returns a specific variable value give a [key]
  static dynamic get(String key) {
    var variables = _instance._variables;

    if (variables.isEmpty) {
      print(
        'FlutterConfig Variables are Empty\n'
        'Ensure you have a .env file and you\n'
        'have loaded the variables',
      );
    } else if (variables.containsKey(key)) {
      return variables[key];
    } else {
      print(
        'FlutterConfig Value for Key($key) not found\n'
        'Ensure you have it in .env file',
      );
    }
  }

  /// returns all the current loaded variables;
  static Map<String, dynamic> get variables =>
      Map<String, dynamic>.of(_instance._variables);

  @visibleForTesting
  static loadValueForTesting(Map<String, dynamic> values) {
    _instance._variables = values;
  }
}
