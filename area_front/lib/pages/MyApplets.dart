// Core
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';


/// `My Applets` Page of the Area Project
class MyApplets extends StatelessWidget {
  const MyApplets({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Center(
          child: Text("Mes Applets"),
      ),
    );
  }
}
