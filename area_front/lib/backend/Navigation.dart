// Core
import 'package:flutter/material.dart';

/// The Point of [Navigation] is to `wrappe` the Navigator method
/// in case we have to check some state before changing page
class Navigation {
  static navigate(BuildContext context, String routeName) {
    Navigator.of(context).pushReplacementNamed(routeName);
  }
}
