// Core
import 'package:area_front/pages/services/EpitechSyncService.dart';
import 'package:area_front/services/Auth.dart';
import 'package:area_front/static/Constants.dart';
import 'package:area_front/widgets/AreaLargeButton.dart';
import 'package:area_front/widgets/auth/ErrorAuthText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


import 'package:area_front/backend/Backend.dart';
import 'package:area_front/static/backend/BackendRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';


// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:area_front/widgets/services/ServiceHeader.dart';

// Data
import 'package:provider/provider.dart';
/// `My Applets` Page of the Area Project
class EpitechNoSyncServicePage extends StatefulWidget {
  EpitechNoSyncServicePage({Key key}) : super(key: key);

  @override
  _EpitechNoSyncServicePageState createState() => _EpitechNoSyncServicePageState();
}

class _EpitechNoSyncServicePageState extends State<EpitechNoSyncServicePage> {

  FirebaseUser firebaseUser;

  String accessToken = '';
  String error = '';

  final _formKey = GlobalKey<FormState>();

  TextFormField _tokenField() {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.colorBorder, width: 5),
          borderRadius: BorderRadius.circular(10)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 5),
          borderRadius: BorderRadius.circular(10)
        ),
        contentPadding: Constants.defaultPadding,
        hintText: Constants.hintTokenField,
      ),
      onChanged: (value) {
        setState(() {
          accessToken = value;
        });
      },
      validator: (value) =>
            value.isEmpty ? Constants.errorMessageEmailEmpty : null);
  }

  AreaLargeButton _registerTokenButton() {
    return AreaLargeButton(
      text: Constants.epitechAuthLink,
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          try {
            await AuthService().syncInWithEpitechIntra(firebaseUser, accessToken);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EpitechSyncServicePage(),
              ),
            );
          } catch (e) {
            setState(() => error = e.message);
          }
        }
      },
    );
  }


  Container _form() {
    return Container(
      width: 550,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            this._tokenField(),
            SizedBox(height: 20),
            this._registerTokenButton(),
          ]
        ),
      ),
    );
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
                    future: Request.getService(user, BackendRoutes.intraEpitech),
                    builder: (context, snapshot) {
                      if (snapshot.hasError == true) {
                        return Column(
                          children: <Widget>[
                            Icon(Icons.error_outline),
                            Text(snapshot.error.toString())
                          ],
                        );
                      } else if (snapshot.hasData == true) {
                        if (snapshot.data.sync ) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EpitechSyncServicePage(),
                            ),
                          );
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ServiceHeader(data: snapshot.data, textColor: Colors.black),
                            SizedBox(height: 20),
                            _form(),
                            SizedBox(height: 10),
                            ErrorAuth(error),
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
