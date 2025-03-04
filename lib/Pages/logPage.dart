import 'dart:convert';
import 'package:comiket_seller/PopUpWidgets/ClearLogWarnPUP.dart';
import 'package:comiket_seller/Widgets/Footer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../CardWidgets/LogCard.dart';
import '../PopUpWidgets/CheckOutPUP.dart';
import '../PopUpWidgets/FirstTimePUP.dart';
import '../Widgets/AppDrawer.dart';
import '../Widgets/TopAppBar.dart';
import 'package:dio/dio.dart';
import '../globals.dart' as globals;
import '../AppStates/StateFuncs.dart';

class logPage extends StatefulWidget {
  const logPage({super.key});

  @override
  State<logPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<logPage> with TickerProviderStateMixin {
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      body: NestedScrollView(
        physics: MainAppState.getSoldBoxLength()>0?null:NeverScrollableScrollPhysics(),
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
                child: MainAppState.getSoldBoxLength()>0?Column(
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
                            '賣出商品',
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
                              for(int i=0; i<MainAppState.getSoldBoxLength(); i++)
                                LogCard(id:i),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Color(0xFFd6d6d6),
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "目前入賬金額：",
                                style: TextStyle(
                                    color: Color(0xFFd6d6d6),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                Provider.of<MainAppState>(context).getEarned(),
                                style: TextStyle(
                                  color: Color(0xFFd6d6d6),
                                  fontSize: 28.5,
                                ),
                              ),
                              Spacer(),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    splashFactory: NoSplash.splashFactory,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    backgroundColor: Color(0xFFFF4060),
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.all(10),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          backgroundColor: Colors.transparent,
                                          content: ClearLogWarnCard(),
                                        );
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "ログ削除",
                                      style: TextStyle(color: Color(0xFFFFFFFF)),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    Footer(),
                  ],
                ):
                Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(image: AssetImage(globals.needAssetPath('hitlerCat.png'))),
                        Text(
                          '這裡啥都沒有',
                          style: TextStyle(
                              color: Color(0xFF858585),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
