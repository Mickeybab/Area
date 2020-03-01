//Core
import 'package:area_front/Notification.dart';
import 'package:area_front/backend/Backend.dart';
import 'package:area_links/area_links.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

// Used for Notifications
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Pages
import 'package:area_front/pages/auth/SignIn.dart';

/// If a [User] is connected the Widget will display the result of
/// the [Function] `page` given as parameter otherwise it will display the [SignInPage]
class CheckAuth extends StatelessWidget {
  const CheckAuth(this.page, {Key key}) : super(key: key);

  final Function page;

  /// this [Function] is given as parameter is must return Widget to display

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return (user == null ? SignInPage() : Notifications(page: this.page));
  }
}

class Notifications extends StatefulWidget {
  Notifications({Key key, this.page}) : super(key: key);

  final Function page;

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  Timer _timer;
  AreaLinks _link = AreaLinks();

  @override
  void initState() {
    super.initState();
    this.initTimer();
  }

  initTimer() {
    this._timer = Timer.periodic(new Duration(seconds: 5), (timer) async {
      final user = Provider.of<FirebaseUser>(context, listen: false);
      if (user != null) {
        try {
          final notif = await Request.notif(user);

          if (notif.length != 0) {
            notif.forEach((element) async {
              if (!kIsWeb) {
                var androidPlatformChannelSpecifics = AndroidNotificationDetails(
                    'your channel id',
                    'your channel name',
                    'your channel description',
                    importance: Importance.Max,
                    priority: Priority.High,
                    ticker: 'ticker');
                var iOSPlatformChannelSpecifics = IOSNotificationDetails();
                var platformChannelSpecifics = NotificationDetails(
                    androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
                await flutterLocalNotificationsPlugin.show(
                    0, 'AREA', element, platformChannelSpecifics,
                    payload: 'item x');
              } else {
                _link.sendNotification(element);
              }
            });
          }
        } catch (e) {
          print(e);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.page();
  }

  @override
  void dispose() {
    this._timer.cancel();
    super.dispose();
  }
}
