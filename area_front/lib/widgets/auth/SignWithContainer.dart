// Core
import 'package:flutter/material.dart';

// Constants
import 'package:area_front/static/Constants.dart';

class SignWithContainer extends StatefulWidget {
  @override
  _SignWithContainerState createState() => _SignWithContainerState();
}

class _SignWithContainerState extends State<SignWithContainer> {

  @override
  Widget build(BuildContext context) {
    final pageTitle = Text(
      'Get started',
      style: Constants.style.copyWith(
        fontSize: 70.0,
        fontWeight: FontWeight.w600,
      ),
    );

    final continueWithSlackButon = Material(
      borderRadius: BorderRadius.circular(35.0),
      color: Colors.black,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        onPressed: () {},
        child: Text(
          'Continue With Slack',
          textAlign: TextAlign.center,
          style: Constants.style.copyWith(color: Colors.white, fontWeight: FontWeight.w600)
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
        child: Text(
          'Continue With Github',
          textAlign: TextAlign.center,
          style: Constants.style.copyWith(color: Colors.white, fontWeight: FontWeight.w600)
        ),
      ),
    );

    final usePasswordText = Text(
      'Or use your password to',
      style: Constants.style.copyWith(fontSize: 13),
    );

    final orText = Text(
      'or',
      style: Constants.style.copyWith(fontSize: 13),
    );

    final signInButton = FlatButton(
      child: Text(
        Constants.signIn,
        style: Constants.style.copyWith(
          decoration: TextDecoration.underline,
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: () {
      },
    );

    final signUpButton = FlatButton(
      child: Text(
        Constants.signUp,
        style: Constants.style.copyWith(
          decoration: TextDecoration.underline,
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