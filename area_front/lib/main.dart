// Core
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Services
import 'package:area_front/services/Auth.dart';

// Models
import 'package:area_front/models/User.dart';

// Data
import 'package:area_front/static/Routes.dart' show Routes;

import 'package:area_front/Wrapper.dart';
// Config
import 'package:area_front/config.dart';

// Pages
import 'package:area_front/pages/Explore.dart';
import 'package:area_front/pages/auth/SignWith.dart' show SignWithPage;
import 'package:area_front/pages/MyApplets.dart' show MyApplets;
import 'package:area_front/pages/MyServices.dart' show MyServices;
import 'package:area_front/pages/Landing.dart' show LandingPage;

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
          Routes.wrapper: (BuildContext context) => Wrapper(),
          Routes.signWith: (BuildContext context) => SignWithPage(),
          Routes.myApplets: (BuildContext context) => MyApplets(),
          Routes.myServices: (BuildContext context) => MyServices(),
          Routes.explore: (BuildContext context) => Explore(),
        }
      ),
    );
  }
}
