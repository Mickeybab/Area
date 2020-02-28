// Core
import 'package:area_front/pages/services/MyServices.dart';
import 'package:area_front/widgets/GetMore.dart';
import 'package:area_front/widgets/applets/ListApplets.dart';
import 'package:area_front/widgets/utils/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:area_front/backend/Backend.dart' as B;


import 'package:area_front/backend/Backend.dart';
import 'package:area_front/models/Service.dart';
import 'package:area_front/static/backend/BackendRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';


// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:area_front/widgets/services/ServiceHeader.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

// Data
import 'package:provider/provider.dart';
/// `My Applets` Page of the Area Project
class EpitechSyncServicePage extends StatefulWidget {
  EpitechSyncServicePage({Key key}) : super(key: key);

  @override
  _EpitechSyncServicePageState createState() => _EpitechSyncServicePageState();
}

class _EpitechSyncServicePageState extends State<EpitechSyncServicePage> {

  FirebaseUser firebaseUser;

  LiteRollingSwitch _switchButton(Service service) {
    return LiteRollingSwitch(
      value: service.enable,
      textOn: 'On',
      textOff: 'Off',
      colorOn: hexToColor(service.color),
      colorOff: Colors.grey[700],
      iconOn: Icons.done,
      iconOff: Icons.remove_circle_outline,
      textSize: 25.0,
      onChanged: (newValue) async {
        if (newValue == true) {
          await B.Backend.post(
            firebaseUser,
            BackendRoutes.activateService(BackendRoutes.intraEpitech)
          );
        } else {
          await B.Backend.post(
            firebaseUser,
            BackendRoutes.desactivateService(BackendRoutes.intraEpitech)
          );
        }
      },
    );
  }

  Column _errorDisplay(String error) {
    return Column(
      children: <Widget>[
        Icon(Icons.error_outline),
        Text(error)
      ],
    );
  }

  _onBackPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyServices(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    this.firebaseUser = user;

    return WillPopScope(
      onWillPop: _onBackPressed,
        child: Scaffold(
        appBar: TopBar(),
        body: Center(
          child: Container(
            child: FutureBuilder(
              future: Request.getService(user, BackendRoutes.intraEpitech),
              builder: (context, snapshot) {
                if (snapshot.hasError == true) {
                  return _errorDisplay(snapshot.error.toString());
                } else if (snapshot.hasData == true) {
                  if (snapshot.data == null)
                    return _errorDisplay('No Data Available');
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ServiceHeader(data: snapshot.data, textColor: Colors.black),
                      SizedBox(height: 20),
                      _switchButton(snapshot.data),
                      SizedBox(height: 20),
                      FutureBuilder(
                        future: Request.getAppletsByService(user, BackendRoutes.intraEpitech),
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
      ),
    );
  }
}
