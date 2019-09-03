import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_config/flutter_config.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_config');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return {'FABRIC': 67};
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('get variable', () async {
    await FlutterConfig.loadEnvVariables();
    expect(FlutterConfig.get('FABRIC'), 67);
  });
}
