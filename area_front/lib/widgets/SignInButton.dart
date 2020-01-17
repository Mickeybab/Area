// Core
import 'package:flutter/material.dart';

// Data
import 'package:area_front/static/Constants.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(Constants.signIn),
    );
  }
}