
import 'package:comiket_seller/CardWidgets/ItemCard.dart';
import 'package:flutter/material.dart';
import 'package:comiket_seller/main.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../AppStates/StateFuncs.dart';
import '../globals.dart' as globals;
import '../AppStates/Validators.dart';


int randomId() {
  return DateTime.now().millisecondsSinceEpoch;
}

class CreateCard extends StatefulWidget {
  CreateCard({
    super.key,
  });

  @override
  State<CreateCard> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<CreateCard>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

  }

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
                '新增',
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
                    Text("商品名稱",style: TextStyle(fontWeight: FontWeight.bold,color: textColor),),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: _nameContr,
                      cursorColor: _formInputCur,
                      style: _formInputSty,
                      decoration: _formInputDeco,
                      validator: (value) => Validators.validateProductName(value),
                    ),
                    SizedBox(height: 20,),
                    Text("商品價格",style: TextStyle(fontWeight: FontWeight.bold,color: textColor),),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: _priceContr,
                      cursorColor: _formInputCur,
                      style: _formInputSty,
                      decoration: _formInputDeco,
                      validator: (value) => Validators.validatePrice(value),
                    ),
                    SizedBox(height: 20,),
                    Text("商品數量",style: TextStyle(fontWeight: FontWeight.bold,color: textColor),),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: _quantContr,
                      cursorColor: _formInputCur,
                      style: _formInputSty,
                      decoration: _formInputDeco,
                      validator: (value) => Validators.validateQuantity(value),
                    ),
                    SizedBox(height: 20,),
                    Text("圖片URL",style: TextStyle(fontWeight: FontWeight.bold,color: textColor),),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: _urlContr,
                      cursorColor: _formInputCur,
                      style: _formInputSty,
                      decoration: _formInputDeco,
                      validator: (value) => Validators.validateURL(value),
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
                                Provider.of<MainAppState>(context, listen: false).setCard(MainAppState.getNowId(), _nameContr.text, int.parse(_priceContr.text), int.parse(_quantContr.text), _urlContr.text.isNotEmpty?_urlContr.text:"",);
                                Navigator.of(context).pop();
                                if(!MainAppState.getWrapInit()) {
                                  context.pushReplacement('/set');
                                  await MainAppState.wrapInit();
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
