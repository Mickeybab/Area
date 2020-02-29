// Core
import 'package:area_front/backend/Navigation.dart';
import 'package:area_front/pages/services/CurrencyService.dart';
import 'package:area_front/pages/services/EpitechNoSyncService.dart';
import 'package:area_front/pages/services/EpitechSyncService.dart';
import 'package:area_front/pages/services/GithubService.dart';
import 'package:area_front/pages/services/GoogleMailService.dart';
import 'package:area_front/pages/services/SlackService.dart';
import 'package:area_front/pages/services/WeatherService.dart';
import 'package:area_front/static/Constants.dart';
import 'package:area_front/static/Routes.dart';
import 'package:flutter/material.dart';

// Modals
import 'package:area_front/models/Service.dart';

// Widgets
import 'package:area_front/widgets/services/ServiceCard.dart';

class ListServices extends StatelessWidget {
  const ListServices({Key key, @required this.services}) : super(key: key);

  final List<Service> services;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 600,
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(height: 5);
          },
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          itemCount: services.length,
          itemBuilder: (BuildContext context, int index) {
            return ServiceCard(
              services[index],
              onPressed: () {
                switch (services[index].service) {
                  case Constants.github:
                      Navigation.navigate(context, Routes.githubService);
                    break;
                  case Constants.epitech:
                    if (services[index].sync) {
                      Navigation.navigate(context, Routes.epitechService);
                    } else {
                      Navigation.navigate(context, Routes.epitechNoSyncService);
                    }
                    break;
                  case Constants.slack:
                    Navigation.navigate(context, Routes.slackService);
                    break;
                  case Constants.currency:
                    Navigation.navigate(context, Routes.currencyService);
                    break;
                  case Constants.weather:
                    Navigation.navigate(context, Routes.weatherService);
                    break;
                  case Constants.googlemail:
                    Navigation.navigate(context, Routes.googleMailService);
                    break;
                  default:
                }
              },
            );
          },
        ),
      )
    );
  }
}
