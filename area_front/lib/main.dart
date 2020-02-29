// Core
import 'package:area_front/pages/Home.dart';
import 'package:area_front/pages/auth/ResetPassword.dart';
import 'package:area_front/pages/services/CurrencyService.dart';
import 'package:area_front/pages/services/EpitechNoSyncService.dart';
import 'package:area_front/pages/services/EpitechSyncService.dart';
import 'package:area_front/pages/services/GithubService.dart';
import 'package:area_front/pages/services/GoogleMailService.dart';
import 'package:area_front/pages/services/NotificationService.dart';
import 'package:area_front/pages/services/SlackService.dart';
import 'package:area_front/pages/services/WeatherService.dart';
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
import 'package:area_front/pages/services/MyServices.dart' show MyServices;
import 'package:area_front/pages/Landing.dart' show LandingPage;

// Config
import 'package:global_configuration/global_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GlobalConfiguration().loadFromMap(config);
  runApp(MyApp());
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
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
      case Routes.notifService:
        return MaterialPageRoute(builder: (_) => CheckAuth(() => NotificationServicePage()));
        break;
      case Routes.githubService:
        return MaterialPageRoute(builder: (_) => CheckAuth(() => GithubServicePage()));
        break;
      case Routes.epitechNoSyncService:
        return MaterialPageRoute(builder: (_) => CheckAuth(() => EpitechNoSyncServicePage()));
        break;
      case Routes.epitechService:
        return MaterialPageRoute(builder: (_) => CheckAuth(() => EpitechSyncServicePage()));
        break;
      case Routes.slackService:
        return MaterialPageRoute(builder: (_) => CheckAuth(() => SlackServicePage()));
        break;
      case Routes.currencyService:
        return MaterialPageRoute(builder: (_) => CheckAuth(() => CurrencyServicePage()));
        break;
      case Routes.weatherService:
        return MaterialPageRoute(builder: (_) => CheckAuth(() => WeatherServicePage()));
        break;
      case Routes.googleMailService:
        return MaterialPageRoute(builder: (_) => CheckAuth(() => GoogleMailServicePage()));
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
