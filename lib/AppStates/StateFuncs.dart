import 'package:comiket_seller/CardWidgets/ItemBrick.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pair/pair.dart';
import '../CardWidgets/ItemCard.dart';
import '../Structures/ItemLog.dart';
import '../globals.dart' as globals;
import 'package:intl/intl.dart';


class MainAppState extends ChangeNotifier{

  int tmpTotalCost = 0;
  static int ttc2 = 0;

  void addCost(int cost){
    tmpTotalCost += cost;
    ttc2 = tmpTotalCost;
    notifyListeners();
  }
  void subCost(int cost){
    tmpTotalCost -= cost;
    ttc2 = tmpTotalCost;
    notifyListeners();
  }
  void clearCost(){
    tmpTotalCost = 0;
    ttc2 = 0;
    notifyListeners();
  }

  int getCost(){
    return tmpTotalCost;
  }

  // ItemBricks

  void addBrick(String name,int quant){
    globals.ItemBricks[name]=quant;
    notifyListeners();
  }

  ItemBrick getItemBrickByName(String name){
    return ItemBrick(name: name, quantity: MainAppState().getCardByName(name).quantity);
  }

  void deltaItemBrickValueByName(String name,int dv){
    if(globals.ItemBricks.containsKey(name)){
      globals.ItemBricks[name]=globals.ItemBricks[name]!+dv;
    }
  }

  void removeItemBrickByName(String name){
    globals.ItemBricks.remove(name);
    notifyListeners();
  }

//-------------TANPPIN CARDS----------------

  // Hive states
  // static final sellItemBox = Hive.box('cardBox');
  static final Map<String,dynamic> sellItemBox = {};
  Future<void> setCard(int id, String name, int price, int quantity, String? image_uri) async {
    // await sellItemBox.put(name, {
    //   'id': id,
    //   'price': price,
    //   'quantity': quantity,
    //   'image_uri': image_uri!.isNotEmpty?image_uri:"null",
    // });
    sellItemBox[name] = {
      'id': id,
      'price': price,
      'quantity': quantity,
      'image_uri': image_uri!.isNotEmpty?image_uri:"null",
    };
    notifyListeners();
  }

  static void testingSetCard(int id, String name, int price, int quantity, String? image_uri){
    sellItemBox[name] = {
      'id': id,
      'price': price,
      'quantity': quantity,
      'image_uri': image_uri!.isNotEmpty?image_uri:"null",
    };
  }

  Future<void> editCard(String origName, int id, String name, int price, int quantity, String? image_uri) async {
    // await sellItemBox.put(name, {
    //   'id': id,
    //   'price': price,
    //   'quantity': quantity,
    //   'image_uri': image_uri!.isNotEmpty?image_uri:"null",
    // });
    sellItemBox[name] = {
      'id': id,
      'price': price,
      'quantity': quantity,
      'image_uri': image_uri!.isNotEmpty?image_uri:"null",
    };
    if(origName!=name) {
      // await sellItemBox.delete(origName);
      sellItemBox.remove(origName);
    }
    notifyListeners();
  }

  static bool hadName(String name){
    for(String i in sellItemBox.keys){
      if(i==name){
        return true;
      }
    }
    return false;
  }

  static int getNowId() {
    return sellItemBox.length;
  }

  static Future<void> delAllCards() async {
    sellItemBox.clear();
  }

  Future<void> delCard(String name) async{
    // await sellItemBox.delete(name);
    sellItemBox.remove(name);
    notifyListeners();
  }

  ItemCard getCard(int id){
    // return ItemCard(name: sellItemBox.keyAt(id), price: sellItemBox.getAt(id)['price'], quantity: sellItemBox.getAt(id)['quantity'], id: id, image_uri: sellItemBox.getAt(id)['image_uri'].toString().isNotEmpty?sellItemBox.getAt(id)['image_uri'].toString():null);
    return ItemCard(name: sellItemBox.keys.elementAt(id), price: sellItemBox[sellItemBox.keys.elementAt(id)]['price'], quantity: sellItemBox[sellItemBox.keys.elementAt(id)]['quantity'], id: id, image_uri: sellItemBox[sellItemBox.keys.elementAt(id)]['image_uri'].toString().isNotEmpty?sellItemBox[sellItemBox.keys.elementAt(id)]['image_uri'].toString():null);
  }

  ItemCard getCardByName(String name){
    return ItemCard(name: name, price: sellItemBox[name]['price'], quantity: sellItemBox[name]['quantity'], id: sellItemBox[name]['id'], image_uri: sellItemBox[name]['image_uri'].toString().isNotEmpty?sellItemBox[name]['image_uri'].toString():null);
  }

  ItemCard getSellCard(int id){
    return ItemCard(name: sellItemBox.keys.elementAt(id), price: sellItemBox[sellItemBox.keys.elementAt(id)]['price'], quantity: sellItemBox[sellItemBox.keys.elementAt(id)]['quantity'], id: id, image_uri: sellItemBox[sellItemBox.keys.elementAt(id)]['image_uri'].toString().isNotEmpty?sellItemBox[sellItemBox.keys.elementAt(id)]['image_uri'].toString():null, hasdel: false);
  }

  ItemBrick getSellBrick(int id){
    return ItemBrick(name: sellItemBox.keys.elementAt(id), quantity: sellItemBox[sellItemBox.keys.elementAt(id)]['quantity']);
  }

  List<String> getAllItemList(){
    List<String> _tmpList=[];
    for(String i in sellItemBox.keys) {
      _tmpList.add(i);
    }
    return _tmpList;
  }

  Future<void> deltaQuantity() async {
    for(final i in globals.tmpcart.keys){
      if(i.startsWith('{SET}')){
        // await sellSetBox.put(i.substring(i.indexOf('{SET}')+5, i.length), {
        //   'id': sellSetBox.length,
        //   'name': i.substring(i.indexOf('{SET}')+5, i.length),
        //   'price': sellSetBox.get(i.substring(i.indexOf('{SET}')+5, i.length))['price'],
        //   'quantity': sellSetBox.get(i.substring(i.indexOf('{SET}')+5, i.length))['quantity']-globals.tmpcart[i],
        //   'image_uri': sellSetBox.get(i.substring(i.indexOf('{SET}')+5, i.length))['image_uri'],
        // });
        sellSetBox[i.substring(i.indexOf('{SET}')+5, i.length)] = {
          'id': sellSetBox.length,
          'price': sellSetBox[i.substring(i.indexOf('{SET}')+5, i.length)]['price'],
          'quantity': sellSetBox[i.substring(i.indexOf('{SET}')+5, i.length)]['quantity']-globals.tmpcart[i],
          'image_uri': sellSetBox[i.substring(i.indexOf('{SET}')+5, i.length)]['image_uri'],
        };
      }
      else{
        // await sellItemBox.put(i, {
        //   'id': sellItemBox.get(i)['id'],
        //   'name': i,
        //   'price': sellItemBox.get(i)['price'],
        //   'quantity': sellItemBox.get(i)['quantity'] - globals.tmpcart[i],
        //   'image_uri': sellItemBox.get(i)['image_uri'],
        // });
        sellItemBox[i] = {
          'id': sellItemBox[i]['id'],
          'price': sellItemBox[i]['price'],
          'quantity': sellItemBox[i]['quantity'] - globals.tmpcart[i],
          'image_uri': sellItemBox[i]['image_uri'],
        };
      }
    }
    globals.tmpcart.clear();
    notifyListeners();
  }

//-------------SET CARDS----------------

  // static final sellSetBox = Hive.box('setBox');
  static final Map<String,dynamic> sellSetBox = {};

  Future<void> setSetCard(int id, String name, int price, int quantity, String? image_uri, Map items) async {
    // await sellSetBox.put(name, {
    //   'id': id,
    //   'price': price,
    //   'quantity': quantity,
    //   'image_uri': image_uri!.isNotEmpty?image_uri:"null",
    //   'items': items,
    // });
    sellSetBox[name] = {
      'id': id,
      'price': price,
      'quantity': quantity,
      'image_uri': image_uri!.isNotEmpty?image_uri:"null",
      'items': items,
    };
    notifyListeners();
  }


  Future<void> editSetCard(String origName, int id, String name, int price, int quantity, String? image_uri, Map items) async {
    // await sellSetBox.put(name, {
    //   'id': id,
    //   'price': price,
    //   'quantity': quantity,
    //   'image_uri': image_uri!.isNotEmpty?image_uri:"null",
    //   'items': items,
    // });
    sellSetBox[name] = {
      'id': id,
      'price': price,
      'quantity': quantity,
      'image_uri': image_uri!.isNotEmpty?image_uri:"null",
      'items': items,
    };
    if(origName!=name) {
      // await sellSetBox.delete(origName);
      sellSetBox.remove(origName);
    }
    notifyListeners();
  }

  static bool hadSetName(String name){
    for(String i in sellSetBox.keys){
      if(i==name){
        return true;
      }
    }
    return false;
  }

  static int getNowSetId() {
    return sellSetBox.length;
  }

  static Future<void> delAllSetCards() async {
    sellSetBox.clear();
  }

  Future<void> delSetCard(String name) async{
    // await sellSetBox.delete(name);
    sellSetBox.remove(name);
    notifyListeners();
  }

  ItemCard getSetCard(int id){
    return ItemCard(type:ItemCardType.set, name: sellSetBox.keys.elementAt(id), price: sellSetBox[sellSetBox.keys.elementAt(id)]['price'], quantity: sellSetBox[sellSetBox.keys.elementAt(id)]['quantity'], id: id, image_uri: sellSetBox[sellSetBox.keys.elementAt(id)]['image_uri'].toString().isNotEmpty?sellSetBox[sellSetBox.keys.elementAt(id)]['image_uri'].toString():null);
  }

  ItemCard getSetCardByName(String name){
    return ItemCard(type:ItemCardType.set, name: name, price: sellSetBox[name]['price'], quantity: sellSetBox[name]['quantity'], id: sellSetBox[name]['id'], image_uri: sellSetBox[name]['image_uri'].toString().isNotEmpty?sellSetBox[name]['image_uri'].toString():null);
  }

  ItemCard getSetSellCard(int id){
    // return ItemCard(type:ItemCardType.set, name: sellSetBox.keyAt(id), price: sellSetBox.getAt(id)['price'], quantity: sellSetBox.getAt(id)['quantity'], id: id, image_uri: sellSetBox.getAt(id)['image_uri'].toString().isNotEmpty?sellSetBox.getAt(id)['image_uri'].toString():null, hasdel: false);
    return ItemCard(type:ItemCardType.set, name: sellSetBox.keys.elementAt(id), price: sellSetBox[sellSetBox.keys.elementAt(id)]['price'], quantity: sellSetBox[sellSetBox.keys.elementAt(id)]['quantity'], id: id, image_uri: sellSetBox[sellSetBox.keys.elementAt(id)]['image_uri'].toString().isNotEmpty?sellSetBox[sellSetBox.keys.elementAt(id)]['image_uri'].toString():null, hasdel: false);
  }

  Future<void> returnInSetItemsByName(String name,int setQ) async{
    // for(String i in sellSetBox.get(name)['items'].keys){
    //   int tmpq=sellSetBox.get(name)['items'][i];
    //   editCard(
    //       i,
    //       getCardByName(i).id,
    //       i,
    //       getCardByName(i).price,
    //       getCardByName(i).quantity+(tmpq*setQ),
    //       getCardByName(i).image_uri
    //   );
    // }
    for(String i in sellSetBox[name]['items'].keys){
      int tmpq=sellSetBox[name]['items'][i];
      editCard(
          i,
          getCardByName(i).id,
          i,
          getCardByName(i).price,
          getCardByName(i).quantity+(tmpq*setQ),
          getCardByName(i).image_uri
      );
    }
  }




//-------------SETTINGS----------------

  // static final settingBox = Hive.box('settingBox');
  static final settingBox = {};

  static Future<void> wrapInit() async {
    // await settingBox.put('wrapInit', true);
    settingBox['wrapInit'] = true;
  }

  static bool getWrapInit() {
    // return settingBox.get('wrapInit', defaultValue: false);
    return settingBox['wrapInit']??false;
  }

  static Future<void> setWrapInit() async {
    // await settingBox.put('setWrapInit', true);
    settingBox['setWrapInit'] = true;
  }

  static bool getSetWrapInit() {
    // return settingBox.get('setWrapInit', defaultValue: false);
    return settingBox['setWrapInit']??false;
  }

  static Future<void> launchInit() async {
    // await settingBox.put('launchInit', true);
    settingBox['launchInit'] = true;
  }

  static bool getLaunchInit() {
    // return settingBox.get('launchInit', defaultValue: false);
    return settingBox['launchInit']??false;
  }

  // static final soldBox = Hive.box('soldBox');
  static final soldBox = {};

  static Future<void> addSellLog() async{
    DateTime now = DateTime.now();
    Map<String,Map<String,int>> _tmpItemLogs = {};
    for(final i in globals.tmpcart.keys){
      if(i.startsWith('{SET}')){
        // _tmpItemLogs[i] = {
        //   "price": sellSetBox.get(i.substring(i.indexOf('{SET}')+5, i.length))['price'],
        //   "quantity": globals.tmpcart[i]!,
        //   "earn": sellSetBox.get(i.substring(i.indexOf('{SET}')+5, i.length))['price'] * globals.tmpcart[i],
        // };
        _tmpItemLogs[i] = {
          "price": sellSetBox[i.substring(i.indexOf('{SET}')+5, i.length)]['price'],
          "quantity": globals.tmpcart[i]!,
          "earn": sellSetBox[i.substring(i.indexOf('{SET}')+5, i.length)]['price'] * globals.tmpcart[i],
        };
      }
      else{
        _tmpItemLogs[i] = {
          "price": sellItemBox[i]['price'],
          "quantity": globals.tmpcart[i]!,
          "earn": sellItemBox[i]['price'] * globals.tmpcart[i],
        };
      }
    }
    _tmpItemLogs['{preserved}${DateFormat('y/M/d-kk:mm:ss').format(now)}-thisEarn'] = {
      "price": -1,
      "quantity": -1,
      "earn": ttc2,
    };
    // await soldBox.put(DateFormat('y/M/d-kk:mm:ss').format(now), _tmpItemLogs);
    soldBox[DateFormat('y/M/d-kk:mm:ss').format(now)] = _tmpItemLogs;
  }

  static int getSoldBoxLength(){
    return soldBox.length;
  }

  Future<void> clearSoldBox() async {
    soldBox.clear();
    // await settingBox.delete('totalEarn');
    settingBox.remove('totalEarn');
    notifyListeners();
  }

  getSoldLogAt(int i){
    // var _tmpItemLogs = soldBox.getAt(i);
    var _tmpItemLogs = soldBox[soldBox.keys.elementAt(i)];
    return _tmpItemLogs;
  }

  String getSoldLogAtTime(int i){
    // var _tmpItemLogs = soldBox.keyAt(i);
    var _tmpItemLogs = soldBox.keys.elementAt(i);
    return _tmpItemLogs.toString();
  }

  String getEarnedLogAt(int i){
    // var _tmpItemLogs = soldBox.getAt(i);
    var _tmpItemLogs = soldBox[soldBox.keys.elementAt(i)];
    // String rt=_tmpItemLogs['{preserved}${soldBox.keyAt(i)}-thisEarn']['earn'].toString();
    String rt=_tmpItemLogs['{preserved}${soldBox.keys.elementAt(i)}-thisEarn']['earn'].toString();
    return rt.isNotEmpty?rt:"";
  }

  String getEarned(){
    // return settingBox.get('totalEarn', defaultValue: 0).toString();
    return settingBox['totalEarn']?.toString()??"0";
  }

  static Future<void> addTotalEarn(int earn) async {
    // await settingBox.put('totalEarn', settingBox.get('totalEarn', defaultValue: 0)+earn);
    settingBox['totalEarn'] = settingBox['totalEarn']??0+earn;
  }

}
