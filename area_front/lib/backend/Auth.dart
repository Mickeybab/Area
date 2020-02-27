@JS()
library auth;

import 'package:js/js.dart';


@JS('code')
external String get code;
@JS('notloged')
external bool get notloged;

@JS('openWindow')
external openWindow(String url, String title, int w, int h);