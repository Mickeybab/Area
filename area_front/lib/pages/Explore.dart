// Core
import 'package:area_front/backend/Backend.dart';
import 'package:area_front/models/Service.dart';
import 'package:area_front/models/applets/Params.dart';
import 'package:area_front/widgets/applets/ListApplets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:area_front/static/Constants.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/LargeSearchBar.dart';

// Datas
import 'package:area_front/models/applets/Applet.dart';
import 'package:provider/provider.dart';

/// `Explores` Page of the Area Project
class Explore extends StatefulWidget {
  Explore({Key key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<Applet> _suggestion = [
    Applet(
        title: "Epitech",
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
    final user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: TopBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 100 * 8, bottom: 30),
            child: AreaTitle(Constants.explore),
          ),
          LargeSearchBar(autofocus: true),
          FutureBuilder(
            future: Request.getApplets(user),
            initialData: _suggestion,
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
    );
  }
}
