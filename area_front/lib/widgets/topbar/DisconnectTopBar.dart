// Core
import 'package:flutter/material.dart';

// Datas
import 'package:area_front/static/Constants.dart';
import 'package:area_front/static/Routes.dart';

// My Widgets

class DisconnectTopBar extends StatelessWidget with PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 40, color: Colors.black);

    return AppBar(
      title: Row(
        children: <Widget>[
          Container(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(Routes.wrapper);
              },
              child: Text(Constants.title,
                style: style
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
