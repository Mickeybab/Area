// Core
import 'package:area_front/backend/Auth.dart';
import 'package:flutter/material.dart';

class SignInContainer extends StatefulWidget {

  final Function toggleSignForm;
  SignInContainer({this.toggleSignForm });

  @override
  _SignInContainerState createState() => _SignInContainerState();
}

class _SignInContainerState extends State<SignInContainer> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 25.0, color: Colors.black);

  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final pageTitle = Text(
      'Sign in',
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 70.0,
        fontWeight: FontWeight.w600,
        color: Colors.black
      ),
    );

    final emailField = TextFormField(
      obscureText: false,
      style: style,
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
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
    );

    final passwordField = TextFormField(
      obscureText: true,
      style: style,
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
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
    );

    final forgotButton = FlatButton(
      child: Text(
        'Forgot your password',
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontFamily: 'Montserrat',
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
          color: Colors.grey
        ),
      ),
      onPressed: () {
      },
    );

    final signInButon = Material(
      borderRadius: BorderRadius.circular(35.0),
      color: Colors.black,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        onPressed: () async {
          // dynamic user = await _auth.
        },
        child: Text("Sign in",
          textAlign: TextAlign.center,
          style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
        ),
      ),
    );

    final logWithButton = FlatButton(
      child: Text(
        'Continue With Slack or Github',
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

    final orText = Text(
      'or'
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
        widget.toggleSignForm();
      },
    );

    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(36.0),
          width: 550,
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                pageTitle,
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(height: 5.0),
                forgotButton,
                SizedBox(height: 10.0),
                signInButon,
                SizedBox(height: 15.0),
                logWithButton,
                SizedBox(height: 10.0),
                orText,
                SizedBox(height: 10.0),
                signUpButton
              ],
            )
          ),
      )
    );
  }
}