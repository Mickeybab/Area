library area_links_web;

import 'dart:html' as html;
import 'dart:js';
import 'package:area_links_web/message.dart';
import 'package:area_links_web/Notification.dart' as N;
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:area_links_platform_interface/area_links_platform_interface.dart';

class AreaLinks extends AreaLinksPlatform {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
        'plugins.flutter.io/area_links_web',
        const StandardMethodCodec(),
        registrar.messenger);
    final AreaLinks instance = AreaLinks();
    channel.setMethodCallHandler(instance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'cancel':
        return cancel();
      case 'registerCallbackHandler':
        Function callback = call.arguments['callback'];
        return registerCallbackHandler(callback);
      case 'sendNotification':
        dynamic message = call.arguments['message'];
        return sendNotification(message);
      default:
        throw PlatformException(
            code: 'Unimplemented',
            details: "The url_launcher plugin for web doesn't implement "
                "the method '${call.method}'");
    }
  }

    AreaLinks() {
    print("Web");
  }


  /// Register a callback to be call when :
  /// - The opened browser instance redirect to the correct url
  registerCallbackHandler(void Function(String) callback) {
    context['dartReceiveMessage'] = callback;
    html.window.addEventListener('message', jsImportedFunction);
  }

  /// Clear the link
  cancel() {}

  Future sendNotification(dynamic message) {
    print('notifcaton web');
    return N.jsSendNotification(message);
  }
}
