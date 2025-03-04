import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../AppStates/StateFuncs.dart';
import '../globals.dart' as globals;

class CheckOutCard extends StatefulWidget {
  CheckOutCard({
    super.key,
  });


  @override
  State<CheckOutCard> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<CheckOutCard>
    with TickerProviderStateMixin {

  int _tmpEarn=0;

  @override
  void initState() {
    super.initState();
    _tmpEarn=0;
    for(var i in globals.tmpcart.keys){
      if(i.startsWith('{SET}')){
        _tmpEarn+=Provider.of<MainAppState>(context,listen: false).getSetCardByName(i.substring(i.indexOf('{SET}')+5, i.length)).price*globals.tmpcart[i]!;
      }
      else{
        _tmpEarn+=Provider.of<MainAppState>(context,listen: false).getCardByName(i).price*globals.tmpcart[i]!;
      }

    }
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
                  'お会計',
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
                children: globals.tmpcart.isNotEmpty?[
                  for(var i in globals.tmpcart.keys)(i.startsWith('{SET}'))
                      ?Card(
                    color: Color(0xFF1a1a1a),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "[套組] 商品名稱：${Provider.of<MainAppState>(context,listen: false).getSetCardByName(i.substring(i.indexOf('{SET}')+5, i.length)).name}",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "數量：${globals.tmpcart[i]}",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "小記：${Provider.of<MainAppState>(context,listen: false).getSetCardByName(i.substring(i.indexOf('{SET}')+5, i.length)).price*globals.tmpcart[i]!}",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                      :Card(
                    color: Color(0xFF1a1a1a),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "商品名稱：${Provider.of<MainAppState>(context,listen: false).getCardByName(i).name}",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "數量：${globals.tmpcart[i]}",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "小記：${Provider.of<MainAppState>(context,listen: false).getCardByName(i).price*globals.tmpcart[i]!}",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            splashFactory: NoSplash.splashFactory,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            backgroundColor: Color(0xFF0096fa),
                            minimumSize: Size.zero,
                            padding: EdgeInsets.all(10),
                            disabledBackgroundColor: Color(0xFF3a3a3a),
                          ),
                          onPressed: globals.tmpcart.isNotEmpty?_doDelta:null,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              "確認",
                              style: TextStyle(color: globals.tmpcart.isNotEmpty?Color(0xFFFFFFFF):disTextColor),
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
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text("取消",style: TextStyle(color: Color(0xFFd6d6d6)),),
                          )),
                    ],
                  ),
                ]:[
                  Center(
                    child: Text(
                      '恭喜！啥都沒下單',
                      style: TextStyle(
                          color: disTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: ElevatedButton(
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
                          child: Text("取消",style: TextStyle(color: Color(0xFFd6d6d6)),),
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
    MainAppState.addTotalEarn(_tmpEarn);
    Provider.of<MainAppState>(context, listen: false).deltaQuantity();
    Navigator.of(context).pop();
    context.pushReplacement('/sell');
  }
}
