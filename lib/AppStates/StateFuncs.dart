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

//-------------TANPPIN CARDS----------------

  // Hive states
  static final sellItemBox = Hive.box('cardBox');

  Future<void> setCard(int id, String name, int price, int quantity, String? image_uri) async {
    await sellItemBox.put(name, {
      'id': id,
      'price': price,
      'quantity': quantity,
      'image_uri': image_uri!.isNotEmpty?image_uri:"null",
    });
    notifyListeners();
  }

  Future<void> editCard(String origName, int id, String name, int price, int quantity, String? image_uri) async {
    await sellItemBox.put(name, {
      'id': id,
      'price': price,
      'quantity': quantity,
      'image_uri': image_uri!.isNotEmpty?image_uri:"null",
    });
    if(origName!=name) {
      await sellItemBox.delete(origName);
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
    await sellItemBox.clear();
  }

  Future<void> delCard(String name) async{
    await sellItemBox.delete(name);
    notifyListeners();
  }

  ItemCard getCard(int id){
    return ItemCard(name: sellItemBox.keyAt(id), price: sellItemBox.getAt(id)['price'], quantity: sellItemBox.getAt(id)['quantity'], id: id, image_uri: sellItemBox.getAt(id)['image_uri'].toString().isNotEmpty?sellItemBox.getAt(id)['image_uri'].toString():null);
  }

  ItemCard getCardByName(String name){
    return ItemCard(name: name, price: sellItemBox.get(name)['price'], quantity: sellItemBox.get(name)['quantity'], id: sellItemBox.get(name)['id'], image_uri: sellItemBox.get(name)['image_uri'].toString().isNotEmpty?sellItemBox.get(name)['image_uri'].toString():null);
  }

  ItemCard getSellCard(int id){
    return ItemCard(name: sellItemBox.keyAt(id), price: sellItemBox.getAt(id)['price'], quantity: sellItemBox.getAt(id)['quantity'], id: id, image_uri: sellItemBox.getAt(id)['image_uri'].toString().isNotEmpty?sellItemBox.getAt(id)['image_uri'].toString():null, hasdel: false);
  }

  ItemBrick getSellBrick(int id){
    return ItemBrick(name: sellItemBox.keyAt(id), quantity: sellItemBox.getAt(id)['quantity']);
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
          await sellSetBox.put(i.substring(i.indexOf('{SET}')+5, i.length), {
            'id': sellSetBox.length,
            'name': i.substring(i.indexOf('{SET}')+5, i.length),
            'price': sellSetBox.get(i.substring(i.indexOf('{SET}')+5, i.length))['price'],
            'quantity': sellSetBox.get(i.substring(i.indexOf('{SET}')+5, i.length))['quantity']-globals.tmpcart[i],
            'image_uri': sellSetBox.get(i.substring(i.indexOf('{SET}')+5, i.length))['image_uri'],
          });
        }
        else{
          await sellItemBox.put(i, {
            'id': sellItemBox.get(i)['id'],
            'name': i,
            'price': sellItemBox.get(i)['price'],
            'quantity': sellItemBox.get(i)['quantity'] - globals.tmpcart[i],
            'image_uri': sellItemBox.get(i)['image_uri'],
          });
        }
      }
    globals.tmpcart.clear();
    notifyListeners();
  }

//-------------SET CARDS----------------

  static final sellSetBox = Hive.box('setBox');

  Future<void> setSetCard(int id, String name, int price, int quantity, String? image_uri, Map items) async {
    await sellSetBox.put(name, {
      'id': id,
      'price': price,
      'quantity': quantity,
      'image_uri': image_uri!.isNotEmpty?image_uri:"null",
      'items': items,
    });
    notifyListeners();
  }

  Future<void> editSetCard(String origName, int id, String name, int price, int quantity, String? image_uri, Map items) async {
    await sellSetBox.put(name, {
      'id': id,
      'price': price,
      'quantity': quantity,
      'image_uri': image_uri!.isNotEmpty?image_uri:"null",
      'items': items,
    });
    if(origName!=name) {
      await sellSetBox.delete(origName);
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
    await sellSetBox.clear();
  }

  Future<void> delSetCard(String name) async{
    await sellSetBox.delete(name);
    notifyListeners();
  }

  ItemCard getSetCard(int id){
    return ItemCard(type:ItemCardType.set, name: sellSetBox.keyAt(id), price: sellSetBox.getAt(id)['price'], quantity: sellSetBox.getAt(id)['quantity'], id: id, image_uri: sellSetBox.getAt(id)['image_uri'].toString().isNotEmpty?sellSetBox.getAt(id)['image_uri'].toString():null);
  }

  ItemCard getSetCardByName(String name){
    return ItemCard(type:ItemCardType.set, name: name, price: sellSetBox.get(name)['price'], quantity: sellSetBox.get(name)['quantity'], id: sellSetBox.get(name)['id'], image_uri: sellSetBox.get(name)['image_uri'].toString().isNotEmpty?sellSetBox.get(name)['image_uri'].toString():null);
  }

  ItemCard getSetSellCard(int id){
    return ItemCard(type:ItemCardType.set, name: sellSetBox.keyAt(id), price: sellSetBox.getAt(id)['price'], quantity: sellSetBox.getAt(id)['quantity'], id: id, image_uri: sellSetBox.getAt(id)['image_uri'].toString().isNotEmpty?sellSetBox.getAt(id)['image_uri'].toString():null, hasdel: false);
  }




//-------------SETTINGS----------------

  static final settingBox = Hive.box('settingBox');

  static Future<void> wrapInit() async {
    await settingBox.put('wrapInit', true);
  }

  static bool getWrapInit() {
    return settingBox.get('wrapInit', defaultValue: false);
  }

  static Future<void> setWrapInit() async {
    await settingBox.put('setWrapInit', true);
  }

  static bool getSetWrapInit() {
    return settingBox.get('setWrapInit', defaultValue: false);
  }

  static Future<void> launchInit() async {
    await settingBox.put('launchInit', true);
  }

  static bool getLaunchInit() {
    return settingBox.get('launchInit', defaultValue: false);
  }

  static final soldBox = Hive.box('soldBox');

  static Future<void> addSellLog() async{
    DateTime now = DateTime.now();
    Map<String,Map<String,int>> _tmpItemLogs = {};
    for(final i in globals.tmpcart.keys){
      if(i.startsWith('{SET}')){
        _tmpItemLogs[i] = {
          "price": sellSetBox.get(i.substring(i.indexOf('{SET}')+5, i.length))['price'],
          "quantity": globals.tmpcart[i]!,
          "earn": sellSetBox.get(i.substring(i.indexOf('{SET}')+5, i.length))['price'] * globals.tmpcart[i],
        };
      }
      else{
        _tmpItemLogs[i] = {
          "price": sellItemBox.get(i)['price'],
          "quantity": globals.tmpcart[i]!,
          "earn": sellItemBox.get(i)['price'] * globals.tmpcart[i],
        };
      }
    }
    _tmpItemLogs['{preserved}${DateFormat('y/M/d-kk:mm:ss').format(now)}-thisEarn'] = {
      "price": -1,
      "quantity": -1,
      "earn": ttc2,
    };
    await soldBox.put(DateFormat('y/M/d-kk:mm:ss').format(now), _tmpItemLogs);
  }

  static int getSoldBoxLength(){
    return soldBox.length;
  }

  Future<void> clearSoldBox() async {
    await soldBox.clear();
    await settingBox.delete('totalEarn');
    notifyListeners();
  }

  getSoldLogAt(int i){
    var _tmpItemLogs = soldBox.getAt(i);
    return _tmpItemLogs;
  }

  String getSoldLogAtTime(int i){
    var _tmpItemLogs = soldBox.keyAt(i);
    return _tmpItemLogs.toString();
  }

  String getEarnedLogAt(int i){
    var _tmpItemLogs = soldBox.getAt(i);
    String rt=_tmpItemLogs['{preserved}${soldBox.keyAt(i)}-thisEarn']['earn'].toString();
    return rt.isNotEmpty?rt:"";
  }

  String getEarned(){
    return settingBox.get('totalEarn', defaultValue: 0).toString();
  }

  static Future<void> addTotalEarn(int earn) async {
    await settingBox.put('totalEarn', settingBox.get('totalEarn', defaultValue: 0)+earn);
  }

}
