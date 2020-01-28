// Core
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/TopBar.dart';
import 'package:area_front/widgets/auth/SignWithContainer.dart';

class SignWithPage extends StatelessWidget {
  const SignWithPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Container(
        child: SignWithContainer()
      ),
    );
  }
}
