// Core
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:provider/provider.dart';

// Models
import 'package:area_front/models/User.dart';

// Pages
import 'package:area_front/pages/auth/Authenticate.dart';

class MyServices extends StatelessWidget {
  const MyServices({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return AuthPage();
    }
    return Scaffold(
      appBar: TopBar(),
      body: Center(
          child: Text("Mes Services"),
      ),
    );
  }
}
