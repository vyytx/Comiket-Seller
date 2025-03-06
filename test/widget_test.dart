// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:comiket_seller/AppStates/StateFuncs.dart';
import 'package:comiket_seller/globals.dart' as globals;
import 'package:comiket_seller/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path/path.dart';
import 'package:window_manager/window_manager.dart';
import 'package:url_strategy/url_strategy.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  testWidgets('Add Item Button Smoke test', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    setPathUrlStrategy();
    if (kIsWeb) {
      globals.isInApp = false;
    } else if (Platform.isWindows) {
      globals.isInApp = true;
    }
    await tester.pumpWidget(const MyApp());

    expect(find.text('單品列表'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    // // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add_rounded));
    await tester.pump();
    expect(find.text('儲存'), findsOneWidget);
  });
}
