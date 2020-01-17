// Core
import 'package:flutter/material.dart';

// Data
import 'package:area_front/static/Routes.dart' show Routes;

// Pages
import 'package:area_front/pages/Explore.dart';
import 'package:area_front/pages/Home.dart' show HomePage;
import 'package:area_front/pages/Login.dart' show LoginPage;
import 'package:area_front/pages/MyApplets.dart' show MyApplets;
import 'package:area_front/pages/MyServices.dart' show MyServices;
import 'package:area_front/pages/SignOut.dart' show SignOut;


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
          Routes.home: (BuildContext context) => HomePage(),
          Routes.login: (BuildContext context) => LoginPage(),
          Routes.signOut: (BuildContext context) => SignOut(),
          Routes.myApplets: (BuildContext context) => MyApplets(),
          Routes.myServices: (BuildContext context) => MyServices(),
          Routes.explore: (BuildContext context) => Explore(),
        });
  }
}
