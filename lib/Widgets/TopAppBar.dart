import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';
import 'package:universal_html/html.dart' as html;

import '../globals.dart' as globals;

class AppBar_G extends StatefulWidget {
  AppBar_G({
    super.key,
  });

  @override
  State<AppBar_G> createState() => _AppBarState();

}

class _AppBarState extends State<AppBar_G>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: const IconThemeData(color: Color(0xFFFFFFFF),),
      title:Builder(builder: (BuildContext context){
        return InkWell(
          hoverColor: Colors.transparent,
          onTap: (){
            context.push('/');
          },
          child: Row(
            children: const [
              Icon(Icons.shopping_cart,color: Color(0xFFFFFFFF),),
              SizedBox(width: 3),
              Text('コミケ自販機',style: TextStyle(color: Color(0xFFFFFFFF),),),
            ],
          ),
        );
      }),
      backgroundColor: Color(0xFF1f1f1f),
      pinned: true,
      // elevation: 10,
      // floating: true,
      //forceElevated: innerBoxIsScrolled,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              // Builder(builder: (BuildContext context){
              //   return InkWell(
              //     hoverColor: Colors.transparent,
              //     onTap: (){
              //       context.push('/');
              //     },
              //     child: Text("關於我們",style: TextStyle(color: Color(0xFF474747),fontSize: 16),),
              //   );
              // }),
              // SizedBox(width: 50,),

              // debug--------------------------------------------------
              // Image(
              //   image: NetworkImage('https://i.imgur.com/Sxd68s5.gif'),
              //   height: 100,
              // ),
              // SizedBox(width: 10,),
              //---------------------------------------------------------


              Builder(builder: (BuildContext context){
                return IconButton(
                  onPressed: () async {
                    setState(() {
                      globals.inFullScreen = !globals.inFullScreen;
                    });
                    if(globals.isInApp){
                      if (globals.inFullScreen) {
                        await WindowManager.instance.setFullScreen(true);
                      }
                      else {
                        await WindowManager.instance.setFullScreen(false);
                      }
                    }
                    else{
                      if (globals.inFullScreen) {
                        html.document.documentElement!.requestFullscreen();
                      }
                      else {
                        html.document.exitFullscreen();
                      }
                    }
                  },
                  icon: globals.inFullScreen?Icon(Icons.fullscreen_exit_rounded):Icon(Icons.fullscreen_rounded),
                  color: Color(0xFFFFFFFF),
                );
              }),
              // Icon(Icons.more_vert),
            ],
          ),
        ),
      ],
      surfaceTintColor: Color(0xFF1f1f1f),
    );
  }
}