// Core
import 'package:flutter/material.dart';

class VerticalLandingStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    width: 200,
                    child: Image.asset(
                      "assets/images/3.0x/services.png",
                      fit: BoxFit.contain,
                    )),
              ],
            )));
  }
}
