// Core
import 'package:area_front/widgets/GetMore.dart';
import 'package:area_front/widgets/applets/ListApplets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


import 'package:area_front/backend/Backend.dart';
import 'package:area_front/models/Service.dart';
import 'package:area_front/static/backend/BackendRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';


// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:area_front/widgets/services/ServiceHeader.dart';
import 'package:area_front/widgets/services/ServiceSwitch.dart';

// Data
import 'package:provider/provider.dart';
/// `CurrencyServicePage` Page of the Area Project
class CurrencyServicePage extends StatefulWidget {
  CurrencyServicePage({Key key}) : super(key: key);

  @override
  _CurrencyServicePageState createState() => _CurrencyServicePageState();
}

class _CurrencyServicePageState extends State<CurrencyServicePage> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return Scaffold(
        appBar: TopBar(),
        body: Center(
            child: Container(
                child: FutureBuilder(
                    future: Request.getService(user, BackendRoutes.currency),
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
                            ServiceHeader(data: data, textColor: Colors.white),
                            SizedBox(height: 20),
                            ServiceSwitch(
                              data: data,
                              user: user,
                              serviceName: BackendRoutes.currency
                            ),
                            FutureBuilder(
                              future: Request.getAppletsByService(user, BackendRoutes.currency),
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
