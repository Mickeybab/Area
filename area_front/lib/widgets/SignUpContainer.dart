// Core
import 'package:flutter/material.dart';

class SignUpContainer extends StatefulWidget {
  @override
  _SignUpContainerState createState() => _SignUpContainerState();
}

class _SignUpContainerState extends State<SignUpContainer> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 25.0, color: Colors.black);

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

    final emailField = TextField(
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
    );

    final passwordField = TextField(
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

    final signUpButon = Material(
      borderRadius: BorderRadius.circular(35.0),
      color: Colors.black,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        onPressed: () {},
        child: Text("Sign up",
          textAlign: TextAlign.center,
          style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
        ),
      ),
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
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(height: 25.0),
                signUpButon,
                SizedBox(height: 15.0),
                logWithButton,
              ],
            )
          ),
        ),
      ),
    );
  }
}