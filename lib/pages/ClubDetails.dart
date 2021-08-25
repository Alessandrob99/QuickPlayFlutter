import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickplay/models/models.dart';
import 'package:quickplay/pages/home_page.dart';

import 'SelezioneOrario.dart';

class ClubDetails extends StatefulWidget {
  const ClubDetails({Key key, this.campi, this.circolo, this.data})
      : super(key: key);
  @override
  final List<Court> campi;
  final Club circolo;
  final DateTime data;

  _ClubDetails createState() => _ClubDetails(campi, circolo, data);
}

class _ClubDetails extends State<ClubDetails> {
  List<Court> campi = [];
  Club circolo;
  DateTime data;

  _ClubDetails(this.campi, this.circolo, this.data);

  getIcon(bool value) {
    switch (value) {
      case true:
        return TextSpan(
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),
            text: "SI");
      case false:
        return TextSpan(
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
            text: "NO");
    }
  }

  getColor(String superficie) {
    switch (superficie) {
      case ("erba"):
        return Color.fromRGBO(32, 102, 13, 1);
      case ("terra rossa"):
        return Colors.redAccent;
      case ("erba sintetica"):
        return Colors.lightGreen;
      case ("cemento"):
        return Colors.blueGrey;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.06),
                  child: Text(
                    circolo.nome,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: RichText(
                      text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    text: "Docce : ",
                    children: [getIcon(circolo.docce)],
                  )),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: Text(
                    "tel. " + circolo.telefono,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: Text(
                    "email :",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  child: Text(
                    circolo.email,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ]),
            ),
          ],
        ),
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(4),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.grey),
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.arrow_downward,
                        size: 18, color: Colors.black),
                  ),
                  TextSpan(
                      text: "  Seleziona il tuo campo  ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  WidgetSpan(
                    child: Icon(
                      Icons.arrow_downward,
                      size: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: campi.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelezioneOrario(
                                      campo: campi[index],
                                      circolo: circolo,
                                      data: data,
                                    )));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 8, bottom: 8),
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: Colors.black,
                              width: 4,
                            ),
                            color: Color.fromRGBO(255, 240, 143, 1)),
                        child: Column(children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 15, top: 10, right: 15),
                                child: RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                      text: "Campo n° : ",
                                      children: [
                                        TextSpan(
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            text: campi[index].n_c.toString())
                                      ]),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15, top: 8),
                                child: RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                      text: "Superficie : ",
                                      children: [
                                        TextSpan(
                                            style: TextStyle(
                                                color: getColor(
                                                    campi[index].superficie),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                            text: campi[index]
                                                .superficie
                                                .capitalize())
                                      ]),
                                ),
                              )
                            ],
                          ),
                          Row(children: [
                            Container(
                                margin: EdgeInsets.only(left: 15, top: 8),
                                child: RichText(
                                    text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  text: "Coperto : ",
                                  children: [getIcon(campi[index].coperto)],
                                )))
                          ]),
                          Row(children: [
                            Container(
                                margin: EdgeInsets.only(left: 15, top: 8),
                                child: RichText(
                                    text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  text: "Riscaldamento : ",
                                  children: [
                                    getIcon(campi[index].riscaldamento)
                                  ],
                                ))),
                          ]),
                          Row(children: [
                            Container(
                                margin: EdgeInsets.only(left: 15, top: 8),
                                child: RichText(
                                    text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  text: "Prezzo : ",
                                  children: [
                                    TextSpan(
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        text: campi[index].prezzo.toString()),
                                    TextSpan(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                        text: "  €/h")
                                  ],
                                )))
                          ]),
                        ]),
                      ));
                })),
      ]),
    );
  }
}
/*

Row(
                    children: [
                      Text(
                          'campo n° ${campi[index].n_c} in ${campi[index].superficie}'
                      ),

                      FlatButton(
                        onPressed: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => SelezioneOrario(campo: campi[index],circolo: circolo, data: data,)));
                        },
                        child: Text('Prenota', style: kLabelStyle),
                      )
                    ],
                  );
 */
