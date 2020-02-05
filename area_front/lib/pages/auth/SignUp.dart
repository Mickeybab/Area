// Core
import 'package:area_front/static/Routes.dart';
import 'package:area_front/widgets/AreaLargeButton.dart';
import 'package:area_front/widgets/AreaText.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/AreaTextField.dart';
import 'package:area_front/widgets/auth/ErrorAuthText.dart';
import 'package:area_front/widgets/auth/Link.dart';
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Constants
import 'package:area_front/static/Constants.dart';

// Services
import 'package:area_front/services/Auth.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String email = '';
  String error = '';
  String password = '';

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  AreaTextField _emailField() {
    return AreaTextField(
        hintText: Constants.hintEmailField,
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
        validator: (value) =>
            value.isEmpty ? Constants.errorMessageEmailEmpty : null);
  }

  AreaTextField _passwordField() {
    return AreaTextField(
      obscureText: true,
      hintText: Constants.hintPasswordField,
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
      validator: (value) =>
          value.length < 6 ? Constants.errorMessagePasswordTooShort : null,
    );
  }

  AreaLargeButton _signUpButton() {
    return AreaLargeButton(
      text: Constants.signUp,
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          try {
            await _auth.signUpWithEmail(email, password);
            await _auth.signOut();
            setState(() => error = "A verification email has been sent to your email address. Please verify your address before logging in.");
          } on AuthException catch (e) {
            setState(() => error = e.message);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(36.0),
          width: 550,
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AreaTitle(Constants.signUp),
                  SizedBox(height: 45.0),
                  this._emailField(),
                  SizedBox(height: 25.0),
                  this._passwordField(),
                  SizedBox(height: 63.0),
                  this._signUpButton(),
                  SizedBox(height: 15.0),
                  ErrorAuth(error),
                  SizedBox(height: 15.0),
                  AreaLink(Constants.continueWithSlackOrGithub,
                      routeName: Routes.signWith),
                  SizedBox(height: 10.0),
                  AreaText(Constants.or, fontSize: 13),
                  SizedBox(height: 10.0),
                  AreaLink(Constants.signIn, routeName: Routes.signIn),
                ],
              )),
        ),
      ),
    );
  }
}
