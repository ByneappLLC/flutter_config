import 'package:flutter/services.dart';

/// An instance of all environment variables
Map<String, dynamic> _variables;

/// Flutter config writes environment variables to `BuildConfig` class for android
/// and as a `NSDictionary` for iOS
class FlutterConfig {
  static const MethodChannel _channel =
      const MethodChannel('flutter_config'); 

  /// Variables need to be loaded on app startup, recommend to do it `main.dart`
  static loadEnvVariables() async {
    final Map<String, dynamic> variables = await _channel.invokeMapMethod('loadEnvVariables');
    _variables = variables;
  }

  /// Returns a specific varible value give a [key]
  static dynamic get(String key) {
    if (_variables != null) {
      return _variables[key];
    } else {
      print('You have not loaded the variables');
      return null;
    }
  }

  /// returns all the current loaded variables;
  static Map<String, dynamic> get variables => _variables;
}
