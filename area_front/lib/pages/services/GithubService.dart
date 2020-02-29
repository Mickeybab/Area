// Core
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:area_front/backend/Backend.dart';
import 'package:area_front/models/Github.dart';
import 'package:area_front/widgets/GetMore.dart';
import 'package:area_front/widgets/applets/ListApplets.dart';
import 'package:area_front/widgets/auth/ErrorAuthText.dart';
import 'package:area_front/widgets/services/ServiceHeader.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'package:area_front/backend/Backend.dart' as B;
import 'package:area_front/models/Service.dart';
import 'package:area_front/static/backend/BackendRoutes.dart';
import 'package:area_front/widgets/utils/Color.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:area_links/area_links.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

// Data
import 'package:provider/provider.dart';

/// `GithubService` Page of the Area Project
class GithubServicePage extends StatefulWidget {
  GithubServicePage({Key key}) : super(key: key);

  @override
  _GithubServicePageState createState() => _GithubServicePageState();

  static Future<void> registerGithubToken(
      String code, FirebaseUser firebaseUser) async {
    try {
      String clientSecret = (kIsWeb)
          ? GlobalConfiguration().getString('GithubSignInWebClientSecretJ')
          : GlobalConfiguration().getString('GithubSignInMobileClientSecret');
      String clientId = (kIsWeb)
          ? GlobalConfiguration().getString('GithubSignInWebClientIdJ')
          : GlobalConfiguration().getString('GithubSignInMobileClientId');
      http.Response response;

      if (kIsWeb) {
        await B.Backend.post(
            firebaseUser, BackendRoutes.syncService(BackendRoutes.github),
            body: {"code": code});
        return;
      } else {
        final String body = jsonEncode(GitHubLoginRequest(
          clientId: clientId,
          clientSecret: clientSecret,
          code: code,
        ).toJson());
        response = await http.post(
          GlobalConfiguration().getString('GithubAccessTokenUrl'),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: body,
        );
      }
      final GitHubLoginResponse loginResponse =
          GitHubLoginResponse.fromJson(json.decode(response.body));

      await B.Backend.post(
          firebaseUser, BackendRoutes.syncService(BackendRoutes.github),
          body: {"token": loginResponse.accessToken, "refresh": ""});
    } catch (e) {
      print('Got error when sign in with Github: $e');
    }
  }
}

class _GithubServicePageState extends State<GithubServicePage> {
  FirebaseUser firebaseUser;

  AreaLinks _link = AreaLinks();
  String _error = '';

  @override
  void dispose() {
    _link.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _link.registerCallbackHandler((String link) async {
      print("Je suis la $link");
      await _checkDeepLink(link);
    });
  }

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

    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      print("Cannot launch Github authorization URL");
    }
    print("Je suis la");
  }

  Future<void> _checkDeepLink(String link) async {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      try {
        await GithubServicePage.registerGithubToken(code, firebaseUser);
      } catch (e) {
        setState(() => _error = e);
      }
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
                    future: Request.getService(user, BackendRoutes.github),
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
                            ServiceHeader(data: data, textColor: Colors.black),
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
                                print("Ici");
                                if (newValue == true) {
                                  try {
                                    await B.Backend.post(
                                        user,
                                        BackendRoutes.activateService(
                                            BackendRoutes.github));
                                  } catch (e) {
                                    setState(() => _error = e);
                                  }
                                  if (!data.sync) {
                                    await this.signInWithGithub();
                                    data = await Request.getService(
                                        user, 'github');
                                  } else {
                                    try {
                                      await B.Backend.post(
                                          user,
                                          BackendRoutes.desactivateService(
                                              BackendRoutes.github));
                                    } catch (e) {
                                      setState(() => _error = e);
                                    }
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 10),
                            ErrorAuth(_error),
                            SizedBox(height: 10),
                            FutureBuilder(
                              future: Request.getAppletsByService(
                                  user, BackendRoutes.github),
                              builder: (context, snapshot) {
                                if (snapshot.hasError == true) {
                                  return Column(
                                    children: <Widget>[
                                      Icon(Icons.error_outline),
                                      Text(snapshot.error.toString())
                                    ],
                                  );
                                } else if (snapshot.hasData) {
                                  if (snapshot.data != null) {
                                    return ListApplet(applets: snapshot.data);
                                  } else {
                                    return GetMore();
                                  }
                                } else
                                  return CircularProgressIndicator();
                              },
                            )
                          ],
                        );
                      } else
                        return CircularProgressIndicator();
                    }))));
  }
}
