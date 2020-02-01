import 'package:flutter/material.dart';

// Statics
import 'package:area_front/static/Constants.dart';

class AreaTextField extends StatelessWidget {
  const AreaTextField(
      {Key key,
      this.obscureText = false,
      this.hintText = '',
      this.enabledBorderColor = Constants.colorBorder,
      this.focusedBorderColor = const Color.fromARGB(255, 0, 0, 0),
      this.borderWidth = 5.0,
      this.borderRadius = 10.0,
      this.contentPadding = Constants.defaultPadding,
      @required this.onChanged,
      @required this.validator})
      : super(key: key);

  final double borderRadius;
  final double borderWidth;
  final EdgeInsetsGeometry contentPadding;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final String hintText;
  final bool obscureText;
  final Function onChanged;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: this.obscureText,
      style: Constants.style,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: this.enabledBorderColor, width: this.borderWidth),
            borderRadius: BorderRadius.circular(this.borderRadius)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: this.focusedBorderColor, width: this.borderWidth),
            borderRadius: BorderRadius.circular(this.borderRadius)),
        contentPadding: this.contentPadding,
        hintText: this.hintText,
      ),
      validator: this.validator,
      onChanged: this.onChanged,
    );
  }
}
