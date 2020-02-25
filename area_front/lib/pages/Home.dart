// Core
import 'package:area_front/widgets/GetMore.dart';
import 'package:flutter/material.dart';

// Constants

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';

// Datas

/// `Home` Page of the Area Project
class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(),
        body: Center(
          child: GetMore(),
        ));
  }
}
