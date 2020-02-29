/// BackendRoutes list all of the route we call the Backend API
class BackendRoutes {
  static const String applets = "/applets/";
  static const String services = '/services';


  /// return the url to `sync` a service from the service name
  static String syncService(String id) {
    return ('$services/$id/sync');
  }

   /// return the url to `activate` a service from the service name
  static String activateService(String id) {
    return ('$services/$id/activate');
  }

    /// return the url to `desactivate` a service from the service name
  static String desactivateService(String id) {
    return ('$services/$id/desactivate');
  }

  /// return the url to `interact` with an applet from the applet `id`
  static String specificApplet(String id) {
    return ('$applets$id');
  }

  /// return the url to `activate` an applet from the applet `id`
  static String activateApplet(String id) {
    String applet = specificApplet(id);
    return ('$applet/activate');
  }

  /// return the url to `add` an applet from the applet `id` <-- did'nt make any sense for me neither
  static String addApplet(String id) {
    String applet = specificApplet(id);
    return ('$applet/add');
  }

  /// return the url to `desactivate` an applet from the applet `id`
  static String desactivateApplet(String id) {
    String applet = specificApplet(id);
    return ('$applet/desactivate');
  }

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
    return ('$services/$service');
  }
}
