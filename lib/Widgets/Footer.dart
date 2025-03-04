import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 100,
      color: Color(0xFF1f1f1f),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Center(
            child: Text(
              "made with ❤ love",style: TextStyle(color: Color(0xFFFFFFFF)),)),
      ),
    );
  }
}
