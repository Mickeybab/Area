// Core
import 'package:area_front/models/Service.dart';
import 'package:area_front/models/applets/Params.dart';
import 'package:area_front/widgets/applets/ListApplets.dart';
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:area_front/static/Constants.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/LargeSearchBar.dart';

// Datas
import 'package:area_front/models/applets/Applet.dart';

/// `Explores` Page of the Area Project
class Explore extends StatelessWidget {
  Explore({Key key}) : super(key: key);

  List<Applet> _suggestion = [
    Applet(
        title: "Epitech Notification",
        description:
            "Lorsque je reçois une note je veux avoir une notification sur mon portable",
        action: Service(
            action: 'Service1 action',
            logo: 'logo1',
            param: [
              Param(name: 'param11', paramType: 'string', value: 'SuperValue'),
              Param(name: 'param12', paramType: 'int', value: '42'),
            ],
            service: "Service2"),
        reaction: Service(
            action: 'Service2 action',
            logo: 'logo2',
            param: [
              Param(name: 'param21', paramType: 'string', value: 'SuperValue'),
              Param(name: 'param21', paramType: 'int', value: '42'),
            ],
            service: "Service2")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 100 * 8,
                  bottom: 30),
              child: AreaTitle(Constants.explore),
            ),
            LargeSearchBar(),
            ListApplet(
              applets: _suggestion,
            )
          ],
        ),
      ),
    );
  }
}
