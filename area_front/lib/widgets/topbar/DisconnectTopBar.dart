// Core
import 'package:area_front/backend/Navigation.dart';
import 'package:flutter/material.dart';

// Datas
import 'package:area_front/static/Constants.dart';
import 'package:area_front/static/Routes.dart';

// My Widgets

class DisconnectTopBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      title: Row(
        children: <Widget>[
          Container(
            child: GestureDetector(
              onTap: () {
                Navigation.navigate(context, Routes.home);
              },
              child: Text(Constants.title,
                  style: Constants.style
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 40)),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
