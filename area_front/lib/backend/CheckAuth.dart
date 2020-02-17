//Core
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Pages
import 'package:area_front/pages/auth/SignIn.dart';


/// If a [User] is connected the Widget will display the result of
/// the [Function] `page` given as parameter otherwise it will display the [SignInPage]
class CheckAuth extends StatelessWidget {
  const CheckAuth(this.page, {Key key}) : super(key: key);

  final Function page;/// this [Function] is given as parameter is must return Widget to display

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return (user == null ? SignInPage() : this.page());
  }
}
