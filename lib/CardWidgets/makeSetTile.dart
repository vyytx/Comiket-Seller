import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../AppStates/StateFuncs.dart';
import '../globals.dart' as globals;

class MakeSetTile extends StatefulWidget {
  MakeSetTile({
    super.key,
    required this.id,
  });
  final int id;
  // final String time;

  @override
  State<MakeSetTile> createState() => _ItemCardState();

}

class _ItemCardState extends State<MakeSetTile>{


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
                  for(int i=0; i<MainAppState.getNowId(); i++)
                    SizedBox.shrink()
                ],
              ),
            ],
          ),
        ):SizedBox.shrink(),
      ],
    );
  }
}
