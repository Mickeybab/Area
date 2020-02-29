@JS()
library message;

import 'dart:html';
import 'package:js/js.dart';

@JS('toto')
external get toto;
@JS('jsReceiveMessage')
external void jsReceiveMessage(Event a);
