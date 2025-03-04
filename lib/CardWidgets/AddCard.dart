import 'package:comiket_seller/CardWidgets/ItemCard.dart';
import 'package:flutter/material.dart';
import 'package:comiket_seller/main.dart';
import '../PopUpWidgets/CreatePUP.dart';
import 'package:palette_generator/palette_generator.dart';

import '../PopUpWidgets/CreateSetPUP.dart';

class AddCard extends StatefulWidget {
  AddCard({
    super.key,
    this.type = ItemCardType.single,
  });
  ItemCardType type; // 0-> danpin, 1-> setto

  @override
  State<AddCard> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<AddCard>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  get type => widget.type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 435,
      width: 300,
      child: InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          showDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel:
              MaterialLocalizations
                  .of(context)
                  .modalBarrierDismissLabel,
              barrierColor: Colors.black54.withOpacity(0.8),
              builder: (context) {
                return AlertDialog(
                    scrollable: true,
                    backgroundColor: Colors.transparent,
                    content: _chooseVariation()
                );
              });
        },
        child: Card(
          // margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          color: Color(0xFF1a1a1a),
          elevation: 0,
          child: Center(
            child:Icon(
              Icons.add_rounded,
              color: Color(0xFFFFFFFF),
              size: 100,
            )
          )
        ),
      ),
    );
  }

  _chooseVariation(){
    if(type==ItemCardType.single){
      return CreateCard();
    }
    else if(type==ItemCardType.set){
      return CreateSetCard();
    }
  }
}
