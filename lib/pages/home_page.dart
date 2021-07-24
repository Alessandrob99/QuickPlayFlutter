import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import 'home_page_menu.dart';

class Home extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Home> {

  Widget home(context) {
    return Scaffold();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.indigo, accentColor: Colors.amberAccent),
      routes: {
        "/": (context) => (Drawer3d()),
      },
    );
  }

}