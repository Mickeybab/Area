// Core
import 'package:area_front/pages/Home.dart';
import 'package:area_front/static/Constants.dart';
import 'package:area_front/pages/auth/SignUp.dart';
import 'package:area_front/pages/auth/SignWith.dart';
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
import 'package:area_front/pages/MyApplets.dart' show MyApplets;
import 'package:area_front/pages/MyServices.dart' show MyServices;
import 'package:area_front/pages/Landing.dart' show LandingPage;
import 'package:area_front/pages/auth/SignIn.dart' show SignInPage;

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
          title: Constants.mainTitle,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: CheckAuth(() => HomePage()),
          routes: <String, WidgetBuilder>{
            Routes.landing: (BuildContext context) =>
                CheckAuth(() => LandingPage()),
            Routes.home: (BuildContext context) => CheckAuth(() => HomePage()),
            Routes.signIn: (BuildContext context) => CheckAuth(() => HomePage()),
            Routes.signUp: (BuildContext context) => SignUpPage(),
            Routes.signWith: (BuildContext context) => SignWithPage(),
            Routes.myApplets: (BuildContext context) =>
                CheckAuth(() => MyApplets()),
            Routes.myServices: (BuildContext context) =>
                CheckAuth(() => MyServices()),
            Routes.explore: (BuildContext context) =>
                CheckAuth(() => Explore()),
          }),
    );
  }
}
