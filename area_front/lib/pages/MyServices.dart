// Core
import 'package:area_front/widgets/GoogleButtonLogin.dart';
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';

class MyServices extends StatelessWidget {
  const MyServices({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Column(
        children: <Widget>[
          Center(
              child: Text("Mes Services"),
          ),
          GoogleButtonLogin()
        ],
      ),
    );
  }
}
