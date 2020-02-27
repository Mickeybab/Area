// Core
import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:area_front/backend/Backend.dart';
import 'package:area_front/models/Github.dart';
import 'package:area_front/static/Constants.dart';
import 'package:area_front/static/Routes.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'package:area_front/backend/Backend.dart' as B;
import 'package:area_front/backend/Auth.dart';
import 'package:area_front/models/Service.dart';
import 'package:area_front/static/backend/BackendRoutes.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/utils/Color.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  static Future<void> registerGithubToken(
      String code, FirebaseUser firebaseUser) async {
    print('registerGithubToken');
    try {
      String clientSecret = (kIsWeb)
          ? GlobalConfiguration().getString('GithubSignInWebClientSecretJ')
          : GlobalConfiguration().getString('GithubSignInMobileClientSecret');
      String clientId = (kIsWeb)
          ? GlobalConfiguration().getString('GithubSignInWebClientIdJ')
          : GlobalConfiguration().getString('GithubSignInMobileClientId');

      final String body = jsonEncode(GitHubLoginRequest(
        clientId: clientId,
        clientSecret: clientSecret,
        code: code,
      ));

      print(body);

      final response = await http.post(
        GlobalConfiguration().getString('GithubAccessTokenUrl'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Access-Control-Allow-Headers": "*",
          "Access-Control-Allow-Origin": "http://localhost:5000"
        },
        body: body,
      );

      final GitHubLoginResponse loginResponse =
          GitHubLoginResponse.fromJson(json.decode(response.body));
      print(loginResponse);

      print('user ID: ${firebaseUser.uid}');
      print('github token: ${loginResponse.accessToken}');

      B.Backend.post(firebaseUser, BackendRoutes.syncService('github'),
          body: {"token": loginResponse.accessToken, "refresh": ""});
    } catch (e) {
      print('Got error when sign in with Github: $e');
    }
  }

  @override
  _GithubServicePageState createState() => _GithubServicePageState();
}

class _GithubServicePageState extends State<GithubServicePage> {
  StreamSubscription _subs;

  FirebaseUser firebaseUser;

  Future signInWithGithub() async {
    String authorizeUrl = GlobalConfiguration().getString('GithubAuthorizeUrl');
    String clientId;

    if (kIsWeb) {
      clientId = GlobalConfiguration().getString('GithubSignInWebClientIdJ');
    } else if (Platform.isAndroid || Platform.isIOS) {
      clientId = GlobalConfiguration().getString('GithubSignInMobileClientId');
    }
    String url = authorizeUrl +
        "?client_id=" +
        clientId +
        "&scope=public_repo%20read:user%20user:email";

    if (!kIsWeb) {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
        );
      } else {
        print("Cannot launch Github authorization URL");
      }
    } else {
      print("Je suis la");
      print(
          "${(MediaQuery.of(context).size.width / 30).round()}  ${(MediaQuery.of(context).size.height / 30).round()}");
      openWindow(url, "Login", 300, 300);
      await Future.delayed(Duration(seconds: 2));
      print("code: $code notloged: $notloged");
      if (code != null)
        await GithubServicePage.registerGithubToken(code, firebaseUser);
    }
  }

  @override
  void initState() {
    super.initState();
    _initDeepLinkListener();
  }

  @override
  void dispose() {
    _disposeDeepLinkListener();
    super.dispose();
  }

  void _initDeepLinkListener() {
    print("On va trouver");
    _subs = getLinksStream().listen((String link) async {
      print("Je suis la $link");
      await _checkDeepLink(link);
    }, cancelOnError: false);
  }

  Future<void> _checkDeepLink(String link) async {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      await GithubServicePage.registerGithubToken(code, firebaseUser);
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
    final user = Provider.of<FirebaseUser>(context);
    this.firebaseUser = user;

    return Scaffold(
        appBar: TopBar(),
        body: Center(
            child: Container(
                child: FutureBuilder(
                    future: Request.getService(user, 'github'),
                    builder: (context, snapshot) {
                      Service data;
                      if (snapshot.hasError == true) {
                        return Column(
                          children: <Widget>[
                            Icon(Icons.error_outline),
                            Text(snapshot.error.toString())
                          ],
                        );
                      } else if (snapshot.hasData == true) {
                        data = snapshot.data;
                        // updateServiceData(snapshot.data);
                        return Column(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.network(
                                        data.logo,
                                        height: 80,
                                        width: 80,
                                      ),
                                      SizedBox(width: 20),
                                      AreaTitle(data.service)
                                    ]),
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
                                if (newValue == true) {
                                  await B.Backend.post(
                                      user,
                                      BackendRoutes.activateService(data.service
                                          .toLowerCase()
                                          .replaceAll(
                                              RegExp(r"\s+\b|\b\s"), "")));
                                  if (!data.sync) {
                                    await this.signInWithGithub();
                                    data = await Request.getService(
                                        user, 'github');
                                  }
                                } else {
                                  B.Backend.post(
                                      user,
                                      BackendRoutes.desactivateService(
                                          data.service.toLowerCase().replaceAll(
                                              RegExp(r"\s+\b|\b\s"), "")));
                                }
                              },
                            ),
                            AreaTitle('Test')
                          ],
                        );
                      } else
                        return CircularProgressIndicator();
                    }))));
  }
}
