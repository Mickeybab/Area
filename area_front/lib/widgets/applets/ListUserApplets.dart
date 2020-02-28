// Core
import 'package:area_front/pages/Applet.dart';
import 'package:flutter/material.dart';

// Modals
import 'package:area_front/models/applets/Applet.dart';

// Widgets
import 'package:area_front/widgets/applets/UserAppletCard.dart';

// Misc
import 'package:random_color/random_color.dart';

class ListUserApplet extends StatelessWidget {
  const ListUserApplet({Key key, @required this.applets}) : super(key: key);

  final List<Applet> applets;
  static final RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      itemCount: applets.length,
      itemBuilder: (BuildContext context, int index) {
        return UserAppletCard(
          applets[index],
          splashColor: _randomColor.randomColor(
              colorBrightness: ColorBrightness.primary),
          color: _randomColor.randomColor(
              colorBrightness: ColorBrightness.primary),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppletsDetailsPage(applets[index]),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
    ));
  }
}
