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

class ResetPassword extends StatefulWidget {
  ResetPassword({this.toggleSignForm});

  final Function toggleSignForm;

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String email = '';
  String msg = '';

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  AreaLargeButton _forgotButton() {
    return AreaLargeButton(
      text: Constants.resetPassword,
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          try {
            await _auth.resetPassword(email);
            setState(() => msg = "An email has been sent to you to reset your password.");
          } on AuthException catch (e) {
            setState(() => msg = e.message);
          }
        }
      },
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
                    AreaTitle(Constants.resetPassword),
                    SizedBox(height: 45.0),
                    this._emailField(),
                    SizedBox(height: 25.0),
                    this._forgotButton(),
                    SizedBox(height: 15.0),
                    ErrorAuth(msg),
                    SizedBox(height: 15.0),
                    AreaLink(
                      Constants.signIn,
                      routeName: Routes.signIn,
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
