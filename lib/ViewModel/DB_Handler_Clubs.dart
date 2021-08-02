import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickplay/models/models.dart';

class DB_Handler_Clubs{

  static Firestore myRef = Firestore.instance;


  static Future<Club> getClubById(String id) async{
    var data;
    data = await myRef.collection("clubs").document(id).get();
    var record = data.data;
    return Club(record["id_circolo"].toString(), record["nome"], record["telefono"], record["email"], record["docce"],record["posizione"].latitude, record["posizione"].longitude);
  }


}