import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page_menu.dart';


class VisualizzaPrenotazioni extends StatefulWidget {
  @override
  _VisualizzaPrenotazioni createState() => _VisualizzaPrenotazioni();
}

class _VisualizzaPrenotazioni extends State<VisualizzaPrenotazioni> {

  final List<String> _listItem = [
    'assets/img/icon_profile.png',
    'assets/img/quickplaylogo.PNG',
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: new Scaffold(
      backgroundColor: Colors.grey[600],
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text("Le tue prenotazioni", style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),),
              Container(
                width: double.infinity,
                height: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/img/sport.png'),
                        fit: BoxFit.fitHeight,
                    )
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.black.withOpacity(.4),
                            Colors.black.withOpacity(.2),
                          ]
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                  child: GridView.count(
                    crossAxisCount: 1,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: MediaQuery.of(context).size.height / 400,
                    scrollDirection: Axis.vertical,
                    children: _listItem.map((item) =>
                        Container(
                          height: 10,
                          child: Card(
                              color: Colors.red,
                              elevation: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: AssetImage(item),
                                        fit: BoxFit.cover
                                    )
                                ),
                        child: Transform.translate(
                          offset: Offset(50, -50),
                        ),
                      ),
                    ))).toList(),
                  )
              )
            ],
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


