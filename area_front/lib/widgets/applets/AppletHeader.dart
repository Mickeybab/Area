// Core
import 'package:area_front/models/Service.dart';
import 'package:area_front/models/applets/Applet.dart';
import 'package:area_front/widgets/AreaText.dart';
import 'package:area_front/widgets/utils/Color.dart';
import 'package:flutter/material.dart';

class AppletHeader extends StatelessWidget {
  const AppletHeader({Key key, this.applet, this.action, this.reaction});

  final Applet applet;
  final AService action;
  final RService reaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      color: hexToColor(applet.color),
      child: Center(
        child: Container(
          width: (MediaQuery.of(context).size.width / 3) * 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    action.logo,
                    height: 80,
                    width: 80,
                  ),
                  SizedBox(width: 20),
                  Image.network(
                    reaction.logo,
                    height: 80,
                    width: 80,
                  ),
                ]
              ),
              SizedBox(height: 20),
              AreaText(applet.title,
                fontSize: 30,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10),
              AreaText(applet.description,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.start,
              )
            ],
          ),
        ),
      ),
    );
  }
}