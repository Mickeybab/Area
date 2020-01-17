// Core
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/TopBar.dart';

// Datas
import 'package:area_front/static/Constants.dart';

class SignOut extends StatelessWidget {
  const SignOut({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Center(
        child: FlatButton(
          child: Text(Constants.signOut),
          onPressed: () {
            print("Deconnexion !");
          },
        ),
      ),
    );
  }
}
