import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../AppStates/StateFuncs.dart';
import '../globals.dart' as globals;
import '../PopUpWidgets/EditPUP.dart';
import 'package:super_banners/super_banners.dart';

class ItemBrick extends StatefulWidget {
  ItemBrick({
    super.key,
    required this.name,
    required this.quantity,
  });
  final String name;
  final int quantity;

  @override
  State<ItemBrick> createState() => _ItemBrickState();

}

class _ItemBrickState extends State<ItemBrick>
    with TickerProviderStateMixin{


  String get Name => widget.name;
  int get quantity => widget.quantity;
  int tmpcount=0;
  Color imageBGcolor = Color(0xFF1f1f1f);
  int tmpQuantity=0;

  @override
  void initState() {
    super.initState();
    tmpQuantity=quantity;
    tmpcount=0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    height: 50,
    width: 275,
    child: Card(
      // margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      color: Color(0xFF1a1a1a),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10, top: 5, bottom: 5),
        child: Row(
          children: [
            Text(
              Name,
              style: TextStyle(
                  color: Color(0xFFd6d6d6),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            VerticalDivider(
              color: Color(0xFF474747),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: (){
                    setState(() {
                      if(tmpcount>0){
                        tmpcount--;
                      }
                    });
                  },
                  icon: Icon(Icons.remove_rounded,size: 16,),color: Color(0xFFFFFFFF),),
                Text(
                  tmpcount.toString(),
                  style: TextStyle(
                      color: Color(0xFFd6d6d6),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: (){
                    setState(() {
                      if(tmpcount<quantity){
                        tmpcount++;
                      }
                    });
                  },
                  icon: Icon(Icons.add_rounded,size: 16,),color: Color(0xFFFFFFFF),),
              ],
            ),
          ],
        ),
      ),
    ),
          );
  }
}
