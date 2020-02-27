// Core
import 'package:area_front/models/Service.dart';
import 'package:area_front/widgets/AreaText.dart';
import 'package:area_front/widgets/utils/Color.dart';
import 'package:flutter/material.dart';

class ServiceHeader extends StatelessWidget {
  const ServiceHeader({Key key, this.data, this.textColor});

  final Service data;
  final Color textColor;

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
              AreaText(data.service,
                fontSize: 70,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
                color: textColor
              )
            ]),
      ),
    );
  }
}