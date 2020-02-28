// Core
import 'package:area_front/models/Service.dart';
import 'package:area_front/static/backend/BackendRoutes.dart';
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

  @override
  Widget build(BuildContext context) {
    return LiteRollingSwitch(
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
          await B.Backend.post(
            widget.user,
            BackendRoutes.activateService(widget.serviceName)
          );
        } else {
          B.Backend.post(
            widget.user,
            BackendRoutes.desactivateService(widget.serviceName)
          );
        }
      },
    );
  }
}