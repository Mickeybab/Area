// Core
import 'package:area_front/services/Auth.dart';
import 'package:flutter/material.dart';

// Datas
import 'package:area_front/static/Constants.dart';
import 'package:area_front/static/Routes.dart';

// My Widgets
import 'package:area_front/widgets/UserControl.dart';
import 'package:area_front/widgets/SearchBar.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

  final signOutButon = IconButton(
    icon: Icon(Icons.exit_to_app, color: Colors.black,),
    onPressed: () async {
      await _auth.signOut();
    },
  );

    return AppBar(
      title: Row(
        children: <Widget>[
          Container(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(Routes.wrapper);
              },
              child: Text(Constants.title,
                style: TextStyle(color: Colors.black, fontSize: 40)),
            ),
          ),
          SearchBar(),
          signOutButon
        ],
      ),
      backgroundColor: Colors.white,
      actions: <Widget>[UserControl()],
      // signOutButon
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
