
import 'package:comiket_seller/CardWidgets/ItemBrick.dart';
import 'package:comiket_seller/CardWidgets/ItemCard.dart';
import 'package:flutter/material.dart';
import 'package:comiket_seller/main.dart';
import 'package:go_router/go_router.dart';
import 'package:pair/pair.dart';
import 'package:provider/provider.dart';
import '../AppStates/StateFuncs.dart';
import '../globals.dart' as globals;
import 'package:flutter_typeahead/flutter_typeahead.dart';

int randomId() {
  return DateTime.now().millisecondsSinceEpoch;
}

class CreateSetCard extends StatefulWidget {
  CreateSetCard({
    super.key,
  });

  @override
  State<CreateSetCard> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<CreateSetCard>
    with TickerProviderStateMixin {

  List<String> singleItemList=MainAppState().getAllItemList();
  Map<String,int> ItemBricks = {};

  @override
  Widget build(BuildContext context) {

    Color textColor = Color(0xFFd6d6d6);
    final _formKey = GlobalKey<FormState>();
    InputDecoration _formInputDeco = InputDecoration(
      filled: true,
      fillColor: Color(0xFF3a3a3a),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0,color: Colors.transparent)
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.5,color: Color(0xFF0096fa))
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0,color: Color(0xFFff4060))
      ),
      //labelText: '課程名稱',
      labelStyle: TextStyle(color: Color(0xFF474747),fontSize: 12),
      errorStyle: TextStyle(color: Color(0xFFff4060),fontSize: 14,fontWeight: FontWeight.bold),
    );
    Color _formInputCur = Color(0xFFd6d6d6);
    TextStyle _formInputSty = TextStyle(color: Color(0xFFd6d6d6));
    final _nameContr = TextEditingController();
    final _priceContr = TextEditingController();
    final _quantContr = TextEditingController();
    final _urlContr = TextEditingController();
    final _searchContr = TextEditingController();

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
          children: [
            Padding(
              padding: const EdgeInsets.only(top:8),
              child: Text(
                '新增套組',
                style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 25, bottom: 25,right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("套組名稱",style: TextStyle(fontWeight: FontWeight.bold,color: textColor),),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: _nameContr,
                      cursorColor: _formInputCur,
                      style: _formInputSty,
                      decoration: _formInputDeco,
                      validator: (value) {
                        if (value == null || value.isEmpty || value.contains(RegExp(r'[{}]'))) {
                          return "請輸入正確的套組名稱";
                        }
                        else if (MainAppState.hadSetName(value)) {
                          return "套組名稱重複";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    Text("套組價格",style: TextStyle(fontWeight: FontWeight.bold,color: textColor),),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: _priceContr,
                      cursorColor: _formInputCur,
                      style: _formInputSty,
                      decoration: _formInputDeco,
                      validator: (value) {
                        if (value == null || value.isEmpty || int.tryParse(value) == null || int.tryParse(value)!<0) {
                          return "請輸入正確的價格";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    Text("套組數量",style: TextStyle(fontWeight: FontWeight.bold,color: textColor),),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: _quantContr,
                      cursorColor: _formInputCur,
                      style: _formInputSty,
                      decoration: _formInputDeco,
                      validator: (value) {
                        if (value == null || value.isEmpty || int.tryParse(value) == null || int.tryParse(value)!<0) {
                          return "請輸入正確的數量";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    Text("圖片URL",style: TextStyle(fontWeight: FontWeight.bold,color: textColor),),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: _urlContr,
                      cursorColor: _formInputCur,
                      style: _formInputSty,
                      decoration: _formInputDeco,
                      validator: (value) {
                        if ((value!.isNotEmpty && Uri.parse(value).isAbsolute == false)) {
                          return "請輸入正確圖片URL";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    Text("套組內容物",style: TextStyle(fontWeight: FontWeight.bold,color: textColor),),
                    SizedBox(height: 10,),
                    TypeAheadField(
                      controller: _searchContr,
                      suggestionsCallback: (pattern) {
                        return singleItemList
                            .where((item) => item.toLowerCase().contains(pattern.toLowerCase()))
                            .toList();
                      },
                      builder: (context, controller, focusNode) {
                        return TextField(
                            controller: controller,
                            decoration: _formInputDeco,
                            cursorColor: _formInputCur,
                            style: _formInputSty,
                            focusNode: focusNode,
                            // autofocus: true,
                        );
                      },
                      listBuilder: (context, children){
                        return  ListView(
                          shrinkWrap: true,
                          children: children,
                        );
                      },
                      itemBuilder: (context, suggestion) {
                        return Card(
                          color: Color(0xFF1f1f1f),
                          child: ListTile(
                            title: Text(
                              suggestion,
                              style: TextStyle(
                                  color: Color(0xFFd6d6d6),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        );
                      },
                      decorationBuilder: (context, child) {
                        return Material(
                          color: Color(0xFF1a1a1a),
                          type: MaterialType.card,
                          elevation: 4,
                          borderRadius: BorderRadius.circular(8),
                          child: child,
                        );
                      },
                      onSelected: (suggestion) {
                        setState(() {
                          ItemBricks[suggestion]=MainAppState().getCardByName(suggestion).quantity;
                        });
                        // _searchContr.clear();
                      },
                    ),
                    SizedBox(height: 10,),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        for(String i in ItemBricks.keys) ItemBrick(name: i, quantity: ItemBricks[i]!)
                      ],
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
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // globals.AllC.insert(globals.AllC.length,ItemCard(id: globals.AllC.length,name: _nameContr.text, price: int.parse(_priceContr.text), quantity: int.parse(_quantContr.text), image_uri: _urlContr.text.isNotEmpty?_urlContr.text:null,));
                                Provider.of<MainAppState>(context, listen: false).setSetCard(MainAppState.getNowSetId(), _nameContr.text, int.parse(_priceContr.text), int.parse(_quantContr.text), _urlContr.text.isNotEmpty?_urlContr.text:"", {});
                                Navigator.of(context).pop();
                                if(!MainAppState.getSetWrapInit()) {
                                  context.pushReplacement('/makeSet');
                                  await MainAppState.setWrapInit();
                                }
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                  "儲存",
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
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text("取消",style: TextStyle(color: Color(0xFFd6d6d6)),),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
