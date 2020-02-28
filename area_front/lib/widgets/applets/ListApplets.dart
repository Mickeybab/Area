// Core
import 'package:area_front/pages/Applet.dart';
import 'package:flutter/material.dart';

// Modals
import 'package:area_front/models/applets/Applet.dart';

// Widgets
import 'package:area_front/widgets/applets/AppletCard.dart';

class ListApplet extends StatelessWidget {
  const ListApplet({Key key, @required this.applets}) : super(key: key);

  final List<Applet> applets;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 900,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (MediaQuery.of(context).size.width / 800).round() != 0 ? (MediaQuery.of(context).size.width / 800).round() : 1,
              childAspectRatio: 1.6,
          ),
          itemCount: applets.length,
          padding: EdgeInsets.all(20.0),
          itemBuilder: (BuildContext context, int index) {
              return AppletCard(
                applets[index],
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
        ),
      )
    );
  }
}
