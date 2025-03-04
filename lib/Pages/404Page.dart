import 'dart:convert';
import 'package:comiket_seller/Widgets/Footer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../PopUpWidgets/CheckOutPUP.dart';
import '../PopUpWidgets/FirstTimePUP.dart';
import '../Widgets/AppDrawer.dart';
import '../Widgets/TopAppBar.dart';
import 'package:dio/dio.dart';
import '../globals.dart' as globals;
import '../AppStates/StateFuncs.dart';

class notFoundPage extends StatefulWidget {
  const notFoundPage({super.key});

  @override
  State<notFoundPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<notFoundPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
          crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
          children: [
            Text(
                '404 not found',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF858585),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )
            ),
            SizedBox(width: 10,),
            Image(
              image: AssetImage(globals.needAssetPath('404cat.png')),
              width: 100,
            ),
          ],
        ),
      ),
    );
  }
}
