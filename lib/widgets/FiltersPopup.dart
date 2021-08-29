
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterPopup extends StatefulWidget {

  //VALORI INIZIALI
  //COSI VEDIAMO COME SONO STATI IMPOSTATI I FILTRI IN PRECEDENZA
  final String Superficie;
  final String prezzo;
  final String distanza;
  final bool coperto;
  final bool docce;
  final bool riscaldamento;

  FilterPopup(this.Superficie, this.prezzo, this.distanza, this.coperto,
      this.docce, this.riscaldamento);

  @override
  _FilterPopupState createState() => _FilterPopupState(Superficie,prezzo,distanza,coperto,docce,riscaldamento);

}

class _FilterPopupState extends State<FilterPopup> {

  bool coperto = false;
  bool riscaldamento = false;
  bool docce = false;
  TextEditingController maxDistance = TextEditingController();
  TextEditingController maxPrice = TextEditingController();
  List<String> _surfaces = [
    'Tutte',
    'Erba',
    'Cemento',
    'Terra rossa',
    'Erba sintetica',
    "Altro"
  ]; // Option 2
  String _selectedSurface = "Tutte";

  _FilterPopupState(this._selectedSurface,prezzo,distanza, this.coperto,
      this.docce, this.riscaldamento){
    maxPrice.text = prezzo;
    maxDistance.text = distanza;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
            padding: EdgeInsets.only(
              top: 15,
              bottom: 15,
              left: 15,
              right: 15,
            ),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  Text(
                    "FILTRI DI RICERCA",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color.fromRGBO(100, 100, 100, 1),
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: CheckboxListTile(
                                title: Text("Coperto"),
                                value: coperto,
                                onChanged: (value) {
                                  setState(() {
                                    coperto = value;
                                  });
                                },
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CheckboxListTile(
                                title: Text("Riscaldamento"),
                                value: riscaldamento,
                                onChanged: (value) {
                                  setState(() {
                                    riscaldamento = value;
                                  });
                                },
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CheckboxListTile(
                                title: Text("Docce"),
                                value: docce,
                                onChanged: (value) {
                                  setState(() {
                                    docce = value;
                                  });
                                },
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text("Distanza massima: "),
                          ),
                          Expanded(
                              child: TextField(
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                                controller: maxDistance,
                                keyboardType: TextInputType.number,
                              )),
                          Expanded(
                            child: Text("Km"),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text("Prezzo massimo : "),
                          ),
                          Expanded(
                              child: TextField(
                                controller: maxPrice,
                                keyboardType: TextInputType.number,
                              )),
                          Expanded(
                            child: Text("€/h"),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text("Superficie : "),
                          ),
                          DropdownButton(
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            value: _selectedSurface,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedSurface = newValue;
                              });
                            },
                            items: _surfaces.map((location) {
                              return DropdownMenuItem(
                                child: new Text(location),
                                value: location,
                              );
                            }).toList(),
                          ),
                          Expanded(
                            child: Text(" "),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.0),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () async {
                            Navigator.pop(context,{
                              "coperto" : coperto,
                              "docce" : docce,
                              "riscaldamento" : riscaldamento,
                              "distanza" : maxDistance.text,
                              "prezzo" : maxPrice.text,
                              "superficie" : _selectedSurface
                            });
                            //Ritorno i filtri aggiornati alla pagina di partenza
                            // aggiornaFiltri();
                          },
                          padding: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(
                                  color: Colors.black26, width: 2.0)),
                          color: Colors.grey,
                          child: Text(
                            "AGGIORNA",
                            style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 1,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ])));
  }
}

