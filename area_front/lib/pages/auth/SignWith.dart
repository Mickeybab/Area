// Core
import 'package:area_front/services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:area_front/backend/Navigation.dart';

// Widgets
import 'package:area_front/widgets/AreaFlatButton.dart';
import 'package:area_front/widgets/AreaLargeButton.dart';
import 'package:area_front/widgets/AreaText.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/topbar/TopBar.dart';

// Statics
import 'package:area_front/static/Constants.dart';
import 'package:area_front/static/Routes.dart';

class SignWithPage extends StatefulWidget {
  const SignWithPage({Key key}) : super(key: key);

  @override
  _SignWithPageState createState() => _SignWithPageState();
}

class _SignWithPageState extends State<SignWithPage> {
  Widget build(BuildContext context) {

    final continueWithGoogle = AreaLargeButton(
      text: Constants.continueWithGoogle,
      onPressed: () async {
        await AuthService().signInWithGoogle();
        Navigation.navigate(context, Routes.home);
      },
    );

    return Scaffold(
      appBar: TopBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 550,
            child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AreaTitle(Constants.getStarted),
                    SizedBox(height: 45.0),
                    continueWithGoogle,
                    SizedBox(height: 25.0),
                    AreaText(Constants.usePassword, fontSize: 13),
                    SizedBox(height: 15.0),
                    AreaFlatButton(
                        text: Constants.signIn,
                        onPressed: () {
                          Navigation.navigate(context, Routes.signIn);
                        }),
                    SizedBox(height: 15.0),
                    AreaText(Constants.or, fontSize: 13),
                    SizedBox(height: 15.0),
                    AreaFlatButton(
                      text: Constants.signUp,
                      onPressed: () {
                        Navigation.navigate(context, Routes.signUp);
                      },
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
