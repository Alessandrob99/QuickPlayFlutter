import "package:flutter/material.dart";

import 'home_page_menu.dart';

class User {
  User({this.name, this.email});

  final String name;
  final String email;
}

const USER_NAMES = [
  "Isa Tusa",
  "Racquel Ricciardi",
  "Teresita Mccubbin",
  "Rhoda Hassinger",
  "Carson Cupps",
  "Devora Nantz",
  "Tyisha Primus",
  "Muriel Lewellyn",
  "Hunter Giraud",
  "Corina Whiddon",
  "Meaghan Covarrubias",
  "Ulysses Severson",
  "Richard Baxter",
  "Alessandra Kahn",
  "Libby Saari",
  "Valeria Salvador",
  "Fredrick Folkerts",
  "Delmy Izzi",
  "Leann Klock",
  "Rhiannon Macfarlane",
];
const USER_EMAILS = [
  "isa.tusa@me.com",
  "racquel.ricciardi@me.com",
  "teresita.mccubbin@me.com",
  "rhoda.hassinger@me.com",
  "carson.cupps@me.com",
  "devora.nantz@me.com",
  "tyisha.primus@me.com",
  "muriel.lewellyn@me.com",
  "hunter.giraud@me.com",
  "corina.whiddon@me.com",
  "meaghan.covarrubias@me.com",
  "ulysses.severson@me.com",
  "richard.baxter@me.com",
  "alessandra.kahn@me.com",
  "libby.saari@me.com",
  "valeria.salvador@me.com",
  "fredrick.folkerts@me.com",
  "delmy.izzi@me.com",
  "leann.klock@me.com",
  "rhiannon.macfarlane@me.com",
];

class VisualizzaPrenotazioni extends StatefulWidget {
  VisualizzaPrenotazioni({Key key, this.group, this.onClick}) : super(key: key);
  final VoidCallback onClick;
  final GroupType group;

  @override
  _ListState createState() => _ListState();
}

enum GroupType {
  simple,
  scroll,
}

class _ListState extends State<VisualizzaPrenotazioni> {
  var _direction = Axis.vertical;
  List<User> users;

  List<User> _users() {
    var list = List<User>();
    for (int i = 0; i < USER_NAMES.length; i++) {
      var user = User(name: USER_NAMES[i], email: USER_EMAILS[i]);
      list.add(user);
    }
    return list;
  }

  Widget _itemTitle(User user) {
    return ListTile(
      title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: <Widget>[
              Text("Nome Campo"),
              Text("Numero Campo"),
              Text("Data"),
              Text("Dalle/Alle"),
              Row(children: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Cancella',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'WorkSansMedium'),
                    )),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Visualizza Partecipanti',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'WorkSansMedium'),
                    ))
              ])
            ],
          )),
      leading: CircleAvatar(
        backgroundImage: ExactAssetImage(
          'assets/img/sport.png',
        ),
      ),
      dense: true,

      //onTap: () => ,
    );
  }

  Widget _bodyContent() {
    if (users == null) {
      users = _users();
    }
    var isVertical = _direction == Axis.vertical;
    return ListView.builder(
      scrollDirection: _direction,
      itemCount: users.length,
      itemExtent: 150.0,
      itemBuilder: (context, index) {
        return Container(
          alignment: AlignmentDirectional.center,
          color: Colors.brown,
          margin: isVertical
              ? EdgeInsets.only(bottom: 1.0)
              : EdgeInsets.only(right: 1.0),
          constraints: isVertical
              ? BoxConstraints.tightForFinite(height: 80.0)
              : BoxConstraints.tightForFinite(width: 260.0),
          child: _itemTitle(users[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
        body: Container(
          constraints: _direction == Axis.vertical
              ? null
              : BoxConstraints.tightForFinite(height: 80.0),
          child: Center(
            child: _bodyContent(),
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
