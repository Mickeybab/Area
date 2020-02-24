// Core
import 'package:flutter/material.dart';

// Widgets
import 'package:area_front/widgets/AreaText.dart';

class ErrorAuth extends StatelessWidget {
  final String error;
  const ErrorAuth(this.error, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AreaText(
      error,
      fontSize: 12,
      color: Colors.redAccent,
      textAlign: TextAlign.center,
    );
  }
}
