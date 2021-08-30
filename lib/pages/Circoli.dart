import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import 'home_page_menu.dart';

class Circoli extends KFDrawerContent {


  Circoli({Key key,});

  @override
  _Circoli createState() => _Circoli();

}

class _Circoli extends State<Circoli> with SingleTickerProviderStateMixin {


  Future<bool> onBackPressed() {
    return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return DrawerScreen();
      },
    ), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.arrow_back_outlined),
                onPressed: onBackPressed,
              ),
            ),
          ),
          body: Text("Ciao"),
        ));
  }

}