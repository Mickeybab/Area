// Core
import 'package:flutter/material.dart';

Color hexToColor(String hexString) {
  var value = int.parse(hexString.substring(4, 10), radix: 16) + 0xFF000000;
  print(value);
  return Color(value);
}