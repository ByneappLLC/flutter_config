import 'package:flutter/services.dart';


Map<String, dynamic> _variables;
class FlutterConfig {
  static const MethodChannel _channel =
      const MethodChannel('flutter_config'); 

  static loadEnvVariables() async {
    final Map<String, dynamic> variables = await _channel.invokeMapMethod('loadEnvVariables');
    _variables = variables;
  }

  static dynamic get(String key) {
    if (_variables != null) {
      return _variables[key];
    } else {
      print('You have not loaded the variables');
      return null;
    }
  }

  static Map<String, dynamic> get variables => _variables;
}
