// Core
import 'package:area_front/backend/Navigation.dart';
import 'package:area_front/widgets/AreaLargeButton.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:flutter/material.dart';

// Constants
import 'package:area_front/static/Constants.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';

// Datas
import 'package:area_front/static/Routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  AreaTitle(Constants.connectYourWorld),
                  SizedBox(height: 50.0),
                  Image.asset(
                    'assets/images/3.0x/services.png',
                    width: 600,
                  ),
                  SizedBox(height: 200.0),
                  Container(
                      width: 300,
                      child: AreaLargeButton(
                        text: Constants.getMore,
                        onPressed: () {
                          Navigation.navigate(context, Routes.explore);
                        },
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
