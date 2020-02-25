// Core
import 'package:area_front/backend/Backend.dart';
import 'package:area_front/models/applets/Applet.dart';
import 'package:area_front/widgets/applets/ListApplets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:area_front/static/Constants.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/LargeSearchBar.dart';

// Datas
import 'package:provider/provider.dart';

/// `Explores` Page of the Area Project
class Explore extends StatelessWidget {
  Explore({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar: TopBar(),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(36.0),
            width: 900,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 100 * 8, bottom: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AreaTitle(Constants.explore),
                SizedBox(height: 25),
                FutureBuilder(
                  future: Request.getApplets(user),
                  builder: (context, snapshot) {
                    if (snapshot.hasError == true) {
                      return Column(
                        children: <Widget>[
                          Icon(Icons.error_outline),
                          Text(snapshot.error.toString())
                        ],
                      );
                    } else if (snapshot.hasData) {
                      return Filter(list: snapshot.data);
                    } else
                      return CircularProgressIndicator();
                  },
                )
              ],
            ),
          ),
        ));
  }
}

class Filter extends StatefulWidget {
  Filter({Key key, this.list}) : super(key: key);
  final List<Applet> list;

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Applet> list = (this.textController.text == "")
        ? widget.list
        : widget.list.where(
            (element) => element.title.contains(this.textController.text)).toList();
    return Container(
        child: Expanded(
      child: Column(children: <Widget>[
        LargeSearchBar(
            autofocus: true,
            controller: this.textController,
            submit: (s) {
              this.setState(() {});
            }),
        ListApplet(applets: list),
      ]),
    ));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    this.textController.dispose();
    super.dispose();
  }
}
