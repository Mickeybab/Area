// Core
import 'package:area_front/backend/Navigation.dart';
import 'package:area_front/widgets/AreaLargeButton.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/GetMore.dart';
import 'package:flutter/material.dart';

// Constants
import 'package:area_front/static/Constants.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';

// Datas
import 'package:area_front/static/Routes.dart';

/// `Home` Page of the Area Project
class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Center(
        child: GetMore(),
      )
    );
  }
}
