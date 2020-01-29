// Core
import 'package:area_front/static/Constants.dart';
import 'package:flutter/material.dart';

// Model

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';

// Random Color
import 'package:random_color/random_color.dart';

// Datas
import 'package:area_front/models/Applets/Applet.dart';

// Pages

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
    const TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.grey);

    final exploreText = Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 100 * 8,
        bottom: 30
      ),
      child: Text(
        'Explore',
        style: Constants.style.copyWith(fontSize: 60, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      )
    );

    return Scaffold(
      appBar: TopBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            exploreText,
            // SearchBar(),
            Container(
              // padding: EdgeInsets.only(20),
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(right: 5),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Color.fromARGB(255, 237, 237, 237), width: 2.0),
                    borderRadius: const BorderRadius.all(const Radius.circular(10.0))
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: const BorderRadius.all(const Radius.circular(10.0))
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.black,),
                  hintText: 'Search',
                  hintStyle: style,
                )
              ),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 25,
                left: 30,
                right: 30,
              ),
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
        List<Widget> line = [buildCard(context, applets[index][0])];
        if (applets[index].length == 2)
          line.add(buildCard(context, applets[index][1]));
        return Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: line,
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
