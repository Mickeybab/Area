// Core
import 'package:flutter/material.dart';

class Navigation {
  static navigate(BuildContext context, String routeName) {
    Navigator.of(context).pushReplacementNamed(routeName);
  }
}
