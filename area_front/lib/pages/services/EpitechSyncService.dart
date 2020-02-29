// Core
import 'package:area_front/pages/services/MyServices.dart';
import 'package:area_front/widgets/GetMore.dart';
import 'package:area_front/widgets/applets/ListApplets.dart';
import 'package:area_front/widgets/auth/ErrorAuthText.dart';
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
/// `EpitechSyncService` Page of the Area Project
class EpitechSyncServicePage extends StatefulWidget {
  EpitechSyncServicePage({Key key}) : super(key: key);

  @override
  _EpitechSyncServicePageState createState() => _EpitechSyncServicePageState();
}

class _EpitechSyncServicePageState extends State<EpitechSyncServicePage> {

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
    final user = Provider.of<FirebaseUser>(context, listen: false);

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
                      EpitechSyncSwitch(service: snapshot.data),
                      SizedBox(height: 10),
                      FutureBuilder(
                        future: Request.getAppletsByService(user, BackendRoutes.intraEpitech),
                        builder: (context, snapshot) {
                          if (snapshot.hasError == true) {
                            return (_errorDisplay(snapshot.error.toString()));
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

class EpitechSyncSwitch extends StatefulWidget {
  const EpitechSyncSwitch({
    @required this.service,
    Key key
  }) : super(key: key);

  final Service service;

  @override
  _EpitechSyncSwitchState createState() => _EpitechSyncSwitchState();
}

class _EpitechSyncSwitchState extends State<EpitechSyncSwitch> {

  String _error = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context, listen: false);

    return Column(
      children: <Widget>[
        LiteRollingSwitch(
          value: widget.service.enable,
          textOn: 'On',
          textOff: 'Off',
          colorOn: hexToColor(widget.service.color),
          colorOff: Colors.grey[700],
          iconOn: Icons.done,
          iconOff: Icons.remove_circle_outline,
          textSize: 25.0,
          onChanged: (newValue) async {
            if (newValue == true) {
              try {
                await B.Backend.post(
                  user,
                  BackendRoutes.activateService(BackendRoutes.intraEpitech)
                );
              } catch (e) {
                setState(() => _error = e);
              }
            } else {
              try {
                await B.Backend.post(
                  user,
                  BackendRoutes.desactivateService(BackendRoutes.intraEpitech)
                );
              } catch (e) {
                setState(() => _error = e);
              }
            }
          },
        ),
        SizedBox(height: 10),
        ErrorAuth(_error),
      ],
    );
  }
}