// Core
import 'package:area_front/static/Routes.dart';
import 'package:area_front/widgets/AreaText.dart';
import 'package:area_front/widgets/AreaLargeButton.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/AreaTextField.dart';
import 'package:area_front/widgets/auth/ErrorAuthText.dart';
import 'package:area_front/widgets/auth/Link.dart';
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Constants
import 'package:area_front/static/Constants.dart';

// Services
import 'package:area_front/services/Auth.dart';

// Widgets
import 'package:area_front/widgets/AreaFlatButton.dart';

class SignInPage extends StatefulWidget {
  SignInPage({this.toggleSignForm});

  final Function toggleSignForm;

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String email = '';
  String error = '';
  String password = '';

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  AreaLargeButton _signInButton() {
    return AreaLargeButton(
      text: Constants.signIn,
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          try {
            await _auth.signInWithEmail(email, password);
          } on AuthException catch (e) {
            await _auth.signOut();
            setState(() => error = e.message);
          }
        }
      },
    );
  }

  AreaFlatButton _forgotButton() {
    return AreaFlatButton(
      onPressed: () {

      },
      text: Constants.forgotYourPassword,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
    );
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
                    AreaTitle(Constants.signIn),
                    SizedBox(height: 45.0),
                    this._emailField(),
                    SizedBox(height: 25.0),
                    this._passwordField(),
                    SizedBox(height: 5.0),
                    AreaLink(
                      Constants.forgotYourPassword,
                      routeName: Routes.resetPassword,
                    ),
                    SizedBox(height: 10.0),
                    this._signInButton(),
                    SizedBox(height: 15.0),
                    ErrorAuth(error),
                    SizedBox(height: 15.0),
                    AreaLink(
                      Constants.continueWithSlackOrGithub,
                      routeName: Routes.signWith,
                    ),
                    SizedBox(height: 10.0),
                    AreaText(Constants.or, fontSize: 13),
                    SizedBox(height: 10.0),
                    AreaLink(
                      Constants.signUp,
                      routeName: Routes.signUp,
                    ),
                  ],
                )),
          ),
        ));
  }
}
