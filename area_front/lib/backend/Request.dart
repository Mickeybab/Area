part of 'Backend.dart';

class Request {
  static Future<Model.Applet> getApplet(FirebaseUser user, String id) async {
    final http.Response response =
        await Backend.get(user, BackendRoutes.specificApplet(id));

    switch (response.statusCode) {
      case 200:
        return compute((String body) {
          final parsed = json.decode(body);
          return Model.Applet.fromJson(parsed);
        }, response.body);
        break;
      default:
        throw ('An error occured when fetching the applet please try again later');
    }
  }

  static Future<List<Model.Applet>> getApplets(FirebaseUser user) async {

    final http.Response response =
        await Backend.get(user, BackendRoutes.applets);

    switch (response.statusCode) {
      case 200:
        return compute((String body) {
          final parsed = json.decode(body);
          return (parsed as List)
              .map((e) => Model.Applet.fromJson((e as Map<String, dynamic>)))
              .toList();
        }, response.body);
        break;

      default:
        throw ('An error occured when fetching all applet please try again later');
    }
  }

  static Future<Model.Applet> activateApplet(
      FirebaseUser user, String id) async {
    final Map<String, String> userinfo = {"user_id": user.uid};
    final http.Response response = await Backend.post(
        user, BackendRoutes.activateApplet(id),
        body: userinfo);

    switch (response.statusCode) {
      case 200:
        return compute((String body) {
          final parsedJson = json.decode(body);
          return Model.Applet.fromJson(parsedJson);
        }, response.body);
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
        user, BackendRoutes.addApplet(applet.id),
        body: applet.toJson());

    switch (response.statusCode) {
      case 200:
        return compute((String body) {
          final parsedJson = json.decode(body);
          return Model.Applet.fromJson(parsedJson);
        }, response.body);
        break;

      default:
        throw ('An error occured when adding a new Applet');
    }
  }
}
