// Core
import 'package:flutter/material.dart';

// Static
import 'package:area_front/static/Constants.dart';

class LargeSearchBar extends StatelessWidget {
  const LargeSearchBar({Key key, this.autofocus = false}) : super(key: key);

  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
          autofocus: this.autofocus,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(right: 5),
            enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Constants.colorBorder,
                    width: Constants.defaultWidthBorder),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(10.0))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black, width: Constants.defaultWidthBorder),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(10.0))),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            hintText: Constants.hintSearchBar,
            hintStyle: const TextStyle(
                fontFamily: Constants.fontFamily,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey),
          )),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height / 25,
        left: 30,
        right: 30,
      ),
    );
  }
}
