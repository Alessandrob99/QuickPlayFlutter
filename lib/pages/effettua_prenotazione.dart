import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickplay/ViewModel/DB_Handler_Clubs.dart';
import 'package:quickplay/models/models.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quickplay/pages/ClubDetails.dart';
import 'package:quickplay/widgets/snackbar.dart';

class EffettuaPrenotazione extends StatefulWidget {
  const EffettuaPrenotazione({Key key, this.campiPerSport, this.data})
      : super(key: key);
  @override
  final List<Court> campiPerSport;
  final DateTime data;

  _EffettuaPrenotazione createState() =>
      _EffettuaPrenotazione(campiPerSport, data);
}

class _EffettuaPrenotazione extends State<EffettuaPrenotazione> {
  List<Court> campiPerSport = [];
  DateTime data;

  bool coperto = false;
  bool riscaldamento = false;
  bool docce = false;
  TextEditingController maxDistance = TextEditingController();
  TextEditingController maxPrice = TextEditingController();
  TextEditingController superficie = TextEditingController();
  Set<Marker> clubMarkers = Set();
  LatLng _center = LatLng(43.586751779797915, 13.51659500105265);

  ScrollController scrollController;

  _EffettuaPrenotazione(this.campiPerSport, this.data);

  GoogleMapController mapController;

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
    if (clubMarkers.isEmpty) {
      aggiornaFiltri();
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            markers: clubMarkers,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
          SizedBox.expand(
            child: DraggableScrollableSheet(
                initialChildSize: 0.6,
                minChildSize: 0.2,
                maxChildSize: 0.6,
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
                                  print("Vuoi un campo con il Riscaldamento.");
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
                                  print("Vuoi un campo con le docce.");
                                },
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Distanza massima da te : "),
                              ),
                              Expanded(
                                  child: TextField(
                                controller: maxDistance,
                                keyboardType: TextInputType.number,
                              ))
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
                              Expanded(
                                  child: TextField(
                                controller: superficie,
                                keyboardType: TextInputType.text,
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Center(
                                child: RaisedButton(
                                  elevation: 5.0,
                                  onPressed: () {
                                    aggiornaFiltri();
                                    setState(() {});
                                  },
                                  padding: EdgeInsets.all(15.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(
                                          color: Colors.black26, width: 2.0)),
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
          )
        ],
      ),
    );
  }

  //legge i filtri e chiama il metodo che restituisce i circoli corrispondenti
  void aggiornaFiltri() async {
    await Geolocator.isLocationServiceEnabled().then((value) async {
      if (!value) {
        showDialog(context: context, builder: buildGeolocatorAlert1)
            .then((value) {
          Navigator.pop(context);
        });
      } else {
        await Geolocator.checkPermission().then((value) async {
          if (value == LocationPermission.denied) {
            showDialog(context: context, builder: buildGeolocatorAlert2)
                .then((value) {
              Navigator.pop(context);
            });
          } else {
            //Usiamo una callback in quanto dobbiamo ritornare sia i circoli che i campi corrispondenti
            // ( Per ogni circolo non è detto che tutti i campi siano accettabili )
            var prezzo;
            var distanza;
            clubMarkers.clear();
            try {
              if (maxPrice.text != "") {
                prezzo = int.parse(maxPrice.text);
              } else {
                prezzo = 100000000;
              }
              if (maxDistance != "") {
                distanza = int.parse(maxDistance.text);
              } else {
                distanza = 100000000;
              }
            } catch (e) {
              CustomSnackBar(context, const Text("Filtri non validi"));
              return null;
            }
            await DB_Handler_Clubs.getFilteredClubsAndCourt(
                distanza,
                prezzo,
                docce,
                riscaldamento,
                coperto,
                superficie.text,
                campiPerSport, (circoli, campi) async {
              Position clubPos;
              circoli.forEach((element) {
                clubMarkers.add(Marker(
                    markerId: MarkerId(element.id.toString()),
                    infoWindow: InfoWindow(
                        title: element.nome,
                        onTap: () {
                          //CAMBIO SCREEN sul campo element.id.toString

                          //Seleziono i campi da inviare alla schermata di scelta del campo
                          List<Court> campiDaInviare = [];
                          campi.forEach((campo) {
                            if (campo.codClub == element.id) {
                              campiDaInviare.add(campo);
                            }
                          });
                          //Invio i campi
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClubDetails(
                                      campi: campiDaInviare,
                                      circolo: element,
                                      data: data)));
                        }),
                    position: LatLng(element.lat, element.lng)));
              });

              var myPos = await Geolocator.getCurrentPosition();

              _center = LatLng(myPos.latitude, myPos.longitude);

              clubMarkers.add(Marker(
                markerId: MarkerId("tu"),
                infoWindow: InfoWindow(title: "Tu"),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
                position: _center,
              ));
              setState(() {});
            });
          }
        });
      }
    });
  }

  Widget buildGeolocatorAlert1(BuildContext context) {
    return new AlertDialog(
      title: const Text('Avviso'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              "Per visualizzare i campi sulla mappa è necessario abilitare la geolocalizzazione del dispositivo."),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            //Apre le impostazioni della geolocalizzazione
            Geolocator.openLocationSettings();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Impostazioni'),
        ),
      ],
    );
  }

  Widget buildGeolocatorAlert2(BuildContext context) {
    return new AlertDialog(
      title: const Text('Avviso'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              "Affinche l'app funzioni bisogna consentire l'accesso alla geolocalizzazione del dispositivo"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            //Apre le impostazioni della geolocalizzazione
            Geolocator.openAppSettings();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Impostazioni'),
        ),
      ],
    );
  }
}
