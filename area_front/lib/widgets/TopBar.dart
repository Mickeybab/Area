// Core
import 'package:flutter/material.dart';

// Datas
import 'package:area_front/static/Constants.dart';

// My Widgets
import 'package:area_front/widgets/UserControl.dart';


class TopBar extends StatelessWidget with PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return AppBar(
          title: Text(Constants.title, style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          actions: <Widget>[UserControl()],
        );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}