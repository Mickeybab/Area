import 'package:area_front/backend/Navigation.dart';
import 'package:area_front/static/Constants.dart';
import 'package:area_front/static/Routes.dart';
import 'package:area_front/widgets/AreaLargeButton.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:flutter/material.dart';

class GetMore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            SizedBox(height: 100.0),
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
    );
  }
}
