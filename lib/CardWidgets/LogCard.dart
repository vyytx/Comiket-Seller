import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../AppStates/StateFuncs.dart';
import '../globals.dart' as globals;

class LogCard extends StatefulWidget {
  LogCard({
    super.key,
    required this.id,
  });
  final int id;
  // final String time;

  @override
  State<LogCard> createState() => _ItemCardState();

}

class _ItemCardState extends State<LogCard>{


  int get id => widget.id;
  bool showDetail=false;

  @override
  void initState() {
    super.initState();
  }

  Color textColor = Color(0xFFd6d6d6);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: (){
            setState(() {
              showDetail=!showDetail;
            });
          },
          child: Card(
            color: Color(0xFF1a1a1a),
            child: ListTile(
              title: Text(
                "Time: ${Provider.of<MainAppState>(context).getSoldLogAtTime(id)}    Earned: ${Provider.of<MainAppState>(context).getEarnedLogAt(id)}",
                style: TextStyle(
                    color: Color(0xFFd6d6d6),
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
              trailing: Icon(
                showDetail?Icons.arrow_drop_up_rounded:Icons.arrow_drop_down_rounded,
                color: Color(0xFFd6d6d6),
              )
            ),
          ),
        ),
        showDetail?Container(
          width: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Wrap(
                children: [
                  // Text(
                  //   Provider.of<MainAppState>(context).getSoldLogAt(id).toString(),
                  //   style: TextStyle(
                  //     color: Color(0xFF858585),
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold
                  //   ),
                  // ),
                  for(dynamic i in Provider.of<MainAppState>(context).getSoldLogAt(id).keys)
                    i.toString().startsWith('{preserved}')==false
                        ?Card(
                      color: Color(0xFF333333),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              i.toString().startsWith('{SET}')?"套組名稱：${i.substring(i.indexOf('{SET}')+5, i.length)}":"商品名稱：${i}",
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "數量：${Provider.of<MainAppState>(context).getSoldLogAt(id)[i]['quantity'].toString()}",
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "單價：${Provider.of<MainAppState>(context).getSoldLogAt(id)[i]['price'].toString()}",
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "小記：${Provider.of<MainAppState>(context).getSoldLogAt(id)[i]['earn'].toString()}",
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                        :SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ):SizedBox.shrink(),
      ],
    );
  }
}
