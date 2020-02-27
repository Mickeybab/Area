// Core
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


import 'package:area_front/backend/Backend.dart';
import 'package:area_front/models/Service.dart';
import 'package:area_front/static/backend/BackendRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';


// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:area_front/widgets/service/ServiceHeader.dart';
import 'package:area_front/widgets/service/ServiceSwitch.dart';
import 'package:area_front/widgets/AreaTitle.dart';

// Data
import 'package:provider/provider.dart';
/// `My Applets` Page of the Area Project
class GoogleMailServicePage extends StatefulWidget {
  GoogleMailServicePage({Key key}) : super(key: key);

  @override
  _GoogleMailServicePageState createState() => _GoogleMailServicePageState();
}

class _GoogleMailServicePageState extends State<GoogleMailServicePage> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return Scaffold(
        appBar: TopBar(),
        body: Center(
            child: Container(
                child: FutureBuilder(
                    future: Request.getService(user, BackendRoutes.googlemail),
                    builder: (context, snapshot) {
                      Service data;
                      if (snapshot.hasError == true) {
                        return Column(
                          children: <Widget>[
                            Icon(Icons.error_outline),
                            Text(snapshot.error.toString())
                          ],
                        );
                      } else if (snapshot.hasData == true) {
                        data = snapshot.data;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ServiceHeader(data: data),
                            SizedBox(height: 20),
                            ServiceSwitch(
                              data: data,
                              user: user,
                              serviceName: BackendRoutes.googlemail
                            ),
                            AreaTitle('Test')
                          ],
                        );
                      } else
                        return CircularProgressIndicator();
                    }
                )
            )
        )
    );
  }
}
