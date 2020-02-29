// Core
import 'package:area_front/pages/services/EpitechNoSyncService.dart';
import 'package:area_front/pages/services/EpitechSyncService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


import 'package:area_front/backend/Backend.dart';
import 'package:area_front/models/Service.dart';
import 'package:area_front/static/backend/BackendRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';


// Data
import 'package:provider/provider.dart';

/// `EpitechService` Page of the Area Project
class EpitechService extends StatefulWidget {
  EpitechService({Key key}) : super(key: key);

  @override
  _EpitechServiceState createState() => _EpitechServiceState();
}

class _EpitechServiceState extends State<EpitechService> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    Service _service;

    Future<bool> _checkServicesSync() async {
      try {
        _service = await Request.getService(user, BackendRoutes.intraEpitech);
        if (!_service.sync)
          return false;
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    }

    return Center(
      child: Container(
        child: FutureBuilder<bool>(
          future: _checkServicesSync(),
          builder: (context, snapshot) {
            if (snapshot.hasError == true) {
              return Column(
                children: <Widget>[
                  Icon(Icons.error_outline),
                  Text(snapshot.error.toString())
                ],
              );
            } else if (snapshot.hasData == true) {
              if (snapshot.data == true) {
                return EpitechSyncServicePage();
              } else {
                return EpitechNoSyncServicePage();
              }
            } else
              return CircularProgressIndicator();
          }
        ),
      ),
    );
  }
}
