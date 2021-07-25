import 'package:flutter/material.dart';
import 'home_page_menu.dart';

class Home extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.indigo, accentColor: Colors.amberAccent),
      routes: {
        "/": (context) => (DrawerScreen()),
      },
    );
  }

}