import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:quickplay/ViewModel/DB_Handler_Clubs.dart';
import 'package:quickplay/widgets/snackbar.dart';

import 'ClubSelection.dart';
import 'home_page_menu.dart';

class Circoli extends KFDrawerContent {
  Circoli({
    Key key,
  });

  @override
  _Circoli createState() => _Circoli();
}

class _Circoli extends State<Circoli> with SingleTickerProviderStateMixin {
  Set<Marker> clubMarkers = Set();
  LatLng _center = LatLng(42.413951448997125, 12.436653926777424);
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<bool> onBackPressed() {
    return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return DrawerScreen();
      },
    ), (route) => false);
  }


  @override
  Widget build(BuildContext context) {
    if (clubMarkers.isEmpty) {
      loadMap();
    }
    return WillPopScope(
      onWillPop: onBackPressed,
      child:Scaffold(
      appBar: AppBar(
        title: Text(
          "Circoli Affiliati",
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: onBackPressed,
          ),
        ),
      ),
      body: Stack(children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          markers: clubMarkers,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 6.0,
          ),
        ),
      ]),
    ));
  }

  Future<void> loadMap() async {
    var circoli = await DB_Handler_Clubs.getAllClubs();
    circoli.forEach((element) {
      clubMarkers.add(Marker(
          markerId: MarkerId(element.id.toString()),
          infoWindow: InfoWindow(
            title: element.nome,
          ),
          position: LatLng(element.lat, element.lng)));
    });

    if (circoli.isEmpty) {
      CustomSnackBar(context, const Text("Nessun campo trovato."));
    }
    setState(() {

    });
  }
}
