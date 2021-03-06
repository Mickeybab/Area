import 'package:flutter/material.dart';

class AreaText extends StatelessWidget {
  const AreaText(this.data,
      {Key key,
      this.fontFamily = 'Montserrat',
      this.fontSize = 25.0,
      this.fontWeight,
      this.textAlign = TextAlign.left,
      this.color = Colors.black})
      : super(key: key);

  final String data;
  final String fontFamily;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      this.data,
      style: TextStyle(
        fontFamily: this.fontFamily,
        fontSize: this.fontSize,
        color: this.color,
        fontWeight: this.fontWeight,
      ),
      textAlign: this.textAlign,
    );
  }
}
