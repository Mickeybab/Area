// Core
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/topbar/TopBar.dart';

// Static
import 'package:area_front/static/Constants.dart';

class MyServices extends StatelessWidget {
  const MyServices({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Column(
        children: <Widget>[AreaTitle(Constants.myServices)],
      ),
    );
  }
}
