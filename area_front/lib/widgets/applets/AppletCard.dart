// Core

import 'package:area_front/backend/Backend.dart' as B;
import 'package:area_front/static/backend/BackendRoutes.dart';
import 'package:area_front/widgets/AreaText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Models
import 'package:area_front/models/applets/Applet.dart';
import 'package:provider/provider.dart';

class AppletCard extends StatefulWidget {
  const AppletCard(this.data,
      {Key key, this.onPressed, this.color, this.splashColor})
      : super(key: key);

  final Color color;
  final Applet data;
  final Function onPressed;
  final Color splashColor;

  @override
  _AppletCardState createState() => _AppletCardState();
}

class _AppletCardState extends State<AppletCard> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    bool value = false;

    onSwitchChangeState(bool newValue) {
      setState(() {
        value = newValue;
      });
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: this.widget.color,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: this.widget.splashColor,
        onTap: this.widget.onPressed,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AreaText(this.widget.data.description,
                    fontSize: 18, fontWeight: FontWeight.w500),
                SizedBox(height: 10),
                AreaText(this.widget.data.title,
                    fontWeight: FontWeight.w500, fontSize: 15),
                SizedBox(height: 10),
                Switch(
                    value: value,
                    onChanged: (newValue) async {
                      onSwitchChangeState(newValue);
                      if (newValue == true) {
                        B.Backend.post(
                            user, BackendRoutes.activateApplet(widget.data.id.toString()));
                        print("APPLET ACTIVATED");
                      } else {
                        B.Backend.post(user,
                            BackendRoutes.desactivateApplet(widget.data.id.toString()));
                        print("APPLET DESACTIVATED");
                      }
                    }),
              ]),
        ),
      ),
    );
  }
}
