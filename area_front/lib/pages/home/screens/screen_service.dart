import 'package:flutter/material.dart';

class Services extends StatelessWidget {
  const Services({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Mes Services',
            ),
          ],
        ),
      ),
    );
  }
}