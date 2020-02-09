// Core
import 'package:area_front/pages/Applet.dart';
import 'package:flutter/material.dart';

// Modals
import 'package:area_front/models/applets/Applet.dart';

// Widgets
import 'package:area_front/widgets/applets/AppletCard.dart';

// Misc
import 'package:random_color/random_color.dart';

class ListApplet extends StatelessWidget {
  const ListApplet({Key key, @required this.applets}) : super(key: key);

  final List<Applet> applets;

  static final RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (MediaQuery.of(context).size.width / 600).round(),
        childAspectRatio: 3.0,
      ),
      itemCount: applets.length,
      padding: EdgeInsets.all(8.0),
      itemBuilder: (BuildContext context, int index) {
        return AppletCard(
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
    ));
  }
}
