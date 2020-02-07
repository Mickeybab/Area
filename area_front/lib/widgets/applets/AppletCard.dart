// Core
import 'package:flutter/material.dart';

// Models
import 'package:area_front/models/applets/Applet.dart';

class AppletCard extends StatelessWidget {
  const AppletCard(this.data,
      {Key key, this.onPressed, this.color, this.splashColor})
      : super(key: key);

  final Color color;
  final Applet data;
  final Function onPressed;
  final Color splashColor;

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.of(context).size.width < 600;
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
          child: ListTile(
            leading: (mobile) ? null : Icon(Icons.access_time),
            title: Text(this.data.title),
            subtitle: Text(this.data.description),
          ),
        ),
      ),
    );
  }
}
