// Core
import 'package:area_front/widgets/applets/ListApplets.dart';
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:area_front/static/Constants.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/LargeSearchBar.dart';

// Datas
import 'package:area_front/models/applets/Applet.dart';


class Explore extends StatelessWidget {
  const Explore({Key key}) : super(key: key);

  final List<Applet> _suggestion = const [
    const Applet(
        name: "Epitech Notification",
        services: ["Epitech", "Notification"],
        description:
            "Lorsque je reçois une note je veux avoir une notification sur mon portable"),
    const Applet(
        name: "Github Notification",
        services: ["Github", "Notification"],
        description:
            "Lorsque quelqu'un push sur un projet je veux avoir une notification sur mon portable"),
    const Applet(
        name: "Epitech Notification",
        services: ["Epitech", "Notification"],
        description:
            "Lorsque je reçois une note je veux avoir une notification sur mon portable"),
    const Applet(
        name: "Github Notification",
        services: ["Github", "Notification"],
        description:
            "Lorsque quelqu'un push sur un projet je veux avoir une notification sur mon portable"),
    const Applet(
        name: "Epitech Notification",
        services: ["Epitech", "Notification"],
        description:
            "Lorsque je reçois une note je veux avoir une notification sur mon portable"),
    const Applet(
        name: "Github Notification",
        services: ["Github", "Notification"],
        description:
            "Lorsque quelqu'un push sur un projet je veux avoir une notification sur mon portable"),
    const Applet(
        name: "Epitech Notification",
        services: ["Epitech", "Notification"],
        description:
            "Lorsque je reçois une note je veux avoir une notification sur mon portable"),
    const Applet(
        name: "Github Notification",
        services: ["Github", "Notification"],
        description:
            "Lorsque quelqu'un push sur un projet je veux avoir une notification sur mon portable"),
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
