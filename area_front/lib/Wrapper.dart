//Core
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Pages
import 'package:area_front/pages/auth/SignIn.dart';

// Models
import 'package:area_front/models/User.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth(this.page, {Key key}) : super(key: key);

  final Function page;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return (user == null ? SignInPage() : this.page());
  }
}
