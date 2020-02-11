// Core
import 'package:area_front/backend/Backend.dart';
import 'package:area_front/static/Constants.dart';
import 'package:area_front/widgets/AreaLargeButton.dart';
import 'package:area_front/widgets/AreaText.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Models
import 'package:area_front/models/applets/Applet.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AppletsDetailsPage extends StatefulWidget {
  const AppletsDetailsPage(this.applet, {Key key}) : super(key: key);

  final Applet applet;

  @override
  _AppletsDetailsPageState createState() => _AppletsDetailsPageState();
}

class _AppletsDetailsPageState extends State<AppletsDetailsPage> {
  final form = GlobalKey<FormState>();
  String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Form(
        key: form,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              AreaTitle(widget.applet.title),
              AreaText(widget.applet.description),
              Wrap(
                children: <Widget>[ServiceInfo(widget: widget)],
              ),
              AreaLargeButton(
                text: Constants.submit,
                onPressed: () async {
                  print(widget.applet.toJson());
                  final user = Provider.of<FirebaseUser>(context);
                  try {
                    await Request.addOrUpdateApplet(user, widget.applet);
                    setState(() {
                      message = Constants.allOk;
                    });
                  } catch (e) {
                    setState(() {
                      message = e;
                    });
                  }
                },
              )
            ],
          ),
        )),
      ),
    );
  }
}

class ServiceInfo extends StatelessWidget {
  const ServiceInfo({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final AppletsDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    final double width = (MediaQuery.of(context).size.width < 600)
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.width / 3;
    return Container(
      width: width,
      child: Card(
        child: Column(
          children: <Widget>[
            Text(widget.applet.action.service),
            Text(widget.applet.action.action),
            Padding(padding: EdgeInsets.all(10.0)),
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.applet.action.param.length,
                itemBuilder: (BuildContext context, int index) {
                  return Param(
                    index: index,
                    widget: widget,
                  );
                })
          ],
        ),
      ),
    );
  }
}

class Param extends StatelessWidget {
  const Param({
    Key key,
    @required this.widget,
    @required this.index,
  }) : super(key: key);

  final int index;
  final AppletsDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    final textInputType =
        (widget.applet.action.param[index].paramType == "string")
            ? TextInputType.text
            : TextInputType.number;
    final textInputFormatter =
        (widget.applet.action.param[index].paramType == "string")
            ? BlacklistingTextInputFormatter.singleLineFormatter
            : WhitelistingTextInputFormatter.digitsOnly;

    return Row(
      children: <Widget>[
        Text(
          widget.applet.action.param[index].name,
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: widget.applet.action.param[index].value,
              onChanged: (value) =>
                  widget.applet.action.param[index].value = value,
              keyboardType: textInputType,
              inputFormatters: <TextInputFormatter>[textInputFormatter],
            ),
          ),
        )
      ],
    );
  }
}
