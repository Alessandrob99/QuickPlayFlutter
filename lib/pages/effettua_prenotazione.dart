import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EffettuaPrenotazione extends StatefulWidget {
  const EffettuaPrenotazione({Key key}) : super(key: key);


  @override
  _EffettuaPrenotazione createState() => _EffettuaPrenotazione();
}

class _EffettuaPrenotazione extends State<EffettuaPrenotazione> {

  GoogleMapController mapController;
  final LatLng _center = const LatLng(43.586751779797915, 13.51659500105265);


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }

}