@JS()
library message;

import 'dart:html';
import 'package:js/js.dart';

@JS('functionImportedInDart')
external get jsImportedFunction;
@JS('jsReceiveMessage')
external void jsReceiveMessage(Event a);
