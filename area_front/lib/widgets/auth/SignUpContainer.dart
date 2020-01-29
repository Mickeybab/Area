// Core
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Constants
import 'package:area_front/static/Constants.dart';

// Services
import 'package:area_front/services/Auth.dart';

class SignUpContainer extends StatefulWidget {

  final Function toggleSignForm;
  SignUpContainer({this.toggleSignForm });

  @override
  _SignUpContainerState createState() => _SignUpContainerState();
}

class _SignUpContainerState extends State<SignUpContainer> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final pageTitle = Text(
      Constants.signUp,
      style: Constants.style.copyWith(
        fontSize: 70.0,
        fontWeight: FontWeight.w600,
      ),
    );

    final emailField = TextFormField(
      obscureText: false,
      style: Constants.style,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 237, 237, 237), width: 5.0),
          borderRadius: BorderRadius.circular(10.0)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 5.0),
          borderRadius: BorderRadius.circular(10.0)
        ),
        contentPadding: EdgeInsets.all(20.0),
        hintText: "Email",
      ),
      validator: (value) => value.isEmpty ? 'Enter an email' : null,
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
    );

    final passwordField = TextFormField(
      obscureText: true,
      style: Constants.style,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 237, 237, 237), width: 5.0),
          borderRadius: BorderRadius.circular(10.0)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 5.0),
          borderRadius: BorderRadius.circular(10.0)
        ),
        contentPadding: EdgeInsets.all(20.0),
        hintText: "Password",
      ),
      validator: (value) => value.length < 6 ? 'Enter at least 6 characters' : null,
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
    );

    final signUpButon = Material(
      borderRadius: BorderRadius.circular(35.0),
      color: Colors.black,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            try {
              await _auth.signUpWithEmail(email, password);
            } on AuthException catch (e) {
              setState(() => error = e.message);
            }
          }
        },
        child: Text(
          Constants.signUp,
          textAlign: TextAlign.center,
          style: Constants.style.copyWith(color: Colors.white, fontWeight: FontWeight.w600)
        ),
      ),
    );

    final errorText = Text(
      error,
      style: Constants.style.copyWith(fontSize: 12, color: Colors.redAccent),
      textAlign: TextAlign.center,
    );

    final logWithButton = FlatButton(
      child: Text(
        'Continue With Slack or Github',
        style: Constants.style.copyWith(
          decoration: TextDecoration.underline,
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: () {
      },
    );

    final orText = Text(
      'or'
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
        widget.toggleSignForm();
      },
    );

    return Scaffold(
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
                pageTitle,
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(height: 25.0),
                signUpButon,
                SizedBox(height: 15.0),
                errorText,
                SizedBox(height: 15.0),
                logWithButton,
                SizedBox(height: 10.0),
                orText,
                SizedBox(height: 10.0),
                signInButton
              ],
            )
          ),
        ),
      ),
    );
  }
}