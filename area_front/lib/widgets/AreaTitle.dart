// Core
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// Widgets
import 'package:area_front/widgets/AreaText.dart';

class AreaTitle extends StatelessWidget {
  const AreaTitle(this.title, {Key key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    double _fontSize = 60;

    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      _fontSize = 30;
    }
    return AreaText(
      this.title,
      fontSize: _fontSize,
      fontWeight: FontWeight.w700,
      textAlign: TextAlign.center,
    );
  }
}
