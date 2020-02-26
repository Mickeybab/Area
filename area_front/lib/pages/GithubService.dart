// Core
import 'dart:async';

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
import 'package:url_launcher/url_launcher.dart';

/// `My Applets` Page of the Area Project
class GithubServicePage extends StatefulWidget {
  GithubServicePage({Key key, this.data}) : super(key: key);

  final Service data;

  @override
  _GithubServicePageState createState() => _GithubServicePageState();
}

class _GithubServicePageState extends State<GithubServicePage> {
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
      AuthService().signInWithGitHub(code);
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

    onSwitchChangeState(bool newValue) {
      setState(() {
        widget.data.enable = newValue;
      });
    }

    Future signInWithGithub() async {
      String authorizeUrl = GlobalConfiguration().getString('GithubAuthorizeUrl');
        String clientId = GlobalConfiguration().getString('GithubSignInClientId');
        String url = authorizeUrl +
            "?client_id=" + clientId +
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
                color: hexToColor(this.widget.data.color),
                child: Container(
                  padding: const EdgeInsets.all(36.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                        widget.data.logo,
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(width: 20),
                      AreaTitle(widget.data.service)
                    ]
                  ),
                ),
              ),
              SizedBox(height: 20),
              LiteRollingSwitch(
                value: widget.data.enable,
                textOn: 'On',
                textOff: 'Off',
                colorOn: hexToColor(this.widget.data.color),
                colorOff: Colors.grey[700],
                iconOn: Icons.done,
                iconOff: Icons.remove_circle_outline,
                textSize: 25.0,
                onChanged: (newValue) async {
                  onSwitchChangeState(newValue);
                  if (newValue == true) {
                    print(widget.data.service.toLowerCase().replaceAll(new RegExp(r"\s+\b|\b\s"), ""));
                    await B.Backend.post(
                        user,
                        BackendRoutes.activateService(
                          widget.data.service
                          .toLowerCase()
                          .replaceAll(new RegExp(r"\s+\b|\b\s"), "")
                        )
                    );

                    await signInWithGithub();

                    print("SERVICE ACTIVATED");
                  } else {
                    print(widget.data.service.toLowerCase().replaceAll(new RegExp(r"\s+\b|\b\s"), ""));
                    B.Backend.post(
                      user,
                      BackendRoutes.desactivateService(
                        widget.data.service
                        .toLowerCase()
                        .replaceAll(new RegExp(r"\s+\b|\b\s"), "")
                      )
                    );
                    print("SERVICE DESACTIVATED");
                  }
                  //Use it to manage the different states
                  print('Current State of SWITCH IS: $newValue');
                },
              )
            ],
          ),
        ),
       ),
    );
  }
}
