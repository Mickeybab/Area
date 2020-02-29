// Core
import 'package:area_front/backend/Backend.dart';
import 'package:area_front/static/Constants.dart';
import 'package:area_front/widgets/AreaLargeButton.dart';
import 'package:area_front/widgets/AreaText.dart';
import 'package:area_front/widgets/applets/AppletHeader.dart';
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Models
import 'package:area_front/models/applets/Applet.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'dart:math' as math;

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
          child: AppletFrom(form: form, widget: widget)
        )
      ),
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
        child: Container(
          child: Column(
            children: <Widget>[
              AppletHeader(
                applet: widget.applet,
                action: widget.applet.action,
                reaction: widget.applet.reaction,
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 30,
                children: <Widget>[
                  ActionInfo(widget: widget),
                  ReactionInfo(widget: widget)
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: 550,
                child: AreaLargeButton(
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
                ),
              )
            ],
          ),
        )
      ),
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
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AreaText((widget.applet.action.service == null)
              ? ""
              : widget.applet.action.service[0]
              .toUpperCase() +
              widget.applet.action.service.substring(1),
              fontSize: 28,
              fontWeight: FontWeight.w600
            ),
            AreaText((widget.applet.action.action == null)
              ? ""
              : widget.applet.action.action[0]
              .toUpperCase() +
              widget.applet.action.action.substring(1),
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),
            SizedBox(height: 20.0),
            ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: 20);
              },
              shrinkWrap: true,
              itemCount: widget.applet.action.param.length,
              itemBuilder: (BuildContext context, int index) {
                return ActionParam(
                  index: index,
                  widget: widget,
                );
              }
            )
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
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AreaText(
              widget.applet.reaction.service[0]
              .toUpperCase() +
              widget.applet.reaction.service.substring(1),
              fontSize: 28,
              fontWeight: FontWeight.w600
            ),
            AreaText(
              widget.applet.reaction.reaction,
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),
            SizedBox(height: 20.0),
            ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20);
                },
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AreaText(
          (widget.applet.action.param[index].name == null)
            ? ""
            : widget.applet.action.param[index].name,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        Container(
          child: TextFormField(
            initialValue: widget.applet.action.param[index].value,
            onChanged: (value) =>
                widget.applet.action.param[index].value = value,
            keyboardType: textInputType,
            inputFormatters: <TextInputFormatter>[textInputFormatter],
          ),
        ),
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
        : TextInputType.numberWithOptions(decimal: true);
    final textInputFormatter =
        (widget.applet.reaction.param[index].type == "string")
            ? BlacklistingTextInputFormatter.singleLineFormatter
            : DecimalTextInputFormatter(decimalRange: 2);
    print(widget.applet.reaction.param[index].name);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AreaText(
          widget.applet.reaction.param[index].name,
          fontSize: 18,
          fontWeight: FontWeight.w400
        ),
        Container(
          child: TextFormField(
            initialValue: widget.applet.reaction.param[index].value,
            onChanged: (value) =>
                widget.applet.reaction.param[index].value = value,
            keyboardType: textInputType,
            inputFormatters: <TextInputFormatter>[textInputFormatter],
          ),
        ),
      ],
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}