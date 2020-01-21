// Core
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/TopBar.dart';

// Datas
import 'package:area_front/static/Constants.dart';
import 'package:area_front/static/Routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Container(
        child: RaisedButton(
            child: Text(Constants.getMore),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.home);
            },
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
            )),
      ),
    );
  }
}
