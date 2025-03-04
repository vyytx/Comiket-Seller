import 'package:flutter/material.dart';
import '../PopUpWidgets/FirstTimePUP.dart';
import '../Widgets/AppDrawer.dart';
import '../Widgets/TopAppBar.dart';
import 'package:dio/dio.dart';
import '../globals.dart' as globals;
import '../AppStates/StateFuncs.dart';

class landingPage extends StatefulWidget {
  const landingPage({super.key});

  @override
  State<landingPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<landingPage> with TickerProviderStateMixin {
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
    if(MainAppState.getLaunchInit()==false){
      Future.delayed(Duration.zero, () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              scrollable: true,
              backgroundColor: Colors.transparent,
              content: FirstTimeCard(),
            );
          },
        );
      });

    }
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
        physics: NeverScrollableScrollPhysics(),
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
                child: Center(
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
                        Image(
                          image: NetworkImage('https://i.imgur.com/Sxd68s5.gif'),
                          height: 50,
                        ),
                        SizedBox(width: 10,),
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
