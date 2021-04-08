// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_config_example/main.dart';

import 'package:flutter_config/flutter_config.dart';

void main() {
  testWidgets('Verify Platform version', (WidgetTester tester) async {
    FlutterConfig.loadValueForTesting({'FABRIC_ID': 'TEST_FABRIC_12345'});
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that platform version is retrieved.
    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text &&
            widget.data!.startsWith('Values of fabric Id: TEST_FABRIC_12345'),
      ),
      findsOneWidget,
    );
  });
}
