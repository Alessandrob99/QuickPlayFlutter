import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import 'package:quickplay/pages/home_page_start.dart';
import 'package:quickplay/pages/home_players.dart';
import 'package:quickplay/pages/home_profile.dart';
import 'package:quickplay/pages/widget/menu.dart';


class Drawer3d extends StatefulWidget {
  @override
  _Drawer3dState createState() => _Drawer3dState();
}

class _Drawer3dState extends State<Drawer3d> {
  int selectedMenuItemId;


  @override
  void initState() {
    selectedMenuItemId = menuWithIcon.items[0].id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      appBar: AppBar(),
      drawers: [
        SideDrawer(
          percentage: 0.8,
          degree: 45,
          menu: menu,
          direction: Direction.left,
          animation: true,
          color: Theme.of(context).primaryColor,
          selectedItemId: selectedMenuItemId,
          onMenuItemSelected: (itemId) {
            setState(() {
              selectedMenuItemId = itemId;
            });
          },
        ),
        SideDrawer(
          degree: 45,
          menu: menuWithIcon,
          direction: Direction.right,
          animation: true,
          color: Theme.of(context).primaryColor,
          selectedItemId: selectedMenuItemId,
          onMenuItemSelected: (itemId) {
            setState(() {
              selectedMenuItemId = itemId;
            });
          },
        ),
      ],
      builder: (context, id) => IndexedStack(
        index: id,
        children: [
          HomePage(),//Home iniziale
          Profile(),//Profilo utente
          Players(),//Ricerca giocatori
        ]
      ),
    );
  }
}
