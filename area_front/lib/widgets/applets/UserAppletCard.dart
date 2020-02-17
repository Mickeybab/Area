// Core
import 'package:area_front/widgets/AreaText.dart';
import 'package:area_front/widgets/applets/AppletActionPreview.dart';
import 'package:area_front/widgets/applets/AppletReactionPreview.dart';
import 'package:flutter/material.dart';
// Models
import 'package:area_front/models/applets/Applet.dart';

class UserAppletCard extends StatelessWidget {
  const UserAppletCard(this.data,
      {Key key, this.onPressed, this.color, this.splashColor})
      : super(key: key);

  final Color color;
  final Applet data;
  final Function onPressed;
  final Color splashColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: this.color,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: this.splashColor,
        onTap: this.onPressed,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AreaText(this.data.description, fontSize: 18, fontWeight: FontWeight.w500),
              SizedBox(height: 40),
              AppletActionPreview(name: this.data.title, icon: Icon(Icons.wifi)),
              SizedBox(height: 5),
              AppletReactionPreview(icon: Icon(Icons.widgets))
            ]
          ),
        ),
      ),
    );
  }
}
