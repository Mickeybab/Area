library area_links;

import 'dart:async';

import 'package:uni_links/uni_links.dart';
import 'package:area_links_platform_interface/area_links_platform_interface.dart';
import 'package:area_links/Notification.dart' as N;

class AreaLinks extends AreaLinksPlatform {
  StreamSubscription<String> _sub;

  AreaLinks() {
    print("Ios & Android");
  }

  registerCallbackHandler(Function callback) {
    print('Je ne suis que la ...');
    if (_sub != null) {
      _sub.cancel();
    }
    _sub = getLinksStream().listen(callback);
  }

  cancel() {
    if (_sub != null) _sub.cancel();
  }

  Future sendNotification(dynamic message) {
    print('notifcation ios et android');
    return N.sendNotification(message);
  }
}
