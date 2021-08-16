import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickplay/models/models.dart';


class DB_Handler_Courts{

  static Firestore myRef = Firestore.instance;


  static Future<List<Court>> getCourtsBySport(String sport) async {
    List<Court> campiPerSport = [];
    var data = await myRef.collection("campo").getDocuments();
    data.documents.forEach((element) {
      String sportString = element.data["sport"];
      var stringSplit = sportString.split("-");
      if(stringSplit.contains(sport)){
        DocumentReference club = element.data["id_circolo"];
        campiPerSport.add(Court(
          element.data["n_campo"],
          int.parse(club.documentID),
          element.data["superficie"],
          element.data["sport"],
          element.data["prezzo"],
          element.data["riscaldamento"],
          element.data["coperto"]
        ));
      }
    });
    return campiPerSport;
  }


}