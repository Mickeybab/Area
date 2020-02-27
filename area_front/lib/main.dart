// Core
import 'package:area_front/pages/GithubService.dart';
import 'package:area_front/pages/Home.dart';
import 'package:area_front/pages/auth/ResetPassword.dart';
import 'package:area_front/static/Constants.dart';
import 'package:area_front/pages/auth/SignUp.dart';
import 'package:area_front/pages/auth/SignWith.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Services
import 'package:area_front/services/Auth.dart';
import 'package:area_front/backend/CheckAuth.dart';

// Data
import 'package:area_front/static/Routes.dart' show Routes;

// Config
import 'package:area_front/config.dart';

// Pages
import 'package:area_front/pages/Explore.dart';
import 'package:area_front/pages/MyApplets.dart' show MyApplets;
import 'package:area_front/pages/MyServices.dart' show MyServices;
import 'package:area_front/pages/Landing.dart' show LandingPage;

// Config
import 'package:global_configuration/global_configuration.dart';
import 'dart:js';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GlobalConfiguration().loadFromMap(config);
  runApp(MyApp());
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings.toString());
    switch (settings.name) {
      case Routes.landing:
        return MaterialPageRoute(builder: (_) => CheckAuth(() => LandingPage()));
        break;
      case Routes.home:
        return MaterialPageRoute(builder: (_) => CheckAuth(() => HomePage()));
        break;
      case Routes.signIn:
        return MaterialPageRoute(builder: (_) => CheckAuth(() => HomePage()));
        break;
      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => SignUpPage());
        break;
      case Routes.signWith:
        return MaterialPageRoute(builder: (_) => SignWithPage());
        break;
      case Routes.resetPassword:
        return MaterialPageRoute(builder: (_) => ResetPassword());
        break;
      case Routes.myApplets:
        return MaterialPageRoute(builder: (_) => CheckAuth(() => MyApplets()));
        break;
      case Routes.myServices:
        return MaterialPageRoute(builder: (_) => CheckAuth(() => MyServices()));
        break;
      case Routes.explore:
        return MaterialPageRoute(builder: (_) => CheckAuth(() => Explore()));
        break;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: Constants.mainTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: CheckAuth(() => HomePage()),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
