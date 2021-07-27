import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EffettuaPrenotazione extends StatefulWidget {
  const EffettuaPrenotazione({Key key}) : super(key: key);


  @override
  _EffettuaPrenotazione createState() => _EffettuaPrenotazione();
}

class _EffettuaPrenotazione extends State<EffettuaPrenotazione> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu_rounded),
            ),
          ),
        ),
      ),
    );
  }

}