// Core
import 'package:area_front/models/Service.dart';
import 'package:area_front/widgets/AreaTitle.dart';
import 'package:area_front/widgets/utils/Color.dart';
import 'package:flutter/material.dart';

class ServiceHeader extends StatelessWidget {
  const ServiceHeader({Key key, this.data});

  final Service data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      color: hexToColor(data.color),
      child: Container(
        padding: const EdgeInsets.all(36.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.network(
                data.logo,
                height: 80,
                width: 80,
              ),
              SizedBox(width: 20),
              AreaTitle(data.service)
            ]),
      ),
    );
  }
}