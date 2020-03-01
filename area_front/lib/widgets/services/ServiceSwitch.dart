// Core
import 'package:area_front/models/Service.dart';
import 'package:area_front/pages/services/EpitechNoSyncService.dart';
import 'package:area_front/pages/services/EpitechSyncService.dart';
import 'package:area_front/pages/services/GithubService.dart';
import 'package:area_front/pages/services/GoogleMailService.dart';
import 'package:area_front/static/backend/BackendRoutes.dart';
import 'package:area_front/widgets/auth/ErrorAuthText.dart';
import 'package:area_front/widgets/utils/Color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:area_front/backend/Backend.dart' as B;

class ServiceSwitch extends StatefulWidget {
  const ServiceSwitch({Key key, this.data, this.user, this.serviceName});

  final Service data;
  final FirebaseUser user;
  final String serviceName;

  @override
  _ServiceSwitchState createState() => _ServiceSwitchState();
}

class _ServiceSwitchState extends State<ServiceSwitch> {

  String _error = '';

  @override
  Widget build(BuildContext context) {
    switch (this.widget.serviceName) {
      case BackendRoutes.github:
        return GithubSwitch(data: this.widget.data);
        break;
      case BackendRoutes.google:
        return GoogleMailSwitch(service: this.widget.data);
        break;
      case BackendRoutes.intraEpitech:
        if (!this.widget.data.sync) {
          return EpitechNoSyncButton();
        } else {
          return EpitechSyncSwitch(service: this.widget.data);
        }
        break;
      default:
        return Container(
          child: Column(
            children: <Widget>[
              LiteRollingSwitch(
                value: widget.data.enable,
                textOn: 'On',
                textOff: 'Off',
                colorOn: hexToColor(widget.data.color),
                colorOff: Colors.grey[700],
                iconOn: Icons.done,
                iconOff: Icons.remove_circle_outline,
                textSize: 25.0,
                onChanged: (newValue) async {
                  if (newValue == true) {
                    try {
                      await B.Backend.post(
                        widget.user,
                        BackendRoutes.activateService(widget.serviceName)
                      );
                    } catch (e) {
                      setState(() => _error = e);
                    }
                  } else {
                    try {
                      await B.Backend.post(
                        widget.user,
                        BackendRoutes.desactivateService(widget.serviceName)
                      );
                    } catch (e) {
                      setState(() => _error = e);
                    }
                  }
                },
              ),
              SizedBox(height: 10),
              ErrorAuth(_error),
              SizedBox(height: 10),
            ],
          ),
        );
    }
  }
}