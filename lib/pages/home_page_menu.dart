import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:quickplay/pages/home_page.dart';
import 'package:quickplay/pages/home_page_start.dart';
import 'package:quickplay/pages/home_players.dart';
import 'package:quickplay/pages/home_profile.dart';
import 'package:quickplay/pages/widget/class_builder.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: HomePage(),
      items: [
        KFDrawerItem.initWithPage(
          text: Text('Home',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: Icon(Icons.person, color: Colors.white),
          page: HomePage(),
        ),
        KFDrawerItem.initWithPage(
          text: Text('Profilo',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: Icon(Icons.settings, color: Colors.white),
          page: Profile(),
        ),
        KFDrawerItem.initWithPage(
          text: Text('Giocatori',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: Icon(Icons.info, color: Colors.white),
          page: Players(),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: KFDrawer(
        controller: _drawerController,
        header: Padding(
          padding: const EdgeInsets.only(right: 120),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: EdgeInsets.only(right: 50.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: ExactAssetImage('assets/img/icon_profile.png'),
                    ),
                    Text(
                      "Nome Cognome",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      'Utente',
                      style: TextStyle(color: Colors.white54, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        footer: KFDrawerItem(
          text: Text(
            'Logout',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 18,
            ),
          ),
          icon: Icon(Icons.logout, color: Colors.white54),
          onPressed: () {},
        ),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 31, 31, 31),
        ),
      ),
    );
  }
}
