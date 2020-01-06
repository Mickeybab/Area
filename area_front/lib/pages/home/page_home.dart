import 'package:flutter/material.dart';

// Screens
import 'package:area_front/pages/home/screens/screen_actions.dart' as SActions;
import 'package:area_front/pages/home/screens/screen_service.dart' as SServices;
import 'package:area_front/pages/home/screens/screen_profile.dart' as SProfile;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    SActions.Actions(),
    SServices.Services(),
    SProfile.Profile(),
  ];

  void onTabTapped(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.subdirectory_arrow_right), title: Text("Service")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), title: Text("Profile")),
          BottomNavigationBarItem(
              icon: Icon(Icons.create), title: Text("Actions")),
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}
