// Core
import 'package:flutter/material.dart';

// Pages
import 'package:area_front/pages/auth/SignIn.dart';
import 'package:area_front/pages/auth/SignUp.dart';

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
      return SignInPage(toggleSignForm: toggleSignForm);
    } else {
      return SignUpPage(toggleSignForm: toggleSignForm);
    }
  }
}