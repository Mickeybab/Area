// Core
import 'package:flutter/material.dart';

// Data
import 'package:area_front/static/Routes.dart' show Routes;

// Pages
import 'package:area_front/pages/Explore.dart';
import 'package:area_front/pages/Home.dart' show HomePage;
import 'package:area_front/pages/SignIn.dart' show SignInPage;
import 'package:area_front/pages/SignUp.dart' show SignUpPage;
import 'package:area_front/pages/SignWith.dart' show SignWithPage;
import 'package:area_front/pages/MyApplets.dart' show MyApplets;
import 'package:area_front/pages/MyServices.dart' show MyServices;
import 'package:area_front/pages/SignOut.dart' show SignOut;
import 'package:area_front/pages/Landing.dart' show LandingPage;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Area v1',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: <String, WidgetBuilder>{
          Routes.landing: (BuildContext context) => LandingPage(),
          Routes.home: (BuildContext context) => HomePage(),
          Routes.signIn: (BuildContext context) => SignInPage(),
          Routes.signUp: (BuildContext context) => SignUpPage(),
          Routes.signWith: (BuildContext context) => SignWithPage(),
          Routes.signOut: (BuildContext context) => SignOut(),
          Routes.myApplets: (BuildContext context) => MyApplets(),
          Routes.myServices: (BuildContext context) => MyServices(),
          Routes.explore: (BuildContext context) => Explore(),
        });
  }
}
