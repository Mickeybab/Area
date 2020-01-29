// Core
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:area_front/widgets/auth/SignUpContainer.dart';

class SignUpPage extends StatelessWidget {
  final Function toggleSignForm;
  SignUpPage({ this.toggleSignForm });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body:  SignUpContainer(toggleSignForm: toggleSignForm)
    );
  }
}
