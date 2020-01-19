// Core
import 'package:area_front/widgets/SearchBar.dart';
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/TopBar.dart';

class Explore extends StatelessWidget {
  const Explore({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Center(
          child: Column(
            children: <Widget>[
              Text("Explore"),
              SearchBar()
            ],
          ),
      ),
    );
  }
}
