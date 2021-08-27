import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import 'home_page_menu.dart';

class Players extends KFDrawerContent {


  Players({Key key,});

  @override
  _Players createState() => _Players();

}

class _Players extends State<Players> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu_rounded),
                onPressed: widget.onMenuPressed,
              ),
            ),
          ),
        ),
      onWillPop: onBackPressed,
    );
  }


  Future<bool> onBackPressed() {
    return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return DrawerScreen();
      },
    ), (route) => false);
  }

}