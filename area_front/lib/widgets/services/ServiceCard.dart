// Core
import 'package:area_front/widgets/AreaText.dart';
import 'package:flutter/material.dart';

// Models
import 'package:area_front/models/Service.dart';

class ServiceCard extends StatefulWidget {
  const ServiceCard(this.data,
      {Key key, this.onPressed})
      : super(key: key);

  final Service data;
  final Function onPressed;

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
        child: Card(
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: InkWell(
          onTap: this.widget.onPressed,
          child: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    this.widget.data.logo,
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(width: 20),
                  AreaText(
                      (this.widget.data.service == null)
                          ? ""
                          : this.widget.data.service,
                      fontWeight: FontWeight.w500,
                      fontSize: 36
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
