import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

class Circoli extends KFDrawerContent {


  Circoli({Key key,});

  @override
  _Circoli createState() => _Circoli();

}

class _Circoli extends State<Circoli> with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Dio circolo"),
      ),
    );
  }

}