// Core
import 'package:area_front/backend/Backend.dart' as B;
import 'package:area_front/models/Service.dart';
import 'package:area_front/static/Constants.dart';
import 'package:area_front/static/backend/BackendRoutes.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/applets/ListApplets.dart';
import 'package:area_front/widgets/utils/Color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:area_front/widgets/GetMore.dart';

import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

// Data
import 'package:provider/provider.dart';

/// `My Applets` Page of the Area Project
class GithubPage extends StatefulWidget {
  GithubPage({Key key, this.data}) : super(key: key);

  final Service data;

  @override
  _GithubPageState createState() => _GithubPageState();
}

class _GithubPageState extends State<GithubPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    onSwitchChangeState(bool newValue) {
      setState(() {
        widget.data.enable = newValue;
      });
    }

    return Scaffold(
      appBar: TopBar(),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                color: hexToColor(this.widget.data.color),
                child: Container(
                  padding: const EdgeInsets.all(36.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                        widget.data.logo,
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(width: 20),
                      AreaTitle(widget.data.service)
                    ]
                  ),
                ),
              ),
              SizedBox(height: 20),
              LiteRollingSwitch(
                value: widget.data.enable,
                textOn: 'On',
                textOff: 'Off',
                colorOn: hexToColor(this.widget.data.color),
                colorOff: Colors.grey[700],
                iconOn: Icons.done,
                iconOff: Icons.remove_circle_outline,
                textSize: 25.0,
                onChanged: (newValue) async {
                  onSwitchChangeState(newValue);
                  if (newValue == true) {
                    print(widget.data.service.toLowerCase().replaceAll(new RegExp(r"\s+\b|\b\s"), ""));
                    B.Backend.post(
                        user,
                        BackendRoutes.activateService(
                          widget.data.service
                          .toLowerCase()
                          .replaceAll(new RegExp(r"\s+\b|\b\s"), "")
                        )
                    );
                    print("SERVICE ACTIVATED");
                  } else {
                    print(widget.data.service.toLowerCase().replaceAll(new RegExp(r"\s+\b|\b\s"), ""));
                    B.Backend.post(
                      user,
                      BackendRoutes.desactivateService(
                        widget.data.service
                        .toLowerCase()
                        .replaceAll(new RegExp(r"\s+\b|\b\s"), "")
                      )
                    );
                    print("SERVICE DESACTIVATED");
                  }
                  //Use it to manage the different states
                  print('Current State of SWITCH IS: $newValue');
                },
              )
            ],
          ),
        ),
       ),
    );
  }
}
