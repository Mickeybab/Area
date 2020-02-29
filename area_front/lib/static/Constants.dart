import 'package:flutter/material.dart';

/// All the constants of the project area
class Constants {
  static const String explore = "Explore";
  static const String myApplets = "My applets";
  static const String myServices = "My services";
  static const String signOut = "Sign out";
  static const String signIn = "Sign in";
  static const String signUp = "Sign up";
  static const String epitechAuthLink = "Register Autologin Link";
  static const String enableServiceStart = "Please activate ";
  static const String enableServiceEnd = " service";

  static const String github = 'Github';
  static const String epitech = 'Intra Epitech';
  static const String slack = 'Slack';
  static const String currency = 'Currency';
  static const String weather = 'Weather';
  static const String googlemail = 'Google Mail';

  static const List<String> userControl = <String>[
    explore,
    myApplets,
    myServices,
    signOut,
  ];

  static const String or = 'or';
  static const String continueWithSlackOrGithub =
      'Continue With External Services';
  static const String errorMessagePasswordTooShort =
      'Enter at least 6 characters';
  static const String errorMessageEmailEmpty = 'Enter a valid email';
  static const String errorMessageTokenEmpty = 'Enter a valid autologin link';
  static const String hintPasswordField = 'Password';
  static const String hintTokenField = 'Autologin Link';
  static const String hintEmailField = 'Email';
  static const String forgotYourPassword = 'Forgot your password?';
  static const String resetPassword = 'Reset password';
  static const String usePassword = 'Or use your password to';
  static const String continueWithGithub = 'Continue with Github';
  static const String continueWithSlack = 'Continue with Slack';
  static const String continueWithGoogle = 'Continue with Google';
  static const String getStarted = 'Get Started';
  static const String hintSearchBar = 'Search';

  static const String mainTitle = 'Area v1';
  static const String title = "AREA";
  static const String getMore = "Get More";
  static const String connectYourWorld = 'Connect your world.';
  static const String submit = 'Submit';
  static const String allOk = "All Ok";
  static const String somethingWentWrong =
      "Something went wrong, please try again !";

  /// Styles
  static const String fontFamily = 'Montserrat';
  static const Color colorBorder = Color.fromARGB(255, 237, 237, 237);
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(20.0);
  static const TextStyle style =
      TextStyle(fontFamily: fontFamily, fontSize: 25.0, color: Colors.black);
  static const double defaultWidthBorder = 2.0;
}
