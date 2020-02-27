// Core
import 'package:area_front/pages/GithubService.dart';
import 'package:area_front/services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Modals
import 'package:area_front/models/Service.dart';

// Widgets
import 'package:area_front/widgets/applets/ServiceCard.dart';
import 'package:provider/provider.dart';

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
                      builder: (context) => GithubServicePage(),
                    ),
                  );
                  break;
                case 'Google Mail':
                  AuthService().syncInWithGoogle(Provider.of<FirebaseUser>(context, listen: false));
                  break;
                default:
              }
            },
          );
        },
      )
    );
  }
}
