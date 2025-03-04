// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:comiket_seller/globals.dart' as globals;
import 'package:comiket_seller/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:window_manager/window_manager.dart';
import 'package:url_strategy/url_strategy.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // WidgetsFlutterBinding.ensureInitialized();
    // setPathUrlStrategy();
    await Hive.initFlutter('comiketSellerDB');
    await Hive.openBox('cardBox');
    await Hive.openBox('setBox');
    await Hive.openBox('settingBox');
    await Hive.openBox('soldBox');

    if (kIsWeb) {
      globals.isInApp = false;
    } else if (Platform.isWindows) {
      globals.isInApp = true;
    }
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'),findsOneWidget);
  });
}
