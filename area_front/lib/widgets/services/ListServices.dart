// Core
import 'package:area_front/pages/services/CurrencyService.dart';
import 'package:area_front/pages/services/EpitechService.dart';
import 'package:area_front/pages/GithubService.dart';
import 'package:area_front/pages/services/GoogleMailService.dart';
import 'package:area_front/pages/services/SlackService.dart';
import 'package:area_front/pages/services/WeatherService.dart';
import 'package:area_front/static/Constants.dart';
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GithubServicePage(),
                      ),
                    );
                    break;
                  case Constants.epitech:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EpitechServicePage(),
                      ),
                    );
                    break;
                  case Constants.slack:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SlackServicePage(),
                      ),
                    );
                    break;
                  case Constants.currency:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CurrencyServicePage(),
                      ),
                    );
                    break;
                  case Constants.weather:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WeatherServicePage(),
                      ),
                    );
                    break;
                  case Constants.googlemail:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoogleMailServicePage(),
                      ),
                    );
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
