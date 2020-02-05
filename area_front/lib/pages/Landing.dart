// Core
import 'package:flutter/material.dart';

import 'package:area_front/widgets/landing/HorizontalLandingStack.dart';
import 'package:area_front/widgets/landing/VerticalLandingStack.dart';

// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';

/// `Landing` Page of the Area Project
class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            return VerticalLandingStack();
          } else {
            return HorizontalLandingStack();
          }
        }
      ),
    );
  }
}
