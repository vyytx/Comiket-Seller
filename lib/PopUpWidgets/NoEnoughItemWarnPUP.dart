
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pair/pair.dart';
import 'package:provider/provider.dart';
import '../AppStates/StateFuncs.dart';
import '../globals.dart' as globals;

class NoItemWardCard extends StatefulWidget {
  NoItemWardCard({
    super.key,
    required this.need,
  });

  Map<String,Pair<int,int>> need;

  @override
  State<NoItemWardCard> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<NoItemWardCard>
    with TickerProviderStateMixin {

  Map<String,Pair<int,int>> get need => widget.need;

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
                  '錯誤',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      '以下商品數量不足',
                      style: TextStyle(
                          color: disTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Wrap(
                    children: [
                      for(String i in need.keys)Container(
                        height: 50,
                        width: 300,
                        child: Text(
                          "商品: ${i}  需要: ${need[i]?.key}  只有: ${need[i]?.value}",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                          ),
                        )
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //       elevation: 0,
                        //       splashFactory: NoSplash.splashFactory,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(15.0),
                        //       ),
                        //       backgroundColor: Color(0xFFFF4060),
                        //       minimumSize: Size.zero,
                        //       padding: EdgeInsets.all(10),
                        //     ),
                        //     onPressed: () async {
                        //       Navigator.of(context).pop();
                        //     },
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5),
                        //       child: Text("OK",style: TextStyle(color: Color(0xFFd6d6d6)),),
                        //     )),
                        // SizedBox(width: 10,),
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
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text("OK",style: TextStyle(color: Color(0xFFd6d6d6)),),
                            )),
                      ],
                    ),
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
