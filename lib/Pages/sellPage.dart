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

class sellPage extends StatefulWidget {
  const sellPage({super.key});

  @override
  State<sellPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<sellPage> with TickerProviderStateMixin {
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
    Future.delayed(Duration.zero, () async {
      Provider.of<MainAppState>(context, listen: false).clearCost();
    });
    globals.tmpcart.clear();
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
        physics: (MainAppState.getNowId()>0||MainAppState.getNowSetId()>0)?null:NeverScrollableScrollPhysics(),
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
                child: (MainAppState.getNowId()>0||MainAppState.getNowSetId()>0)?Column(
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
                          (MainAppState.getNowId()>0)
                            ?Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            children: [
                              for(int i=0; i<MainAppState.getNowId(); i++) Provider.of<MainAppState>(context).getSellCard(i),
                            ],
                          )
                            :Center(
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
                          const SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Color(0xFF3a3a3a),
                            thickness: 2,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            '套組列表',
                            style:
                            TextStyle(color: Color(0xFFd6d6d6), fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          (MainAppState.getNowSetId()>0)
                            ?Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            children: [
                              for(int i=0; i<MainAppState.getNowSetId(); i++) Provider.of<MainAppState>(context).getSetSellCard(i),
                            ],
                          )
                            :Center(
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
                                "總金額：",
                                style: TextStyle(
                                    color: Color(0xFFd6d6d6),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                Provider.of<MainAppState>(context).tmpTotalCost.toString(),
                                style: TextStyle(
                                  color: Color(0xFFd6d6d6),
                                  fontSize: 28.5,
                                ),
                              ),
                              Spacer(),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    // splashFactory: NoSplash.splashFactory,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    backgroundColor: Color(0xFF1D9BF0),
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.all(10),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierLabel:
                                        MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                        barrierColor: Colors.black54.withOpacity(0.8),
                                        builder: (context) {
                                          return AlertDialog(
                                              scrollable: true,
                                              backgroundColor: Colors.transparent,
                                              content: CheckOutCard());
                                        });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "下單",
                                      style: TextStyle(color: Color(0xFFFFFFFF)),
                                    ),
                                  )),
                              SizedBox(width: 10,),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    splashFactory: NoSplash.splashFactory,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    backgroundColor: Color(0xFF3a3a3a),
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.all(10),
                                  ),
                                  onPressed: () {
                                    context.pushReplacement('/sell');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "清除",
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
