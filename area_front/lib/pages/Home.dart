// Core
import 'package:flutter/material.dart';

// Constants
import 'package:area_front/static/Constants.dart';


// My Widgets
import 'package:area_front/widgets/topbar/TopBar.dart';

// Datas
import 'package:area_front/static/Routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);

    final connectText = Text(
      'Connect your world.',
      style: Constants.style.copyWith(fontSize: 60, fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    );

    final image = Container(
      padding: EdgeInsets.only( left: 40, right: 40),
      width: 600,
      child: Image.asset(
        'assets/images/3.0x/services.png',
      ),
    );

    final getMoreButon = Material(
      borderRadius: BorderRadius.circular(35.0),
      color: Colors.black,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.explore);
        },
        child: Text("Get more",
          textAlign: TextAlign.center,
          style: Constants.style.copyWith(color: Colors.white, fontWeight: FontWeight.w600)
        ),
      ),
    );

    return Scaffold(
      appBar: TopBar(),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              connectText,
              SizedBox(height: 50.0),
              image,
              SizedBox(height: 200.0),
              Container(
                width: 300,
                child: getMoreButon
              )
            ],
          ),
        ),
      )



      // Stack(
      //   children: <Widget>[
      //     Center(
      //       child: Container(
      //         padding: EdgeInsets.only(bottom: 300, left: 10, right: 10, top: 20),
      //         height: 600,
      //         width: 600,
      //         child: Image.asset(
      //           'assets/images/3.0x/services.png',
      //         ),
      //       ),
      //     ),
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.end,
      //       children: <Widget>[
      //         ButtonBar(
      //           alignment: MainAxisAlignment.center,
      //           children: <Widget>[
      //             RaisedButton(
      //               padding: const EdgeInsets.all(18.0),
      //               child: Text(
      //                 "Get More",
      //                 style: TextStyle(fontSize: 24),
      //               ),
      //               onPressed: () {
      //                 Navigator.pushReplacementNamed(context, Routes.explore);
      //               },
      //               color: Colors.black,
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: new BorderRadius.circular(18.0),
      //               )
      //             )
      //           ],
      //         ),
      //       ],
      //     )
      //   ],
      // )
    );
  }
}
