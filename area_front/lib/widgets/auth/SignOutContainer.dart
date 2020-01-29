// Core
import 'package:area_front/static/Routes.dart';
import 'package:flutter/material.dart';

// Backend
import 'package:area_front/services/Auth.dart';

class SignOutContainer extends StatefulWidget {
  @override
  _SignOutContainerState createState() => _SignOutContainerState();
}

class _SignOutContainerState extends State<SignOutContainer> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 25.0, color: Colors.black);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final pageTitle = Text(
      'Sign out',
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 70.0,
        fontWeight: FontWeight.w600,
        color: Colors.black
      ),
    );

    final signOutButon = Material(
      borderRadius: BorderRadius.circular(35.0),
      color: Colors.black,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        onPressed: () async {
          await _auth.signOut();
          Navigator.of(context).pushReplacementNamed(Routes.landing);
        },
        child: Text("Confirme",
          textAlign: TextAlign.center,
          style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
        ),
      ),
    );

    final cancelButon = Material(
      borderRadius: BorderRadius.circular(35.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(Routes.home);
        },
        child: Text("Cancel",
          textAlign: TextAlign.center,
          style: style.copyWith(color: Colors.black, fontWeight: FontWeight.bold)
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
                signOutButon,
                SizedBox(height: 25.0),
                cancelButon,
              ],
            )
          ),
        ),
      ),
    );
  }
}