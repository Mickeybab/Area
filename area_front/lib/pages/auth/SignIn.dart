// Core
import 'package:flutter/material.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';
import 'package:area_front/widgets/auth/SignInContainer.dart';

class SignInPage extends StatelessWidget {
  final Function toggleSignForm;
  SignInPage({ this.toggleSignForm });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Container(
        child: SignInContainer(toggleSignForm: toggleSignForm,)
      ),
    );
  }
}
