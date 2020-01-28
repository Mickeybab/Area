// Core
import 'package:flutter/material.dart';

class SignWithContainer extends StatefulWidget {
  @override
  _SignWithContainerState createState() => _SignWithContainerState();
}

class _SignWithContainerState extends State<SignWithContainer> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 25.0, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    final pageTitle = Text(
      'Get started',
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 70.0,
        fontWeight: FontWeight.w600,
        color: Colors.black
      ),
    );

    final continueWithSlackButon = Material(
      borderRadius: BorderRadius.circular(35.0),
      color: Colors.black,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        onPressed: () {},
        child: Text("Continue With Slack",
          textAlign: TextAlign.center,
          style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
        ),
      ),
    );

    final continueWithGithubButon = Material(
      borderRadius: BorderRadius.circular(35.0),
      color: Colors.black,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        onPressed: () {},
        child: Text("Continue With Github",
          textAlign: TextAlign.center,
          style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
        ),
      ),
    );

    final usePasswordText = Text(
      'Or use your password to'
    );

    final orText = Text(
      'or'
    );

    final signInButton = FlatButton(
      child: Text(
        'Sign in',
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontFamily: 'Montserrat',
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: () {
      },
    );

    final signUpButton = FlatButton(
      child: Text(
        'Sign up',
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontFamily: 'Montserrat',
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: () {
      },
    );

    return Scaffold(
      body: Center(
        child: Container(
          width: 550,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                pageTitle,
                SizedBox(height: 45.0),
                continueWithSlackButon,
                SizedBox(height: 25.0),
                continueWithGithubButon,
                SizedBox(height: 15.0),
                usePasswordText,
                SizedBox(height: 15.0),
                signInButton,
                SizedBox(height: 15.0),
                orText,
                SizedBox(height: 15.0),
                signUpButton
              ],
            )
          ),
        ),
      ),
    );
  }
}