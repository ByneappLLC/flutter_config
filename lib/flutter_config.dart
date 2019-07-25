import 'dart:async';

import 'package:flutter/services.dart';

class FlutterConfig {
  static const MethodChannel _channel =
      const MethodChannel('flutter_config');

  static Future<Map<String, dynamic>> get loadEnvVariables async {
    final Map<String, dynamic> variables = await _channel.invokeMapMethod('loadEnvVariables');
    return variables; 
  }
}
