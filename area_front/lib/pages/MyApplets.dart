// Core
import 'package:area_front/models/applets/Params.dart';
import 'package:area_front/static/Constants.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/GetMore.dart';
import 'package:area_front/widgets/applets/ListUserApplets.dart';
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';

// Data
import 'package:area_front/models/applets/Applet.dart';

/// `My Applets` Page of the Area Project
class MyApplets extends StatelessWidget {
  MyApplets({Key key}) : super(key: key);

  final List<Applet> _suggestion = const [
    const Applet(
        title: "Epitech Notification",
        description:
            "Lorsque je reçois une note je veux avoir une notification sur mon portable",
        params: [ AppletParam(name: 'toto', category: 'reaction', type: 'string', value: 'tutu')]),
    const Applet(
        title: "Github Notification",
        description:
            "Lorsque quelqu'un push sur un projet je veux avoir une notification sur mon portable"),
    const Applet(
        title: "Epitech Notification",
        description:
            "Lorsque je reçois une note je veux avoir une notification sur mon portable"),
    const Applet(
        title: "Github Notification",
        description:
            "Lorsque quelqu'un push sur un projet je veux avoir une notification sur mon portable"),
    const Applet(
        title: "Epitech Notification",
        description:
            "Lorsque je reçois une note je veux avoir une notification sur mon portable"),
    const Applet(
        title: "Github Notification",
        description:
            "Lorsque quelqu'un push sur un projet je veux avoir une notification sur mon portable"),
    const Applet(
        title: "Epitech Notification",
        description:
            "Lorsque je reçois une note je veux avoir une notification sur mon portable"),
    const Applet(
        title: "Github Notification",
        description:
            "Lorsque quelqu'un push sur un projet je veux avoir une notification sur mon portable"),
  ];

  @override
  Widget build(BuildContext context) {
    if (_suggestion.isNotEmpty) {
      return Scaffold(
        appBar: TopBar(),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(36.0),
            width: 600,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 100 * 8,
              bottom: 30
            ),
            child: Column(
              children: <Widget>[
                AreaTitle(Constants.myApplets),
                ListUserApplet(
                  applets: _suggestion,
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: TopBar(),
        body: Center(
          child: GetMore()
        )
      );
    }
  }
}
