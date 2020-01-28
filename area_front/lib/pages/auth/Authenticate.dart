// Core
import 'package:area_front/widgets/auth/SignInContainer.dart';
import 'package:area_front/widgets/auth/SignUpContainer.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool showSignIn = true;

  void toggleSignForm() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInContainer(toggleSignForm: toggleSignForm);
    } else {
      return SignUpContainer(toggleSignForm: toggleSignForm);
    }
  }
}