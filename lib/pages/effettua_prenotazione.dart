
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickplay/ViewModel/DB_Handler_Clubs.dart';

class EffettuaPrenotazione extends StatefulWidget {
  const EffettuaPrenotazione({Key key, this.sport, this.data})
      : super(key: key);
  @override
  final String sport;
  final DateTime data;

  _EffettuaPrenotazione createState() => _EffettuaPrenotazione(sport, data);
}

class _EffettuaPrenotazione extends State<EffettuaPrenotazione> {
  String sport;
  DateTime data;

  bool coperto = false;
  bool riscaldamento = false;
  bool docce = false;
  TextEditingController maxDistance = TextEditingController();
  TextEditingController maxPrice = TextEditingController();
  TextEditingController superficie = TextEditingController();



  ScrollController scrollController;


  _EffettuaPrenotazione(this.sport, this.data);

  GoogleMapController mapController;
  final LatLng _center = const LatLng(43.586751779797915, 13.51659500105265);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    maxDistance.text = "20";
    maxPrice.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.6,
              builder: (context, scrollcontroller) => Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "FILTRI",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                fontSize: 28),
                          ),
                        ),
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
                                    print("Vuoi un campo coperto.");
                                  },
                                )
                            )

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
                                    print("Vuoi un campo con il Riscaldamento.");
                                  },
                                )
                            )

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
                                    print("Vuoi un campo con le docce.");
                                  },
                                )
                            )

                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: Text("Distanza massima da te : "),),
                            Expanded(child: TextField(
                              controller: maxDistance,
                              keyboardType: TextInputType.number,
                            ))
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: Text("Prezzo massimo : "),),
                            Expanded(child: TextField(
                              controller: maxPrice,
                              keyboardType: TextInputType.number,
                            )),
                            Expanded(child: Text("€/h"),),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: Text("Superficie : "),),
                            Expanded(child: TextField(
                              controller: superficie,
                              keyboardType: TextInputType.text,
                            )),
                          ],
                        ),
                        Row(
                          children: [
                            Center(
                              child:
                              RaisedButton(
                                elevation: 5.0,
                                onPressed: () {
                                  aggiornaFiltri();
                                },
                                padding: EdgeInsets.all(15.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(color: Colors.black26, width: 2.0)),
                                color: Colors.white,
                                child: Text(
                                  'AGGIORNA',
                                  style: TextStyle(
                                    color: Colors.black,
                                    letterSpacing: 1.5,
                                    fontSize: 14.0,
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
                  )),
        ],
      ),
    );
  }


  //legge i filtri e chiama il metodo che restituisce i circoli corrispondenti
  void aggiornaFiltri(){

    //Usiamo una callback in quanto dobbiamo ritornare sia i circoli che i campi corrispondenti
    // ( Per ogni circolo non è detto che tutti i campi siano accettabili )


    var prezzo;
    var distanza;
    try{
      if(maxPrice.text!="") {
        prezzo = int.parse(maxPrice.text);
      }else {
        prezzo = 100000000;
      }
      if(maxDistance!=""){
        distanza = int.parse(maxDistance.text);
      }else{
        distanza = 100000000;
      }
    }catch(e){
      print("Errore! Filtri non validi");
      return;
    }
    DB_Handler_Clubs.getFilteredClubsAndCourt(distanza, prezzo , docce, riscaldamento, coperto, superficie.text, (circoli, campi){
      print("Circoli trovati :");
      circoli.forEach((element) {
        print("\n"+element.nome);
      });
    });


  }
}
