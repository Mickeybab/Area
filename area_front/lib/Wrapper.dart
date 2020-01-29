//Core
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

// Models
import 'package:area_front/models/User.dart';

//Pages
import 'package:area_front/pages/Home.dart';
import 'package:area_front/pages/auth/Authenticate.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return AuthPage();
    } else {
      return HomePage();
    }
  }
}