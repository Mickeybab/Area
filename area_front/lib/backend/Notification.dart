
@JS()
library notification.js;

import 'package:js/js.dart';

@JS('sendNotification')
external Future sendNotification(message);
