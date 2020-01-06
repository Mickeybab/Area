import 'package:flutter/material.dart';

class Actions extends StatelessWidget {
  const Actions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Mes Actions "activées"',
            ),
          ],
        ),
      ),
    );
  }
}
