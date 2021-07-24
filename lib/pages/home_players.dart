import 'package:flutter/material.dart';

class Players extends StatefulWidget {
  @override
  _Players createState() => _Players();
}

class _Players extends State<Players> {

  Widget home(context) {
    return Scaffold();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questo è la ricerca giocatori"),
      ),
    );
  }

}