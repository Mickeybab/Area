part of 'Backend.dart';

class Applet {
  static Future<Model.Applet> getApplet(http.Client client, String id) async {
    final http.Response response =
        await client.get(BackendRoutes.specificApplet(id));

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

  static Future<List<Model.Applet>> getApplets(http.Client client) async {
    final http.Response response = await client.get(BackendRoutes.applets);

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
}
