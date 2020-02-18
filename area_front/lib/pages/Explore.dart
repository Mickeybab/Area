// Core
import 'package:area_front/backend/Backend.dart';
import 'package:area_front/widgets/applets/ListApplets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:area_front/static/Constants.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/LargeSearchBar.dart';

// Datas
import 'package:provider/provider.dart';

/// `Explores` Page of the Area Project
class Explore extends StatelessWidget {
  Explore({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: TopBar(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(36.0),
          width: 900,
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 100 * 8, bottom: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AreaTitle(Constants.explore),
              SizedBox(height: 25),
              LargeSearchBar(autofocus: true),
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
