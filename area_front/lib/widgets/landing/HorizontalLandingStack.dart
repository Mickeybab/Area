// Core
import 'package:flutter/material.dart';

import 'package:area_front/pages/auth/SignIn.dart';
import 'package:area_front/static/Constants.dart';

class HorizontalLandingStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
            alignment: Alignment(-0.80, -0.20),
            child: Image.asset(
              "assets/images/3.0x/services.png",
              width: 600,
              height: 600,
              fit: BoxFit.contain,
            )),
        Align(
            alignment: Alignment(0.80, -0.20),
            child: Container(
                height: 140,
                width: 450,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17.0),
                  color: Constants.colorBorder,
                ),
                child: SignInPage()))
      ],
    );
  }
}
