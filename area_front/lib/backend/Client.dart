part of 'Backend.dart';

/// Backend is a [IOClient] to create the correct [URL] for all request
class Backend extends IOClient {
  Map<String, String> _headers;/// headers of all request

  Backend(this._headers) : super();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<http.Response> head(Object url, {Map<String, String> headers}) =>
      super.head(url, headers: headers..addAll(_headers));

  @override
  Future<http.Response> get(dynamic path, {Map<String, String> headers}) async {
    final String route = GlobalConfiguration().getString('API_URL') + path;
    return await super.get(route, headers: headers);
  }

  @override
  Future<http.Response> post(dynamic path, {Map<String, String> headers, body, Encoding encoding}) async {
    final String route = GlobalConfiguration().getString('API_URL') + path;
    return await super.post(route, headers: headers, body: body, encoding: encoding);
  }

  Future<http.Response> put(dynamic path, {Map<String, String> headers, body, Encoding encoding}) async {
    final route = GlobalConfiguration().getString('API_URL') + path;
    return await super.put(route, headers: headers, body: body, encoding: encoding);
  }

  Future<http.Response> patch(dynamic path, {Map<String, String> headers, body, Encoding encoding}) async {
    final route = GlobalConfiguration().getString('API_URL') + path;
    return await super.patch(route, headers: headers, body: body, encoding: encoding);
  }

  Future<http.Response> delete(dynamic path, {Map<String, String> headers}) async {
    final route = GlobalConfiguration().getString('API_URL') + path;
    return await super.delete(route, headers: headers);
  }
}
