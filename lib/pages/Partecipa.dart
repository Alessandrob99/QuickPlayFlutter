import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickplay/ViewModel/DB_Handler_Reservations.dart';
import 'package:quickplay/pages/selezione1.dart';

class Partecipa extends StatefulWidget {
  Partecipa({Key key}) : super(key: key);

  @override
  _Partecipa createState() => _Partecipa();
}

class _Partecipa extends State<Partecipa> {
  TextEditingController codPren = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Container(
                alignment: Alignment.center,
                child: Column(children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "INSERISCI CODICE PRENOTAZIONE",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 6, 117, 1),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Wrap(children: [
                    Card(
                        elevation: 2.0,
                        color: Colors.white, //Colore interno
                        shape: new RoundedRectangleBorder(
                            //Colore del bordo
                            side: new BorderSide(
                                color: Colors.black26, width: 2.0),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Column(children: [
                          SizedBox(height: 50,),
                          HeaderWidget(
                              title: "Codice :",
                              child: TextField(
                                controller: codPren,
                                keyboardType: TextInputType.number,
                              )
                          ),
                          SizedBox(height: 50,),
                          Container(
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.20,right: MediaQuery.of(context).size.width*0.20),
                            padding: EdgeInsets.symmetric(vertical: 25.0),
                            width: double.infinity,
                            child: RaisedButton(
                              elevation: 5.0,
                              onPressed: () async {
                                showCheckProgress(context);
                                String msg = await DB_Handler_Reservations
                                    .newPartecipazione(codPren.text);
                                Navigator.of(context).pop();
                                final snackBar = SnackBar(
                                  content: Text(msg),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              padding: EdgeInsets.all(10.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(
                                      color: Colors.black26, width: 2.0)),
                              color: Color.fromRGBO(0, 229, 255, 1),
                              child: Text(
                                'Partecipa',
                                style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1.5,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            ),
                          ),

                        ]))
                  ])
                ]))));

    Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Center(
                child: Text(
                    "Inserire il codice della partecipazione a cui si intende unirsi"),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: TextField(
                controller: codPren,
                keyboardType: TextInputType.number,
              ))
            ],
          ),
          Row(
            children: <Widget>[
              Center(
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () async {
                    showCheckProgress(context);
                    String msg =
                        await DB_Handler_Reservations.newPartecipazione(
                            codPren.text);
                    Navigator.of(context).pop();
                    final snackBar = SnackBar(
                      content: Text(msg),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.black26, width: 2.0)),
                  color: Colors.white,
                  child: Text(
                    'Partecipa',
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  showCheckProgress(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: Text("Controllando il codice...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
