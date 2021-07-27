import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import "package:quickplay/models/models.dart";


class DB_Handler_Users{

  static Firestore myRef = Firestore.instance;


  static SearchUsersByEmail(String email, callback(User returnedUser)) {
    CollectionReference users = Firestore.instance.collection('users');

    users.document(email).get().then<dynamic>((
        DocumentSnapshot snapshot) async {
      var result = snapshot.data;
      if(result!=null){
        var foundUser = User(result["nome"], result["cognome"],  result["email"],  result["password"],  result["telefono"]);
        callback(foundUser);
      }else{
        callback(null);
      }

    });
  }

  static newUser(String email,String password,String nome,String cognome,String telefono){
    var nomeSafe = nome.replaceAll(" ","");
    var cognomeSafe = cognome.replaceAll(" ", "");
    myRef.collection("users").document(email).setData({
      'email':email,
      'password':password,
      'nome':nomeSafe,
      'cognome':cognomeSafe,
      'telefono':telefono
    });
  }

}