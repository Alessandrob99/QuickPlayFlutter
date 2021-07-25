import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

class Players extends KFDrawerContent {
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