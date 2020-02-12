// Core
import 'package:area_front/backend/Backend.dart';
import 'package:area_front/static/Constants.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/applets/ListApplets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';

// Data
import 'package:area_front/models/applets/Applet.dart';
import 'package:provider/provider.dart';

/// `My Applets` Page of the Area Project
class MyApplets extends StatelessWidget {
  MyApplets({Key key}) : super(key: key);

  List<Applet> _suggestion = [
    Applet(
      title: "Epitech Notification",
      description:
          "Lorsque je reçois une note je veux avoir une notification sur mon portable",
    ),
    Applet(
        title: "Github Notification",
        description:
            "Lorsque quelqu'un push sur un projet je veux avoir une notification sur mon portable"),
    Applet(
        title: "Epitech Notification",
        description:
            "Lorsque je reçois une note je veux avoir une notification sur mon portable"),
    Applet(
        title: "Github Notification",
        description:
            "Lorsque quelqu'un push sur un projet je veux avoir une notification sur mon portable"),
    Applet(
        title: "Epitech Notification",
        description:
            "Lorsque je reçois une note je veux avoir une notification sur mon portable"),
    Applet(
        title: "Github Notification",
        description:
            "Lorsque quelqu'un push sur un projet je veux avoir une notification sur mon portable"),
    Applet(
        title: "Epitech Notification",
        description:
            "Lorsque je reçois une note je veux avoir une notification sur mon portable"),
    Applet(
        title: "Github Notification",
        description:
            "Lorsque quelqu'un push sur un projet je veux avoir une notification sur mon portable"),
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: TopBar(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(36.0),
          width: 900,
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 100 * 8, bottom: 30),
          child: Column(
            children: <Widget>[
              AreaTitle(Constants.myApplets),
              FutureBuilder(
                initialData: _suggestion,
                future: Request.getApplets(user),
                builder: (context, snapshot) {
                  if (snapshot.hasError == true) {
                    return Column(
                      children: <Widget>[
                        Icon(Icons.error_outline),
                        Text(snapshot.error.toString())
                      ],
                    );
                  } else if (snapshot.hasData) {
                    return ListApplet(applets: snapshot.data);
                  } else
                    return CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
