import 'dart:convert';
import 'dart:async';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

class Backend {
  static Future<http.Response> get(http.Client client, String path, {Map<String, String> headers}) async {
    final String route = FlutterConfig.get('API_URL') + path;
    return await client.get(route, headers: headers);
  }

  static Future<http.Response> post(http.Client client, String path, {Map<String, String> headers, body, Encoding encoding}) async {
    final String route = FlutterConfig.get('API_URL') + path;
    return await client.post(route, headers: headers, body: body, encoding: encoding);
  }

  static Future<http.Response> put(http.Client client, String path, {Map<String, String> headers, body, Encoding encoding}) async {
    final route = FlutterConfig.get('API_URL') + path;
    return await client.put(route, headers: headers, body: body, encoding: encoding);
  }

  static Future<http.Response> patch(http.Client client, String path, {Map<String, String> headers, body, Encoding encoding}) async {
    final route = FlutterConfig.get('API_URL') + path;
    return await client.patch(route, headers: headers, body: body, encoding: encoding);
  }

  static Future<http.Response> delete(http.Client client, String path, {Map<String, String> headers}) async {
    final route = FlutterConfig.get('API_URL') + path;
    return await client.delete(route, headers: headers);
  }
}
