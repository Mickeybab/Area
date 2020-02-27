// Core
import 'package:area_front/backend/Backend.dart';
import 'package:area_front/widgets/AreaText.dart';
import 'package:area_front/widgets/GetMore.dart';
import 'package:area_front/widgets/services/ListServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/topbar/TopBar.dart';

// Static
import 'package:area_front/static/Constants.dart';

//Data
import 'package:provider/provider.dart';

/// `My Services` Pages of the Area Project
class MyServices extends StatelessWidget {
  const MyServices({Key key}) : super(key: key);

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
              AreaTitle(Constants.myServices),
              FutureBuilder(
                future: Request.getServices(user),
                builder: (context, snapshot) {
                  if (snapshot.hasError == true) {
                    return Column(
                      children: <Widget>[
                        Icon(Icons.error_outline),
                        Expanded(child: AreaText(snapshot.error.toString()))
                      ],
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return ListServices(services: snapshot.data);
                    } else {
                      return GetMore();
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
