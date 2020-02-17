part of 'Backend.dart';

/// Backend is a [IOClient] to create the correct [URL] for all request
class Backend {
  static Future<Map<String, String>> addTokenToHeader(
      FirebaseUser user, Map<String, String> headers) async {
    final respToken = await user.getIdToken();

    if (headers == null)
      return {HttpHeaders.authorizationHeader: 'Bearer ${respToken.token}'};
    headers
        .addAll({HttpHeaders.authorizationHeader: 'Bearer ${respToken.token}'});
    return headers;
  }

  static Future<http.Response> get(FirebaseUser user, dynamic path,
      {Map<String, String> headers}) async {
    headers = await addTokenToHeader(user, headers);
    final String route = GlobalConfiguration().getString('API_URL') + path;
    try {
      return await http.get(route, headers: headers);
    } catch (e) {
      print(e);
      throw (Constants.somethingWentWrong);
    }
  }

  static Future<http.Response> post(FirebaseUser user, dynamic path,
      {Map<String, String> headers, body, Encoding encoding}) async {
    headers = await addTokenToHeader(user, headers);
    final String route = GlobalConfiguration().getString('API_URL') + path;
    try {
      return await http.post(route,
          headers: headers, body: body, encoding: encoding);
    } catch (e) {
      print(e);
      throw (Constants.somethingWentWrong);
    }
  }

  static Future<http.Response> put(FirebaseUser user, dynamic path,
      {Map<String, String> headers, body, Encoding encoding}) async {
    headers = await addTokenToHeader(user, headers);
    final route = GlobalConfiguration().getString('API_URL') + path;
    try {
      return await http.put(route,
          headers: headers, body: body, encoding: encoding);
    } catch (e) {
      print(e);
      throw (Constants.somethingWentWrong);
    }
  }

  static Future<http.Response> patch(FirebaseUser user, dynamic path,
      {Map<String, String> headers, body, Encoding encoding}) async {
    headers = await addTokenToHeader(user, headers);
    final route = GlobalConfiguration().getString('API_URL') + path;
    try {
      return await http.patch(route,
          headers: headers, body: body, encoding: encoding);
    } catch (e) {
      print(e);
      throw (Constants.somethingWentWrong);
    }
  }

  static Future<http.Response> delete(FirebaseUser user, dynamic path,
      {Map<String, String> headers}) async {
    headers = await addTokenToHeader(user, headers);
    final route = GlobalConfiguration().getString('API_URL') + path;
    try {
      return await http.delete(route, headers: headers);
    } catch (e) {
      print(e);
      throw (Constants.somethingWentWrong);
    }
  }
}
