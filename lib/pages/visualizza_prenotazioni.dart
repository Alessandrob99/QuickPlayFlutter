import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class VisualizzaPrenotazioni extends StatefulWidget {
  @override
  _VisualizzaPrenotazioni createState() => _VisualizzaPrenotazioni();
}

class _VisualizzaPrenotazioni extends State<VisualizzaPrenotazioni> {

  final List<String> _listItem = [
    'assets/img/icon_profile.png',
    'assets/img/quickplaylogo.PNG',
  ];

  Future<bool> _onBackPressed(){
    return showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: Text("Vuoi ritornare alla home?"),
          actions: <Widget> [
            FlatButton(
              child: Text("Si"),
              onPressed: () => Navigator.pop(context, false),
            ),
            FlatButton(
              child: Text("No"),
              onPressed: () => Navigator.pop(context, true),
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
      child: new Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu),
        title: Text("Home"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 36,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("0")),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/images/one.jpg'),
                        fit: BoxFit.cover
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Lifestyle Sale", style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),),
                      SizedBox(height: 30,),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                        child: Center(child: Text("Shop Now", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),)),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: _listItem.map((item) => Card(
                      color: Colors.transparent,
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
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 65, vertical: 63),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white
                            ),
                            child: Icon(Icons.bookmark_border, size: 15,),
                          ),
                        ),
                      ),
                    )).toList(),
                  )
              )
            ],
          ),
        ),
      ),
      )
    );
  }
}
