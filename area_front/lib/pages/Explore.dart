// Core
import 'package:flutter/material.dart';

// Model
import 'package:area_front/models/User.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:provider/provider.dart';

// Random Color
import 'package:random_color/random_color.dart';

// Datas
import 'package:area_front/backend/Applets/Applet.dart';

// Pages
import 'package:area_front/pages/auth/Authenticate.dart';

class Explore extends StatelessWidget {
  final List<List<Applet>> _suggestion = const [
    [
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
    ],
    [
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
    ],
    [
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
    ],
    [
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
    ],
    [
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
    ],
    [
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
    ],
    [
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
    ],
    [
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
    ],
    [
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
    ],
    [
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
    ],
    [
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
    ],
    [
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
    ],
    [
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
    ],
    [
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
    ],
    [
      const Applet(
          name: "Epitech mail",
          services: ["Epitech", "Mail"],
          description: "Lorsque je reçois une note je veux avoir un mail"),
      const Applet(
          name: "Weather Notification",
          services: ["Weather", "Notification"],
          description:
              "Lorsqu'il fait trop froid je veux avoir une notification sur mon portable"),
    ]
  ];

  const Explore({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return AuthPage();
    }
    return Scaffold(
      appBar: TopBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 100 * 8,
                    bottom: 30),
                child: Text(
                  "Explore",
                  style: TextStyle(fontSize: 50),
                )),
            // SearchBar(),
            Container(
              child: TextField(
                  decoration: const InputDecoration(
                fillColor: Colors.grey,
                filled: true,
                enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(30.0))),
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
              )),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 25),
            ),
            ListAppletSugestion(
              applets: _suggestion,
            )
          ],
        ),
      ),
    );
  }
}

class ListAppletSugestion extends StatelessWidget {
  final List<List<Applet>> applets;
  static final RandomColor _randomColor = RandomColor();

  const ListAppletSugestion({Key key, this.applets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: applets.length,
      itemBuilder: (context, index) {
        return Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            buildCard(context, applets[index][0]),
            buildCard(context, applets[index][1]),
          ],
        ));
      },
    ));
  }

  Column buildCard(BuildContext context, Applet applet) {
    final mobile = MediaQuery.of(context).size.width < 600;
    final height = (mobile) ? MediaQuery.of(context).size.width / 4 : 100;
    return Column(children: [
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color:
            _randomColor.randomColor(colorBrightness: ColorBrightness.primary),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: _randomColor.randomColor(
              colorBrightness: ColorBrightness.primary),
          onTap: () {
            print('Card tapped.');
          },
          child: Container(
            height: height,
            width: MediaQuery.of(context).size.width / 2 -
                MediaQuery.of(context).size.width / 25,
            child: ListTile(
              leading: (mobile) ? null : Icon(Icons.access_time),
              title: Text(applet.name),
              subtitle: Text(applet.description),
            ),
          ),
        ),
      )
    ]);
  }
}
