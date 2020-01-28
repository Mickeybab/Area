// Core
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textField = TextField(
      decoration: const InputDecoration(
        fillColor: Colors.grey,
        filled: true,
        contentPadding: EdgeInsets.only(left: 15, right: 15),
        enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: const BorderRadius.all(const Radius.circular(30.0))),
        prefixIcon: Icon(Icons.search),
        hintText: 'Search',
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
