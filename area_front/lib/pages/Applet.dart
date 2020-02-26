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
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AppletFrom(form: form, widget: widget))),
    );
  }
}

class AppletFrom extends StatelessWidget {
  const AppletFrom({
    Key key,
    @required this.form,
    @required this.widget,
  }) : super(key: key);

  final GlobalKey<FormState> form;
  final AppletsDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            AreaTitle(widget.applet.title),
            AreaText(widget.applet.description),
            Wrap(
              children: <Widget>[
                ActionInfo(widget: widget),
                ReactionInfo(
                  widget: widget,
                )
              ],
            ),
            AreaLargeButton(
              text: Constants.submit,
              onPressed: () async {
                final user = Provider.of<FirebaseUser>(context, listen: false);
                try {
                  await Request.addOrUpdateApplet(user, widget.applet);
                  final snackbar = SnackBar(
                    content: Text(Constants.allOk),
                  );
                  Scaffold.of(context).showSnackBar(snackbar);
                } catch (e) {
                  final snackbar = SnackBar(
                    content: Text(Constants.somethingWentWrong),
                  );
                  Scaffold.of(context).showSnackBar(snackbar);
                }
              },
            )
          ],
        ),
      )),
    );
  }
}

class ActionInfo extends StatelessWidget {
  const ActionInfo({
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
            Text((widget.applet.action.service == null)
                ? ""
                : widget.applet.action.service),
            Text((widget.applet.action.action == null)
                ? ""
                : widget.applet.action.action),
            Padding(padding: EdgeInsets.all(10.0)),
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.applet.action.param.length,
                itemBuilder: (BuildContext context, int index) {
                  return ActionParam(
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

class ReactionInfo extends StatelessWidget {
  const ReactionInfo({
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
            Text(widget.applet.reaction.service),
            Text(widget.applet.reaction.reaction),
            Padding(padding: EdgeInsets.all(10.0)),
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.applet.reaction.param.length,
                itemBuilder: (BuildContext context, int index) {
                  return ReactionParam(
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

class ActionParam extends StatelessWidget {
  const ActionParam({
    Key key,
    @required this.widget,
    @required this.index,
  }) : super(key: key);

  final int index;
  final AppletsDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    final textInputType = (widget.applet.action.param[index].type == "string")
        ? TextInputType.text
        : TextInputType.number;
    final textInputFormatter =
        (widget.applet.action.param[index].type == "string")
            ? BlacklistingTextInputFormatter.singleLineFormatter
            : WhitelistingTextInputFormatter.digitsOnly;

    return Row(
      children: <Widget>[
        Text(
          (widget.applet.action.param[index].name == null)
              ? ""
              : widget.applet.action.param[index].name,
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

class ReactionParam extends StatelessWidget {
  const ReactionParam({
    Key key,
    @required this.widget,
    @required this.index,
  }) : super(key: key);

  final int index;
  final AppletsDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    final textInputType = (widget.applet.reaction.param[index].type == "string")
        ? TextInputType.text
        : TextInputType.number;
    final textInputFormatter =
        (widget.applet.reaction.param[index].type == "string")
            ? BlacklistingTextInputFormatter.singleLineFormatter
            : WhitelistingTextInputFormatter.digitsOnly;
    print(widget.applet.reaction.param[index].name);
    return Row(
      children: <Widget>[
        Text(
          widget.applet.reaction.param[index].name,
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: widget.applet.reaction.param[index].value,
              onChanged: (value) =>
                  widget.applet.reaction.param[index].value = value,
              keyboardType: textInputType,
              inputFormatters: <TextInputFormatter>[textInputFormatter],
            ),
          ),
        )
      ],
    );
  }
}
