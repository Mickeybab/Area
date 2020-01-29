// Core
import 'package:flutter/material.dart';

// Widgets
import 'package:area_front/widgets/AreaText.dart';

class AreaTitle extends StatelessWidget {
  const AreaTitle(this.title, {Key key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AreaText(
      this.title,
      fontSize: 70.0,
      fontWeight: FontWeight.w600,
    );
  }
}
