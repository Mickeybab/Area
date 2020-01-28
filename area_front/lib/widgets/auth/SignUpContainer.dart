// Core
import 'package:area_front/services/Auth.dart';
import 'package:flutter/material.dart';

class SignUpContainer extends StatefulWidget {

  final Function toggleSignForm;
  SignUpContainer({this.toggleSignForm });

  @override
  _SignUpContainerState createState() => _SignUpContainerState();
}

class _SignUpContainerState extends State<SignUpContainer> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 25.0, color: Colors.black);

  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final pageTitle = Text(
      'Sign up',
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

    final signUpButon = Material(
      borderRadius: BorderRadius.circular(35.0),
      color: Colors.black,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        onPressed: () async {

        },
        child: Text("Sign up",
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
              SizedBox(height: 25.0),
              signUpButon,
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
    );
  }
}