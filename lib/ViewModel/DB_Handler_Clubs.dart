import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickplay/models/models.dart';
import 'package:geolocator/geolocator.dart';


class DB_Handler_Clubs{

  static Firestore myRef = Firestore.instance;


  static Future<List<Club>> getAllClubsInRange(int range,LatLng position) async{
    List<Club> clubsInRange = [];
    var data = await myRef.collection("clubs").getDocuments();
    data.documents.forEach((element) {
      double lat = element.data["posizione"].latitude;
      double lng = element.data["posizione"].longitude;
      if(Geolocator.distanceBetween(lat, lng, position.latitude, position.longitude)<=(range*1000)){
        clubsInRange.add(Club(
            element.data["id_circolo"],
            element.data["nome"],
            element.data["telefono"],
            element.data["email"],
            element.data["docce"],
            lat,lng));
      }
    });
    return clubsInRange;
  }

  static Future<Club> getClubById(String id) async{
    var data;
    data = await myRef.collection("clubs").document(id).get();
    var record = data.data;
    return Club(record["id_circolo"], record["nome"], record["telefono"], record["email"], record["docce"],record["posizione"].latitude, record["posizione"].longitude);
  }

  static Future<void> getFilteredClubsAndCourt(int distanza,int prezzo,bool docce, bool riscaldamento, bool coperto, String superficie , callback(List<Club> circoli, List<Court> campi)) async {
    var myPosition;
    try {
      LocationPermission permission = await Geolocator.checkPermission();
    }catch(e){
      print("Errore : "+e.code);
    }

    myPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);


    List<Club> clubsInRange = await getAllClubsInRange(distanza, LatLng(myPosition.latitude, myPosition.longitude));


    callback(clubsInRange,null);
  }

}