class Routes {
  static const String landing = "/landing";
  static const String wrapper = "/home";
  static const String home = "/home";
  static const String explore = "/explore";
  static const String myApplets = "/my-applets";
  static const String myServices = "/my-services";
  static const String auth = "/auth";
  static const String signIn = "/sign-in";
  static const String signUp = "/sign-up";
  static const String signWith = "/sign-with";
  static const String resetPassword = "/reset-password";
  static const String myPage = "/my-page";
  static const String notifService = "/my-services/notification";
  static const String githubService = "/my-services/github";
  static const String epitechService = "/my-services/intraepitech";
  static const String slackService = "/my-services/slack";
  static const String currencyService = "/my-services/currency";
  static const String weatherService = "/my-services/weather";
  static const String googleMailService = "/my-services/googlemail";
  static const String sendGridService = "/my-services/email";

  /// service `identifier` for Notification
  static const String notification = 'notification';

  /// service `identifier` for Github
  static const String github = 'github';

  /// service `identifier` for Epitech intra
  static const String intraEpitech = 'intraepitech';

  /// service `identifier` for Slack
  static const String slack = 'slack';

  /// service `identifier` for Currency
  static const String currency = 'currency';

  /// service `identifier` for Weather
  static const String weather = 'weather';

  /// service `identifier` for Gmail
  static const String google = 'googlemail';

    /// service `identifier` for SendGrid
  static const String email = 'email';

  /// All possible value of a `Service`
  static const List<String> possibleService = const [
    notification,
    github,
    intraEpitech,
    slack,
    currency,
    weather,
    google,
    email
  ];

  /// return the url to interact with a `Service`
  static String specificService(String service) {
    assert(possibleService.indexOf(service) != -1);
    return ('$myServices/$service');
  }
}
