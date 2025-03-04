import 'package:window_manager/window_manager.dart';

Map<String,int> tmpcart = {};
bool isInApp = true; // web false, mobile/app true

String needAssetPath(String url){
  return "${isInApp?'assets/':''}${url}";
}

bool inFullScreen = false;

// Future<void> toggleFullScreen() async {
//   inFullScreen = !inFullScreen;
//   if(inFullScreen){
//     await WindowManager.instance.setFullScreen(true);
//   }
//   else{
//     await WindowManager.instance.setFullScreen(false);
//   }
// }

// List<ItemCard> AllC = [
//   ItemCard(id: 0,name: "美游的胖次", price: 52, quantity: 1, image_uri: 'https://pbs.twimg.com/media/Gj-I-bJbQAANxtn?format=jpg&name=4096x4096',),
//   ItemCard(id: 1,name: "你媽", price: 0, quantity: 0, ),//https://www.moedict.tw/%E6%93%8D%E4%BD%A0%E5%AA%BD.png?font=wt064
// ];