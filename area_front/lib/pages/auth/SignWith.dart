// Core
import 'dart:async';

import 'package:area_front/services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:area_front/backend/Navigation.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

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
  StreamSubscription _subs;

  @override
  void initState() {
    _initDeepLinkListener();
    super.initState();
  }

  @override
  void dispose() {
    _disposeDeepLinkListener();
    super.dispose();
  }

  void _initDeepLinkListener() async {
    _subs = getLinksStream().listen((String link) {
      _checkDeepLink(link);
    }, cancelOnError: true);
  }

  void _checkDeepLink(String link) {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      AuthService().loginWithGitHub(code)
        .then((firebaseUser) {
          print("LOGGED IN AS: " + firebaseUser.displayName);
        }).catchError((e) {
          print("LOGIN ERROR: " + e.toString());
        });
    }
  }

  void _disposeDeepLinkListener() {
    if (_subs != null) {
      _subs.cancel();
      _subs = null;
    }
  }


  Widget build(BuildContext context) {
    final continueWithGithubButon = AreaLargeButton(
      text: Constants.continueWithGithub,
      onPressed: () async {
        const String url = "https://github.com/login/oauth/authorize" +
            "?client_id=" + "75fa20208cf4489b5540" +
            "&scope=public_repo%20read:user%20user:email";

        if (await canLaunch(url)) {
          await launch(
            url,
            forceSafariVC: false,
            forceWebView: false,
          );
        } else {
          print("CANNOT LAUNCH THIS URL!");
        }
      },
    );

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
                    continueWithGithubButon,
                    SizedBox(height: 15.0),
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
