library area_links;

import 'dart:async';

import 'package:uni_links/uni_links.dart';

import 'package:area_links_platform_interface/area_links_platform_interface.dart';


class AreaLinks extends AreaLinksPlatform {
  StreamSubscription<String> _sub;

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
}
