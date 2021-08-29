import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpPopup extends StatefulWidget {
  @override
  _HelpPopup createState() => _HelpPopup();
}

class _HelpPopup extends State<HelpPopup> {
  int slideNumber = 0;

  List<Container> contents = [
    Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: RichText(
          text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 18),
              text:
                  ("Questa sezione dell'app serve a mostrare i campi sportivi che corrispondono alle tue necessità.\nCliccando sul tasto "),
              children: <TextSpan>[
                TextSpan(
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  text: "FILTRI ",
                ),
                TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    text:
                        "ti sarà permesso specificare quali caratteristiche dovranno avere i campi che poi saranno mostrati.")
              ]),
        )),
    Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: RichText(
        text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 18),
            text:
                ("Sulla mappa i circoli nei quali sono presenti campi che rispettano i filtri applicati sono marcati in "),
            children: <TextSpan>[
              TextSpan(
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                text: "ROSSO \n\n",
              ),
              TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  text: "La tua posizione invece sarà marcata in"),
              TextSpan(
                style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                text: "BLU",
              ),
            ]
        ),
      ),
    ),
    Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: RichText(
          text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 18),
              text: "Per accedere alla lista dei campi di uno specifico circolo bisognera :\n\n",
            children: [
              TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
                text: ("1) Cliccare sulla posizione del circolo sulla mappa.\n\n"
                    "2) Cliccare sul nome del circolo che verrà mostrato.")
              )
            ],
          )
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.75,
          child: Card(
              elevation: 2.0,
              color: Colors.white, //Colore interno
              shape: new RoundedRectangleBorder(
                  side: new BorderSide(color: Colors.black, width: 3.0),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(children: [
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "GUIDA",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                    decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.center,
                  child: contents[slideNumber],
                ),
                SizedBox(height: 40),
                Align(
                  alignment: FractionalOffset.bottomRight,
                  child: TextButton(
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Text("Avanti",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontSize: 18)),
                    ),
                    onPressed: () {
                      slideNumber += 1;
                      if (slideNumber == 3) {
                        Navigator.pop(context);
                      } else {
                        setState(() {});
                      }
                    },
                  ),
                )
              ])),
        ));
  }
}
