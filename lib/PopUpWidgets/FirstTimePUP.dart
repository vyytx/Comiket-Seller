import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../AppStates/StateFuncs.dart';
import '../globals.dart' as globals;

class FirstTimeCard extends StatefulWidget {
  FirstTimeCard({
    super.key,
  });


  @override
  State<FirstTimeCard> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<FirstTimeCard>
    with TickerProviderStateMixin {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Color(0xFFd6d6d6);
    Color disTextColor = Color(0xFF858585);
    return Container(
      //height: 1500,
      width: 600,
      child: Card(
        // margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
        color: Color(0xFF1f1f1f),
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:25),
              child: Center(
                child: Text(
                  'こんにちは！',
                  style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 25, bottom: 25,right: 20),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      '初めてのご利用頂きまして\nありがとうございます！\n\n開始使用可以點擊左上角ICON進行設定',
                      style: TextStyle(
                          color: disTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 25,),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          splashFactory: NoSplash.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          backgroundColor: Color(0xFF00BA7C),
                          minimumSize: Size.zero,
                          padding: EdgeInsets.all(10),
                        ),
                        onPressed: () {
                          MainAppState.launchInit();
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text("了解",style: TextStyle(color: Color(0xFFd6d6d6)),),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  // CHECKOUT FUNCTION
  _doDelta(){
    MainAppState.addSellLog();
    Provider.of<MainAppState>(context, listen: false).deltaQuantity();
    Navigator.of(context).pop();
    context.pushReplacement('/sell');
  }
}
