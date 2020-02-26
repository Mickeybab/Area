/// BackendRoutes list all of the route we call the Backend API
class BackendRoutes {
  static const String applets = "/applets/";
  static const String services = '/services';
  static const String notif = '/notif';

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

  /// service `identifier` for Github
  static const String github = 'github';

  /// service `identifier` for Epitech intra
  static const String intraEpitech = 'intraepitech';

  /// service `identifier` for Slack
  static const String slack = 'slack';

  /// service `identifier` for Microsoft
  static const String microsoft = 'microsoft';

  /// All possible value of a `Service`
  static const List<String> possibleService = const [
    github,
    intraEpitech,
    slack,
    microsoft
  ];


  /// return the url to interact with a `Service`
  static String specificService(String service) {
    assert(possibleService.indexOf(service) != -1);
    return ('$services/$service');
  }
}
