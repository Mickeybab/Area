import 'package:flutter/material.dart';

// Statics
import 'package:area_front/static/Constants.dart';
import 'package:flutter/services.dart';

class AreaTextField extends StatelessWidget {
  const AreaTextField(
      {Key key,
      this.style = Constants.style,
      this.obscureText = false,
      this.hintText = '',
      this.enabledBorderColor = Constants.colorBorder,
      this.focusedBorderColor = Colors.black,
      this.borderWidth = 5.0,
      this.borderRadius = 10.0,
      this.contentPadding = Constants.defaultPadding,
      this.initialValue = '',
      this.keyboardType,
      this.inputFormatters = const <TextInputFormatter>[],
      @required this.onChanged,
      this.validator})
      : super(key: key);

  final TextStyle style;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsetsGeometry contentPadding;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final String hintText;
  final bool obscureText;
  final Function onChanged;
  final Function validator;
  final String initialValue;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: this.obscureText,
      style: style,
      inputFormatters: this.inputFormatters,
      keyboardType: this.keyboardType,
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
      initialValue: this.initialValue,
    );
  }
}
