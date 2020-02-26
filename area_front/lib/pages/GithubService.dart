// Core
import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:area_front/models/Github.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'package:area_front/backend/Backend.dart' as B;
import 'package:area_front/models/Service.dart';
import 'package:area_front/services/Auth.dart';
import 'package:area_front/static/backend/BackendRoutes.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/utils/Color.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

// Data
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';

/// `My Applets` Page of the Area Project
class GithubServicePage extends StatefulWidget {
  GithubServicePage({Key key}) : super(key: key);

  @override
  _GithubServicePageState createState() => _GithubServicePageState();
}

class _GithubServicePageState extends State<GithubServicePage> {
  StreamSubscription _subs;

  FirebaseUser firebaseUser;

  Future<void> registerGithubToken(String code) async {
    try {
      String clientSecret;

      if (Platform.isAndroid || Platform.isIOS) {
        clientSecret = GlobalConfiguration().getString('GithubSignInMobileClientSecret');
      } else {
        clientSecret = GlobalConfiguration().getString('GithubSignInWebClientSecret');
      }
      final response = await http.post(
        GlobalConfiguration().getString('GithubAccessTokenUrl'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode(GitHubLoginRequest(
          clientId: GlobalConfiguration().getString('GithubSignInMobileClientId'),
          clientSecret: clientSecret,
          code: code,
        )),
      );

      final GitHubLoginResponse loginResponse = GitHubLoginResponse.fromJson(json.decode(response.body));

      print('user ID: ${firebaseUser.uid}');
      print('github token: ${loginResponse.accessToken}');

      B.Backend.post(firebaseUser, '/services/github',
        body: {
          "token": loginResponse.accessToken,
          "refresh" : ""
        }
      );
    } catch (e) {
      print('Got error when sign in with Github: $e');
    }
  }

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

  void _initDeepLinkListener() {
    _subs = getLinksStream().listen((String link) async {
      await _checkDeepLink(link);
    }, cancelOnError: true);
  }

  Future<void> _checkDeepLink(String link) async {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      await this.registerGithubToken(code);
    }
  }

  void _disposeDeepLinkListener() {
    if (_subs != null) {
      _subs.cancel();
      _subs = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Service data = ModalRoute.of(context).settings.arguments;

    final user = Provider.of<FirebaseUser>(context);
    this.firebaseUser = user;

    onSwitchChangeState(bool newValue) {
      setState(() {
        data.enable = newValue;
      });
    }



    return Scaffold(
      appBar: TopBar(),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                color: hexToColor(data.color),
                child: Container(
                  padding: const EdgeInsets.all(36.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                        data.logo,
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(width: 20),
                      AreaTitle(data.service)
                    ]
                  ),
                ),
              ),
              SizedBox(height: 20),
              LiteRollingSwitch(
                value: data.enable,
                textOn: 'On',
                textOff: 'Off',
                colorOn: hexToColor(data.color),
                colorOff: Colors.grey[700],
                iconOn: Icons.done,
                iconOff: Icons.remove_circle_outline,
                textSize: 25.0,
                onChanged: (newValue) async {
                  onSwitchChangeState(newValue);
                  if (newValue == true) {
                    print(data.service.toLowerCase().replaceAll(new RegExp(r"\s+\b|\b\s"), ""));
                    await B.Backend.post(
                        user,
                        BackendRoutes.activateService(
                          data.service
                          .toLowerCase()
                          .replaceAll(new RegExp(r"\s+\b|\b\s"), "")
                        )
                    );

                    if (!data.sync) {
                      await AuthService().signInWithGithub();
                      data.sync = true;
                    }
                  } else {
                    print(data.service.toLowerCase().replaceAll(new RegExp(r"\s+\b|\b\s"), ""));
                    B.Backend.post(
                      user,
                      BackendRoutes.desactivateService(
                        data.service
                        .toLowerCase()
                        .replaceAll(new RegExp(r"\s+\b|\b\s"), "")
                      )
                    );
                  }
                },
              ),
              AreaTitle('Test')
            ],
          ),
        ),
       ),
    );
  }
}
