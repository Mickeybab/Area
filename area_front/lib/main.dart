// Core
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:area_front/services/Auth.dart';
import 'package:area_front/models/User.dart';

// Data
import 'package:area_front/static/Routes.dart' show Routes;

import 'package:area_front/Wrapper.dart';
// Pages
import 'package:area_front/pages/Explore.dart';
import 'package:area_front/pages/Home.dart' show HomePage;
import 'package:area_front/pages/auth/Authenticate.dart';
// import 'package:area_front/pages/auth/SignIn.dart' show SignInPage;
// import 'package:area_front/pages/auth/SignUp.dart' show SignUpPage;
import 'package:area_front/pages/auth/SignWith.dart' show SignWithPage;
import 'package:area_front/pages/MyApplets.dart' show MyApplets;
import 'package:area_front/pages/MyServices.dart' show MyServices;
import 'package:area_front/pages/auth/SignOut.dart' show SignOut;
import 'package:area_front/pages/Landing.dart' show LandingPage;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Area v1',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes: <String, WidgetBuilder>{
          Routes.landing: (BuildContext context) => LandingPage(),
          Routes.home: (BuildContext context) => HomePage(),
          // Routes.signIn: (BuildContext context) => SignInPage(),
          // Routes.signUp: (BuildContext context) => SignUpPage(),
          Routes.auth: (BuildContext context) => AuthPage(),
          Routes.signWith: (BuildContext context) => SignWithPage(),
          Routes.signOut: (BuildContext context) => SignOut(),
          Routes.myApplets: (BuildContext context) => MyApplets(),
          Routes.myServices: (BuildContext context) => MyServices(),
          Routes.explore: (BuildContext context) => Explore(),
        }
      ),
    );
  }
}
