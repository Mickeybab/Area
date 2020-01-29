// Core
import 'package:flutter/material.dart';

// Model

class Navigation {
  static navigate(BuildContext context, String routeName) {
    Navigator.of(context).pushReplacementNamed(routeName);
  }
}
