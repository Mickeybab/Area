import 'package:area_front/widgets/AreaText.dart';
import 'package:flutter/material.dart';

class AppletActionPreview extends StatelessWidget {
  const AppletActionPreview({this.name, this.icon});

  final String name;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        icon,
        SizedBox(width: 10),
        AreaText(name, fontWeight: FontWeight.w500, fontSize: 15),
      ],
    );
  }
}
