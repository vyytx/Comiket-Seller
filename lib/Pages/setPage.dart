import 'dart:convert';
import 'dart:math';
import 'package:comiket_seller/CardWidgets/AddCard.dart';
import 'package:comiket_seller/Widgets/Footer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../AppStates/StateFuncs.dart';
import '../Widgets/AppDrawer.dart';
import '../Widgets/TopAppBar.dart';
import 'package:dio/dio.dart';
import '../globals.dart' as globals;

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class setPage extends StatefulWidget {
  const setPage({super.key});

  @override
  State<setPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<setPage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final dio = Dio(BaseOptions(
      connectTimeout: Duration(milliseconds: 2000),
      // in ms
      receiveTimeout: Duration(minutes: 5),
      sendTimeout: Duration(milliseconds: 2000),
      responseType: ResponseType.plain,
      followRedirects: false,
      validateStatus: (status) {
        return true;
      }));


  // final InputDecoration _inputboxdec = InputDecoration.collapsed(hintText: 'Hint Text', border: InputBorder.none);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      body: NestedScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            AppBar_G(),
          ];
        },
        body: LayoutBuilder(
          builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            '單品列表',
                            style:
                            TextStyle(color: Color(0xFFd6d6d6), fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            children: [
                              for(int i=0; i<MainAppState.getNowId(); i++) Provider.of<MainAppState>(context).getCard(i),
                              AddCard(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    Footer(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
