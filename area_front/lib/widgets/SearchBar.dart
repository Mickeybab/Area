// Core
import 'package:area_front/static/Constants.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController();

  String searchKey = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
      color: Colors.black
    );

    const textField = TextField(
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.only(right: 5),
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 0.0),
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black, width: Constants.defaultWidthBorder),
            borderRadius: const BorderRadius.all(const Radius.circular(10.0))),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black,
        ),
        hintText: 'Search',
        hintStyle: style,
      ),
    );

    const expand = Expanded(child: textField);

    var container = Container(
        margin:
            EdgeInsets.only(left: MediaQuery.of(context).size.width / 100 * 1),
        width: MediaQuery.of(context).size.width / 5,
        height: 30.0,
        child: textField);

    return (MediaQuery.of(context).size.width > 700) ? container : expand;
  }
}
