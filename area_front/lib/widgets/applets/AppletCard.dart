// Core

import 'package:area_front/backend/Backend.dart' as B;
import 'package:area_front/static/backend/BackendRoutes.dart';
import 'package:area_front/widgets/AreaText.dart';
import 'package:area_front/widgets/utils/Color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Models
import 'package:area_front/models/applets/Applet.dart';
import 'package:provider/provider.dart';

class AppletCard extends StatefulWidget {
  const AppletCard(this.data,
      {Key key, this.onPressed})
      : super(key: key);

  final Applet data;
  final Function onPressed;

  @override
  _AppletCardState createState() => _AppletCardState();
}

class _AppletCardState extends State<AppletCard> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    onSwitchChangeState(bool newValue) {
      setState(() {
        widget.data.enable = newValue;
      });
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: hexToColor(
          (widget.data.color == null) ? "xfxfxfxf" : widget.data.color),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: hexToColor(widget.data.color),
        onTap: this.widget.onPressed,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Expanded(
                  child: AreaText(
                    (this.widget.data.title == null)
                        ? ""
                        : this.widget.data.title,
                    fontWeight: FontWeight.w500,
                    fontSize: 25
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 10),
                    Image.network(
                      this.widget.data.action.logo,
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: AreaText(
                        (this.widget.data.action.service == null)
                            ? ""
                            : this.widget.data.action.service[0].toUpperCase() + this.widget.data.action.service.substring(1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Switch(
                      value: widget.data.enable,
                      onChanged: (newValue) async {
                        onSwitchChangeState(newValue);
                        if (newValue == true) {
                          B.Backend.post(
                              user,
                              BackendRoutes.activateApplet(
                                  widget.data.id.toString()));
                        } else {
                          B.Backend.post(
                              user,
                              BackendRoutes.desactivateApplet(
                                  widget.data.id.toString()));
                        }
                      }
                    ),
                    Image.network(
                      this.widget.data.reaction.logo,
                      height: 20,
                      width: 20,
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
