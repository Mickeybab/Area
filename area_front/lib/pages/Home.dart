// Core
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/TopBar.dart';

// Datas
import 'package:area_front/static/Routes.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(),
        body: Stack(
          children: <Widget>[
            Center(
              child: LimitedBox(
                maxHeight: 600,
                maxWidth: 600,
                child: Image.asset(
                  'assets/images/home/IFTTT.png',
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Get More",
                          style: TextStyle(fontSize: 24),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.login);
                        },
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                        ))
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
