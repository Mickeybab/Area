// Core
import 'package:area_front/backend/Navigation.dart';
import 'package:flutter/material.dart';

// Services
import 'package:area_front/services/Auth.dart';

// Datas
import 'package:area_front/static/Constants.dart';
import 'package:area_front/static/Routes.dart';

// My Widgets
import 'package:area_front/widgets/UserControl.dart';
import 'package:area_front/widgets/SearchBar.dart';

class ConnectTopBar extends StatelessWidget with PreferredSizeWidget {
  final AuthService _auth = AuthService();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final signOutButon = IconButton(
      icon: Icon(
        Icons.exit_to_app,
        color: Colors.black,
      ),
      onPressed: () async {
        await _auth.signOut();
      },
    );

    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 1,
      title: Row(
        children: <Widget>[
          Container(
            child: GestureDetector(
              onTap: () {
                Navigation.navigate(context, Routes.wrapper);
              },
              child: Text(Constants.title,
                  style: Constants.style
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 40)),
            ),
          ),
          SizedBox(width: 10.0),
          SearchBar(),
        ],
      ),
      backgroundColor: Colors.white,
      actions: <Widget>[UserControl(), signOutButon],
    );
  }
}
