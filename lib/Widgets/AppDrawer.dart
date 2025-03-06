import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Drawer(
        child: Container(
          color: Color(0xFF1f1f1f),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 60,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerTheme: const DividerThemeData(color: Colors.transparent),
                    ),
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            hoverColor: Colors.transparent,
                              padding: EdgeInsets.only(bottom: 4),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.menu),color: Color(0xFFFFFFFF),),
                          SizedBox(width: 20),
                          Icon(Icons.shopping_cart,color: Color(0xFFFFFFFF),),
                          SizedBox(width: 3),
                          Text(
                            'コミケ自販機',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    children: [
                      Divider(color: Color(0xFF1f1f1f),),
                      Card(
                        color: Color(0xFF474747),
                        child: ListTile(
                          leading: Icon(Icons.barcode_reader,color: Color(0xFFFFFFFF),),
                          title: const Text(
                            '注文しよう！',
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                          ),
                          // trailing: Icon(Icons.more_vert,color: Color(0xFFFFFFFF)),
                          onTap: () {
                            context.push('/sell');
                            //Navigator.pop(context);
                          },
                        ),
                      ),
                      Card(
                        color: Color(0xFF474747),
                        child: ListTile(
                          leading: Icon(Icons.add_shopping_cart_rounded,color: Color(0xFFFFFFFF),),
                          title: const Text(
                            '単品追加',
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                          ),
                          // trailing: Icon(Icons.more_vert,color: Color(0xFFFFFFFF)),
                          onTap: () {
                            context.push('/set');
                            //Navigator.pop(context);
                          },
                        ),
                      ),
                      Card(
                        color: Color(0xFF474747),
                        child: ListTile(
                          leading: Icon(Icons.discount_rounded,color: Color(0xFFFFFFFF),),
                          title: const Text(
                            'セット追加',
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                          ),
                          // trailing: Icon(Icons.more_vert,color: Color(0xFFFFFFFF)),
                          onTap: () {
                            context.push('/makeSet');
                            //Navigator.pop(context);
                          },
                        ),
                      ),
                      Card(
                        color: Color(0xFF474747),
                        child: ListTile(
                          leading: Icon(Icons.insert_chart,color: Color(0xFFFFFFFF),),
                          title: const Text(
                            'ログ',
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                          ),
                          // trailing: Icon(Icons.more_vert,color: Color(0xFFFFFFFF)),
                          onTap: () {
                            context.push('/log');
                            //Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
