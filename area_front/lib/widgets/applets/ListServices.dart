// Core
import 'package:area_front/pages/Github.dart';
import 'package:flutter/material.dart';

// Modals
import 'package:area_front/models/Service.dart';

// Widgets
import 'package:area_front/widgets/applets/ServiceCard.dart';

class ListServices extends StatelessWidget {
  const ListServices({Key key, @required this.services}) : super(key: key);

  final List<Service> services;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                case 'Github':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GithubPage(
                        service: services[index].service,
                        logo: services[index].logo,
                        color: services[index].color
                      ),
                    ),
                  );
                  break;
                default:
              }
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AppletsDetailsPage(services[index]),
              //   ),
              // );
              print('Card pressed');
            },
          );
        },
      )
    );
  }
}
