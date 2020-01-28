// Core
import 'package:flutter/material.dart';

// Datas
import 'package:area_front/static/Constants.dart';
import 'package:area_front/static/Routes.dart';

// My Widgets
import 'package:area_front/widgets/UserControl.dart';
import 'package:area_front/widgets/SearchBar.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: <Widget>[
          Text(Constants.title,
              style: TextStyle(color: Colors.black, fontSize: 40)),
          Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 100 * 1),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(Routes.home);
                },
                child: Text("Home",
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              )),
          SearchBar()
        ],
      ),
      backgroundColor: Colors.white,
      actions: <Widget>[UserControl()],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
