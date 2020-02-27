// Core
import 'package:area_front/services/Auth.dart';
import 'package:area_front/widgets/GetMore.dart';
import 'package:area_front/widgets/applets/ListApplets.dart';
import 'package:area_front/widgets/utils/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:area_front/backend/Backend.dart' as B;


import 'package:area_front/backend/Backend.dart';
import 'package:area_front/models/Service.dart';
import 'package:area_front/static/backend/BackendRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';


// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:area_front/widgets/services/ServiceHeader.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

// Data
import 'package:provider/provider.dart';
/// `My Applets` Page of the Area Project
class GoogleMailServicePage extends StatefulWidget {
  GoogleMailServicePage({Key key}) : super(key: key);

  static Future<void> registerGoogleMailToken(String accessToken, FirebaseUser firebaseUser) async {
      print('registerGoogleMailToken');
      B.Backend.post(firebaseUser, BackendRoutes.syncService(BackendRoutes.github),
          body: {"token": accessToken, "refresh": ""});
  }

  @override
  _GoogleMailServicePageState createState() => _GoogleMailServicePageState();
}

class _GoogleMailServicePageState extends State<GoogleMailServicePage> {

  FirebaseUser firebaseUser;

  Future signInWithGoogleMail() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await AuthService().googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      await GoogleMailServicePage.registerGoogleMailToken(googleSignInAuthentication.accessToken,
        firebaseUser);

    } catch (e) {
      print('Got error when sign in with Google: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    this.firebaseUser = user;

    LiteRollingSwitch switchButton(Service data) {
      return LiteRollingSwitch(
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
            if (!data.sync) {
              await this.signInWithGoogleMail();
              data = await Request.getService(user, BackendRoutes.googlemail);
            }
            await B.Backend.post(
              user,
              BackendRoutes.activateService(BackendRoutes.googlemail)
            );
          } else {
            B.Backend.post(
              user,
              BackendRoutes.desactivateService(BackendRoutes.googlemail)
            );
          }
        }
      );
    }

    return Scaffold(
        appBar: TopBar(),
        body: Center(
            child: Container(
                child: FutureBuilder(
                    future: Request.getService(user, BackendRoutes.googlemail),
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
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ServiceHeader(data: data, textColor: Colors.white),
                            SizedBox(height: 20),
                            switchButton(data),
                            SizedBox(height: 20),
                            FutureBuilder(
                              future: Request.getApplets(user),
                              // future: Request.getAppletsByService(user, BackendRoutes.googlemail),
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
                    }
                )
            )
        )
    );
  }
}
