// Core

import 'package:area_front/backend/Backend.dart' as B;
import 'package:area_front/models/Service.dart';
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
    final user = Provider.of<FirebaseUser>(context, listen: false);

    Service _aService;
    Service _rService;

    Future<bool> _checkServicesEnable() async {
      try {
        _aService = await B.Request.getService(user, widget.data.action.service);
        _rService = await B.Request.getService(user, widget.data.reaction.service);
        if (!_aService.enable || !_rService.enable) {
          return false;
        }
        return true;
      } catch (e) {
        print(e);
        return false;
      }
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
                    fontWeight: FontWeight.w600,
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
                            : this.widget.data.action.service[0]
                            .toUpperCase() +
                            this.widget.data.action.service.substring(1),
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                FutureBuilder<bool>(
                  future: _checkServicesEnable(),
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
                        return ActivedCardBottom(card: this.widget);
                      } else {
                        return DesactivatedCardBottom(card: this.widget);
                      }
                    } else
                      return CircularProgressIndicator();
                  }
                )
              ]),
        ),
      ),
    );
  }
}

class ActivedCardBottom extends StatefulWidget {
  ActivedCardBottom({
    Key key,
    @required this.card
    }) : super(key: key);

  final AppletCard card;

  @override
  _ActivedCardBottomState createState() => _ActivedCardBottomState();
}

class _ActivedCardBottomState extends State<ActivedCardBottom> {

  onSwitchChangeState(bool newValue) {
    setState(() {
      this.widget.card.data.enable = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Switch(
          value: widget.card.data.enable,
          onChanged: (newValue) async {
            onSwitchChangeState(newValue);
            if (newValue == true) {
              try {
                await B.Backend.post(
                    user,
                    BackendRoutes.activateApplet(
                        widget.card.data.id.toString()));
              } catch (e) {
                print(e);
              }
            } else {
              try {
                await B.Backend.post(
                    user,
                    BackendRoutes.desactivateApplet(
                        widget.card.data.id.toString()));
              } catch (e) {
                print(e);
              }
            }
          }
        ),
        Image.network(
          this.widget.card.data.reaction.logo,
          height: 20,
          width: 20,
        ),
      ],
    );
  }
}

class DesactivatedCardBottom extends StatelessWidget {
  const DesactivatedCardBottom({
    Key key,
    @required this.card
    }) : super(key: key);

  final AppletCard card;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: 20, height: 20),
        Image.network(
          this.card.data.reaction.logo,
          height: 20,
          width: 20,
        ),
      ],
    );
  }
}