// Core
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/utils/Color.dart';

import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

// Data

/// `My Applets` Page of the Area Project
class GithubPage extends StatelessWidget {
  GithubPage({Key key, this.service, this.logo, this.color}) : super(key: key);

  final String service;
  final String color;
  final String logo;

  @override
  Widget build(BuildContext context) {
    print(color);
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
                color: hexToColor(this.color),
                child: Container(
                  padding: const EdgeInsets.all(36.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                        logo,
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(width: 20),
                      AreaTitle(service)
                    ]
                  ),
                ),
              ),
              SizedBox(height: 20),
              LiteRollingSwitch(
                value: true,
                textOn: 'ON',
                textOff: 'OFF',
                colorOn: hexToColor(this.color),
                colorOff: Colors.grey[700],
                iconOn: Icons.done,
                iconOff: Icons.remove_circle_outline,
                textSize: 25.0,
                onChanged: (bool state) async {
                  //Use it to manage the different states
                  print('Current State of SWITCH IS: $state');
                },
              )
            ],
          ),
        ),
       ),
    );
  }
}
