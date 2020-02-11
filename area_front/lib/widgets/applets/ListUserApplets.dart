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
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (MediaQuery.of(context).size.width / 800).round(),
          childAspectRatio: 1.6,
        ),
        itemCount: applets.length,
        padding: EdgeInsets.all(20.0),
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
              print('Card pressed');
            },
          );
        },
      )
    );
  }
}
