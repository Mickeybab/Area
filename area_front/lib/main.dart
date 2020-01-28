// Core
import 'package:flutter/material.dart';

// Data
import 'package:area_front/static/Routes.dart' show Routes;

// Config
import 'package:area_front/config.dart';

// Pages
import 'package:area_front/pages/Explore.dart';
import 'package:area_front/pages/Home.dart' show HomePage;
import 'package:area_front/pages/Login.dart' show LoginPage;
import 'package:area_front/pages/MyApplets.dart' show MyApplets;
import 'package:area_front/pages/MyServices.dart' show MyServices;
import 'package:area_front/pages/SignOut.dart' show SignOut;

// Config
import 'package:global_configuration/global_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GlobalConfiguration().loadFromMap(config);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
