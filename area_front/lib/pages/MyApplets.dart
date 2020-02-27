// Core
import 'package:area_front/backend/Backend.dart';
import 'package:area_front/static/Constants.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/applets/ListApplets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:area_front/widgets/GetMore.dart';

import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';

// Data
import 'package:provider/provider.dart';

/// `My Applets` Page of the Area Project
class MyApplets extends StatelessWidget {
  MyApplets({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      appBar: TopBar(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(36.0),
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 100 * 8, bottom: 30),
          child: Column(
            children: <Widget>[
              AreaTitle(Constants.myApplets),
              FutureBuilder(
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
                    if (snapshot.data != null) {
                      return ListApplet(applets: snapshot.data);
                    } else {
                      return GetMore();
                    }
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
