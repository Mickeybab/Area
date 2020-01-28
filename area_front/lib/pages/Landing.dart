// Core
import 'package:area_front/widgets/SignInContainer.dart';
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/TopBar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(-0.80, -0.20),
            child: Image.asset(
              "assets/images/3.0x/services.png",
              width: 600,
              height: 600,
              fit: BoxFit.contain,
            )
          ),
          Align(
            alignment: Alignment(0.80, -0.20),
            child: Container(
              height: 140,
              width: 450,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17.0),
                color: Color.fromARGB(255, 237, 237, 237),
              ),
              child: SignInContainer()
            )
          )
        ],
      ),
    );
  }
}
