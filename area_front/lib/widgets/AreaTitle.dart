// Core
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

// Widgets
import 'package:area_front/widgets/AreaText.dart';

class AreaTitle extends StatelessWidget {
  const AreaTitle(this.title, {Key key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    double _fontSize;

    if (Platform.isAndroid || Platform.isIOS) {
      _fontSize = 30;
    } else {
      _fontSize = 60;
    }
    return AreaText(
      this.title,
      fontSize: _fontSize,
      fontWeight: FontWeight.w600,
      textAlign: TextAlign.center,
    );
  }
}
