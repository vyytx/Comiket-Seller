import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../AppStates/StateFuncs.dart';
import '../globals.dart' as globals;
import '../PopUpWidgets/EditPUP.dart';
import 'package:super_banners/super_banners.dart';

enum ItemCardType {single, set}

class ItemCard extends StatefulWidget {
  ItemCard({
    super.key,
    required this.name,
    required this.price,
    required this.quantity,
    required this.id,
    this.hasdel=true,
    this.image_uri,
    this.type=ItemCardType.single,
  });
  final bool hasdel;
  final String name;
  final int price;
  final int quantity;
  final String? image_uri;
  late final int id;
  final ItemCardType type;

  @override
  State<ItemCard> createState() => _ItemCardState();

}

class _ItemCardState extends State<ItemCard>
    with TickerProviderStateMixin{


  String get Name => widget.name;
  int get price => widget.price;
  int get quantity => widget.quantity;
  String? get image_uri => widget.image_uri;
  int get id => widget.id;
  int tmpcount=0;
  bool get hasdel => widget.hasdel;
  Color imageBGcolor = Color(0xFF1f1f1f);
  int tmpQuantity=0;
  ItemCardType get type => widget.type;

  @override
  void initState() {
    super.initState();
    tmpQuantity=quantity;
    tmpcount=0;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
        height: 435,
        width: 300,
        child: InkWell(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            hasdel?
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
                    content: EditCard(id: id,type: type,));
                }):
            (null);
          },
          child: Card(
            // margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            color: Color(0xFF1a1a1a),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 10,),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        width: 280,
                        height: 160,
                        child: Card(
                          margin: EdgeInsets.all(5),
                          elevation: 0,
                          color: imageBGcolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: image_uri!="null"?Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              image: DecorationImage(
                                image: NetworkImage(image_uri!),
                                fit: BoxFit.cover,
                              ),
                            )
                          ):null
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 25, bottom: 25),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.shopping_bag,
                              color: Color(0xFF00ba7c),
                              size: 26,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              Name,
                              style: TextStyle(
                                  color: Color(0xFFd6d6d6),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money_rounded,
                              color: Color(0xFFFD9E16),
                              size: 26,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              price.toString(),
                              style: TextStyle(
                                  color: Color(0xFFd6d6d6),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Text(
                              "剩餘數量",
                              style: TextStyle(
                                  color: Color(0xFFd6d6d6),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              hasdel?quantity.toString():tmpQuantity.toString(),
                              style: TextStyle(
                                  color: Color(0xFFd6d6d6),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xFF474747),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  hasdel?IconButton(
                    onPressed: (){
                      if(type==ItemCardType.single){
                        Provider.of<MainAppState>(context, listen: false).delCard(widget.name);
                      }
                      else if(type==ItemCardType.set){
                        Provider.of<MainAppState>(context, listen: false).returnInSetItemsByName(widget.name,widget.quantity);
                        Provider.of<MainAppState>(context, listen: false).delSetCard(widget.name);
                      }

                    },
                    icon: Icon(Icons.delete),color: Color(0xFFFF4060),)
                  :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: (){
                          if(tmpcount>0){
                            setState(() {
                              tmpcount-=1;
                              tmpQuantity++;
                              if(tmpcount==0){
                                type==ItemCardType.single?globals.tmpcart.remove("$Name"):globals.tmpcart.remove("{SET}$Name");
                              }
                              else {
                                type==ItemCardType.single?globals.tmpcart["$Name"]=tmpcount:globals.tmpcart["{SET}$Name"]=tmpcount;
                              }
                            });
                            Provider.of<MainAppState>(context, listen: false).subCost((price));
                          }
                        },
                        icon: Icon(Icons.remove_rounded,size: 30,),color: Color(0xFFFFFFFF),),
                      SizedBox(width: 10),
                      Text(
                        tmpcount.toString(),
                        style: TextStyle(
                            color: Color(0xFFd6d6d6),
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: (){
                          if((tmpcount<quantity)){
                            setState(() {
                              tmpcount+=1;
                              tmpQuantity--;
                              type==ItemCardType.single?globals.tmpcart["$Name"]=tmpcount:globals.tmpcart["{SET}$Name"]=tmpcount;
                            });
                            Provider.of<MainAppState>(context, listen: false).addCost(price);
                          }
                        },
                        icon: Icon(Icons.add_rounded,size: 30,),color: Color(0xFFFFFFFF),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
        (quantity==0&&!hasdel)
        ?Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              height: 435,
              width: 300,
              child: Card(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
                color: Color(0x7F1a1a1a),
              ),
            ),
            CornerBanner(
                bannerColor: Color(0xFF1f1f1f),
                bannerPosition: CornerBannerPosition.topRight,
                child: Text(
                "完売しました",
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 16,
                    fontWeight: FontWeight.bold)
                )
            )
          ],
        )
        :SizedBox.shrink()
        ,
      ]
    );
  }
}
