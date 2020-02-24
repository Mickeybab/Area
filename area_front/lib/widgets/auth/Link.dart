// Core
import 'package:area_front/backend/Navigation.dart';
import 'package:flutter/material.dart';

// Static
import 'package:area_front/static/Routes.dart';

// Widgets
import 'package:area_front/widgets/AreaFlatButton.dart';

// Model

class AreaLink extends StatelessWidget {
  const AreaLink(this.text, {Key key, this.routeName = Routes.home})
      : super(key: key);

  final String routeName;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AreaFlatButton(
        text: this.text,
        onPressed: () {
          Navigation.navigate(context, routeName);
        });
  }
}
