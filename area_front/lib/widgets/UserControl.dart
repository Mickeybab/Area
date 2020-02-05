// Core
import 'package:area_front/backend/Navigation.dart';
import 'package:flutter/material.dart';

// Datas
import 'package:area_front/static/Routes.dart';
import 'package:area_front/static/Constants.dart';

class UserControl extends StatelessWidget {
  const UserControl({Key key}) : super(key: key);

  _selected(BuildContext context, String choice) {
    Navigation.navigate(context, choice);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.account_circle,
        color: Colors.grey,
      ),
      onSelected: (String choice) {
        this._selected(context, choice);
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: Routes.wrapper,
            child: Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black))),
              padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Named",
                  ),
                  Spacer(),
                  Icon(
                    Icons.account_circle,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
          PopupMenuItem(
            child: Text(Constants.explore),
            value: Routes.explore,
          ),
          PopupMenuItem(
            child: Text(Constants.myApplets),
            value: Routes.myApplets,
          ),
          PopupMenuItem(
            child: Text(Constants.myServices),
            value: Routes.myServices,
          ),
        ];
      },
    );
  }
}
