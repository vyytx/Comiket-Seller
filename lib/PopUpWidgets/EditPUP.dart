
import 'package:comiket_seller/CardWidgets/ItemCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../AppStates/StateFuncs.dart';
import '../AppStates/Validators.dart';


class EditCard extends StatefulWidget {
  EditCard({
    super.key,
    required this.id,
    this.type=ItemCardType.single,
  });

  int id;
  ItemCardType type;

  @override
  State<EditCard> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<EditCard>
    with TickerProviderStateMixin {

  final _nameContr = TextEditingController();
  final _priceContr = TextEditingController();
  final _quantContr = TextEditingController();
  final _urlContr = TextEditingController();

  get id => widget.id;
  get type => widget.type;

  String lastName = "";


  @override
  void initState() {
    super.initState();
    if(!_qIsDisabled()){
      _nameContr.text=Provider.of<MainAppState>(context,listen: false).getCard(id).name;
      _priceContr.text=Provider.of<MainAppState>(context,listen: false).getCard(id).price.toString();
      _quantContr.text=Provider.of<MainAppState>(context,listen: false).getCard(id).quantity.toString();
      _urlContr.text=Provider.of<MainAppState>(context,listen: false).getCard(id).image_uri=='null'?"":Provider.of<MainAppState>(context,listen: false).getCard(id).image_uri!;
    }
    else if(_qIsDisabled()){
      _nameContr.text=Provider.of<MainAppState>(context,listen: false).getSetCard(id).name;
      _priceContr.text=Provider.of<MainAppState>(context,listen: false).getSetCard(id).price.toString();
      _quantContr.text=Provider.of<MainAppState>(context,listen: false).getSetCard(id).quantity.toString();
      _urlContr.text=Provider.of<MainAppState>(context,listen: false).getSetCard(id).image_uri=='null'?"":Provider.of<MainAppState>(context,listen: false).getCard(id).image_uri!;
    }
    lastName=_nameContr.text;
  }

  @override
  Widget build(BuildContext context) {

    Color textColor = Color(0xFFd6d6d6);
    Color disabledTextColor = Color(0xFF808080);
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
    InputDecoration _disabledFormInputDeco = InputDecoration(
      filled: true,
      fillColor: Color(0xFF3a3a3a),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0,color: Colors.transparent)
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.5,color: Color(0xFF808080))
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
                '編輯',
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
                      validator: (value) => Validators.validateProductNameAndSetName(value, lastName, _qIsDisabled()),
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
                    Text("商品數量",style: TextStyle(fontWeight: FontWeight.bold,color: _qIsDisabled()?disabledTextColor:textColor),),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: _quantContr,
                      cursorColor: _formInputCur,
                      style: TextStyle(
                          color: _qIsDisabled()?Color(0xFF808080):Color(0xFFd6d6d6)
                      ),
                      decoration: _qIsDisabled()?_disabledFormInputDeco:_formInputDeco,
                      validator: (value) => Validators.validateQuantity(value),
                      readOnly: _qIsDisabled(),
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()&&!_qIsDisabled()) {
                                Provider.of<MainAppState>(context, listen: false).editCard(lastName, id, _nameContr.text, int.parse(_priceContr.text), int.parse(_quantContr.text), _urlContr.text.isNotEmpty?_urlContr.text:"");
                                Navigator.of(context).pop();
                              }
                              else if(_formKey.currentState!.validate()&&_qIsDisabled()){
                                Provider.of<MainAppState>(context, listen: false).editSetCard(lastName, id, _nameContr.text, int.parse(_priceContr.text), int.parse(_quantContr.text), _urlContr.text.isNotEmpty?_urlContr.text:"",{});
                                Navigator.of(context).pop();
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

  bool _qIsDisabled(){
    return type==ItemCardType.set;
  }
}
