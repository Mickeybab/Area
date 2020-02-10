part of 'Backend.dart';

/// Backend is a [IOClient] to create the correct [URL] for all request
class Backend {
  static Future<http.Response> get(FirebaseUser user, dynamic path,
      {Map<String, String> headers}) async {
    final respToken = await user.getIdToken();
    headers
        .addAll({HttpHeaders.authorizationHeader: 'Bearer ${respToken.token}'});
    final String route = GlobalConfiguration().getString('API_URL') + path;
    return await http.get(route, headers: headers);
  }

  static Future<http.Response> post(FirebaseUser user, dynamic path,
      {Map<String, String> headers, body, Encoding encoding}) async {
    final respToken = await user.getIdToken();
    headers
        .addAll({HttpHeaders.authorizationHeader: 'Bearer ${respToken.token}'});
    final String route = GlobalConfiguration().getString('API_URL') + path;
    return await http.post(route,
        headers: headers, body: body, encoding: encoding);
  }

  static Future<http.Response> put(FirebaseUser user, dynamic path,
      {Map<String, String> headers, body, Encoding encoding}) async {
    final respToken = await user.getIdToken();
    headers
        .addAll({HttpHeaders.authorizationHeader: 'Bearer ${respToken.token}'});
    final route = GlobalConfiguration().getString('API_URL') + path;
    return await http.put(route,
        headers: headers, body: body, encoding: encoding);
  }

  static Future<http.Response> patch(FirebaseUser user, dynamic path,
      {Map<String, String> headers, body, Encoding encoding}) async {
    final respToken = await user.getIdToken();
    headers
        .addAll({HttpHeaders.authorizationHeader: 'Bearer ${respToken.token}'});
    final route = GlobalConfiguration().getString('API_URL') + path;
    return await http.patch(route,
        headers: headers, body: body, encoding: encoding);
  }

  static Future<http.Response> delete(FirebaseUser user, dynamic path,
      {Map<String, String> headers}) async {
    final respToken = await user.getIdToken();
    headers
        .addAll({HttpHeaders.authorizationHeader: 'Bearer ${respToken.token}'});
    final route = GlobalConfiguration().getString('API_URL') + path;
    return await http.delete(route, headers: headers);
  }
}
