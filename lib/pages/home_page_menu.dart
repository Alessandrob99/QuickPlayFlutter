import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:quickplay/ViewModel/Auth_Handler.dart';
import 'package:quickplay/pages/home_page.dart';
import 'package:quickplay/pages/home_players.dart';
import 'package:quickplay/pages/home_profile.dart';
import 'package:quickplay/utils/dialog_helper.dart';

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
      initialPage: Home(),
      items: [
        KFDrawerItem.initWithPage(
          text: Text('Home',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: Icon(Icons.home, color: Colors.white),
          page: Home(),
        ),
        KFDrawerItem.initWithPage(
          text: Text('Profilo',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: Icon(Icons.person, color: Colors.white),
          page: Profile(),
        ),
        KFDrawerItem.initWithPage(
          text: Text('Giocatori',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: Icon(Icons.people, color: Colors.white),
          page: Players(),
        ),
        KFDrawerItem.initWithPage(
          text: Text('Circoli',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: Icon(Icons.map, color: Colors.white),
          //page: Circoli(),
        ),
        KFDrawerItem.initWithPage(
          text: Text('_________________________________________________________',
              style: TextStyle(color: Colors.white, fontSize: 2)),
        ),
        KFDrawerItem.initWithPage(
          text: Text('Info App',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: Icon(Icons.perm_device_info, color: Colors.white),
          //page: InfoApp(),
        ),
        KFDrawerItem.initWithPage(
          text: Text('Contattaci',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: Icon(Icons.contact_mail, color: Colors.white),
          //page: Contattaci(),
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
                      Auth_Handler.CURRENT_USER.nome.capitalize()+" "+Auth_Handler.CURRENT_USER.cognome.capitalize(),
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
          onPressed: () {
              return DialogHelper.exit(context);
          },
        ),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 31, 31, 31),
        ),
      ),
    );
  }
}
