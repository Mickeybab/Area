import 'package:area_front/static/Constants.dart';
import 'package:flutter/material.dart';

// Widgets
import 'package:area_front/widgets/AreaText.dart';

class AreaLargeButton extends StatelessWidget {
  const AreaLargeButton(
      {Key key, this.onPressed, this.text = '', this.color = Colors.white})
      : super(key: key);

  final Function onPressed;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(35.0),
      color: Colors.black,
      child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: Constants.defaultPadding,
          onPressed: this.onPressed,
          child:
              AreaText(this.text, textAlign: TextAlign.center, color: color)),
    );
  }
}
