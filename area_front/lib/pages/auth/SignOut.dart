// Core
import 'package:area_front/widgets/auth/SignOutContainer.dart';
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/TopBar.dart';


class SignOut extends StatelessWidget {
  const SignOut({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Container(
        child: SignOutContainer()
      ),
    );
  }
}
