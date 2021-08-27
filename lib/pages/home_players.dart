import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

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
          title: Text("Cane"),
        ))
    );
  }

}