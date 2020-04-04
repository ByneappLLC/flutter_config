import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FlutterConfig.loadValueForTesting({'BASE_URL': 'https://www.google.com'});

  test('test vairable should be available on test', () {
    final baseUrl = FlutterConfig.get('BASE_URL');

    expect(baseUrl, matches('https://www.google.com'));
  });
}
