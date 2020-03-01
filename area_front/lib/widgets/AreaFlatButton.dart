// Core
import 'package:flutter/material.dart';

// Datas
import 'package:area_front/static/Constants.dart';

class AreaFlatButton extends StatelessWidget {
  const AreaFlatButton(
      {Key key,
      this.text = '',
      this.color,
      this.fontWeight = FontWeight.w600,
      this.fontSize = 15.0,
      this.textDecoration = TextDecoration.underline,
      @required this.onPressed})
      : super(key: key);

  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final Function onPressed;
  final String text;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        this.text,
        style: Constants.style.copyWith(
          decoration: TextDecoration.underline,
          fontSize: this.fontSize,
          fontWeight: this.fontWeight,
          color: this.color,
        ),
      ),
      onPressed: this.onPressed,
    );
  }
}
