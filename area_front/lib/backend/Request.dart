part of 'Backend.dart';

class Request {
  static Future<Model.Applet> getApplet(FirebaseUser user, String id) async {
    final http.Response response =
        await Backend.get(user, BackendRoutes.specificApplet(id));

    switch (response.statusCode) {
      case 200:
        return compute(parseApplet, response.body);
        break;
      default:
        throw ('An error occured when fetching the applet please try again later');
    }
  }

  static List<Model.Applet> parseApplets(String body) {
    final parsed = json.decode(body);
    return (parsed as List)
        .map((e) => Model.Applet.fromJson((e as Map<String, dynamic>)))
        .toList();
  }

  static Future<List<Model.Applet>> getApplets(FirebaseUser user) async {
    final http.Response response =
        await Backend.get(user, BackendRoutes.applets);

    switch (response.statusCode) {
      case 200:
        return compute(parseApplets, response.body);
        break;

      default:
        throw ('An error occured when fetching all applet please try again later');
    }
  }

  static Model.Applet parseApplet(String body) {
          final parsedJson = json.decode(body);
          return Model.Applet.fromJson(parsedJson);
  }

  static Future<Model.Applet> activateApplet(
      FirebaseUser user, String id) async {
    final Map<String, String> userinfo = {"user_id": user.uid};
    final http.Response response = await Backend.post(
        user, BackendRoutes.activateApplet(id),
        body: userinfo);

    switch (response.statusCode) {
      case 200:
        return compute(parseApplet, response.body);
        break;

      default:
        throw ('An error occured when activating Applet');
    }
  }

  static Future<Model.Applet> desactivateApplet(
      FirebaseUser user, String id) async {
    final Map<String, String> userinfo = {"user_id": user.uid};
    final http.Response response = await Backend.post(
        user, BackendRoutes.desactivateApplet(id),
        body: userinfo);

    switch (response.statusCode) {
      case 200:
        return compute((String body) {
          final parsedJson = json.decode(body);
          return Model.Applet.fromJson(parsedJson);
        }, response.body);
        break;

      default:
        throw ('An error occured when desactivating Applet');
    }
  }

  static Future<Model.Applet> addOrUpdateApplet(
      FirebaseUser user, Model.Applet applet) async {
    final http.Response response = await Backend.post(
        user, BackendRoutes.addApplet(applet.id.toString()),
        body: json.encode(applet.toJson()));

    switch (response.statusCode) {
      case 200:
        return compute(parseApplet, response.body);
        break;

      default:
        throw ('An error occured when adding a new Applet');
    }
  }

  static List<Model.Service> parseServices(String body) {
    final parsed = json.decode(body);
    return (parsed as List)
        .map((e) => Model.Service.fromJson((e as Map<String, dynamic>)))
        .toList();
  }

  static Future<List<Model.Service>> getServices(FirebaseUser user) async {
    final http.Response response =
        await Backend.get(user, BackendRoutes.services);

    switch (response.statusCode) {
      case 200:
        return compute(parseServices, response.body);
        break;

      default:
        throw ('An error occured when fetching all services please try again later');
    }
  }

  static Future<List<dynamic>> notif(FirebaseUser user) async {
    final http.Response response = await Backend.get(user, BackendRoutes.notif);

    switch (response.statusCode) {
      case 200:
        print(json.decode(response.body));
        return json.decode(response.body);
        break;

      default:

        throw ('An error occured when fecthing Notif');
    }

  }
}
