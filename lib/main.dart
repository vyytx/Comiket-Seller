import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'AppStates/StateFuncs.dart';
import 'Pages/404Page.dart';
import 'Pages/landingPage.dart';
import 'Pages/logPage.dart';
import 'Pages/makeSetPage.dart';
import 'Pages/setPage.dart';
import 'Pages/sellPage.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'globals.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  // await Hive.initFlutter('comiketSellerDB');
  // await Hive.openBox('cardBox');
  // await Hive.openBox('setBox');
  // await Hive.openBox('settingBox');
  // await Hive.openBox('soldBox');

  if (kIsWeb) {
    globals.isInApp = false;
  } else if (Platform.isWindows) {
    globals.isInApp = true;
  }

  if(globals.isInApp){
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = WindowOptions(
      size: Size(1280, 720),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const MyApp());
}

GoRouter get _router => GoRouter(
  errorBuilder: ((context, state) => notFoundPage()),
  initialLocation: '/set',
  // debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: SelectionArea(child: const landingPage()),    //child: const WelcomePage(),
      ),
    ),
    GoRoute(
      path: '/set',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: SelectionArea(child: const setPage()),    //child: const WelcomePage(),
      ),
    ),
    GoRoute(
      path: '/sell',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: SelectionArea(child: const sellPage()),
      ),
    ),
    GoRoute(
      path: '/log',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: SelectionArea(child: const logPage()),
      ),
    ),
    GoRoute(
      path: '/makeSet',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: SelectionArea(child: const makeSetPage()),
      ),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainAppState(),
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        title: 'COMIKET自販機',
        theme: ThemeData(
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: WidgetStateProperty.all(Color(0xFF474747)),
            trackColor: WidgetStateProperty.all(Color(0xFF1f1f1f)),
          ),
          scaffoldBackgroundColor: Color(0xFF1f1f1f),
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          textSelectionTheme: TextSelectionThemeData(cursorColor: Color(0xFFadadad),selectionColor: Color(0xFFADADAD),selectionHandleColor: Color(0xFF474747)),
          // color for light theme
          //colorScheme: ColorScheme.fromSwatch(backgroundColor: Color(0xFF1f1f1f),cardColor: Color(0xFF1a1a1a))//ColorScheme.dark(primary: Color(0xFF1f1f1f)),

          // color for ios
          cupertinoOverrideTheme: CupertinoThemeData(
            primaryColor: Color(0xFF1f1f1f),
            primaryContrastingColor: Color(0xFFd6d6d6),
            scaffoldBackgroundColor: Color(0xFF1f1f1f),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xFF0096fa),
            textTheme: ButtonTextTheme.primary,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              splashFactory: NoSplash.splashFactory,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              backgroundColor: Color(0xFF3a3a3a),
              surfaceTintColor: Color(0xFF3a3a3a),
              overlayColor: Colors.transparent,
              minimumSize: Size.zero,
              padding: EdgeInsets.all(10),
            ),
          ),
        ),
        // home: MainPage(),
      ),
    );
  }
}
