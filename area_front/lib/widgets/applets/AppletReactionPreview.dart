import 'package:flutter/material.dart';

class AppletReactionPreview extends StatefulWidget {
  const AppletReactionPreview({this.icon});

  final Icon icon;

  @override
  _AppletReactionPreviewState createState() => _AppletReactionPreviewState();
}

class _AppletReactionPreviewState extends State<AppletReactionPreview> {
  @override
  Widget build(BuildContext context) {
    bool value = false;

    onSwitchChangeState(bool newValue) {
      setState(() {
        value = newValue;
      });
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Switch(
            value: value,
            onChanged: (newValue) {
              if (newValue == true) {
                // user.client.post(BackendRoutes.activateApplet(widget.data.id));
                onSwitchChangeState(newValue);
              } else {
                // user.client.post(BackendRoutes.desactivateApplet(widget.data.id));
                onSwitchChangeState(newValue);
              }
            }),
        widget.icon
      ],
    );
  }
}
