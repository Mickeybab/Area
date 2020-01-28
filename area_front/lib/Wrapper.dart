//Core
import 'package:area_front/models/User.dart';
import 'package:area_front/pages/auth/Authenticate.dart';
import 'package:flutter/material.dart';

//Pages
import 'package:area_front/pages/Home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null){
      return AuthPage();
    } else {
      return HomePage();
    }
  }
}