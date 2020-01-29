// Core
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

// Models
import 'package:area_front/models/User.dart';

// Widgets
import 'package:area_front/widgets/topbar/ConnectTopBar.dart';
import 'package:area_front/widgets/topbar/DisconnectTopBar.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return DisconnectTopBar();
    } else {
      return ConnectTopBar();
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}