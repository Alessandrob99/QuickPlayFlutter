import 'dart:ffi';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:quickplay/models/models.dart";

import 'Auth_Handler.dart';


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


  static applyMod(String nome,String cognome,String telefono,callBack()) async {
    if(nome=="") nome = Auth_Handler.CURRENT_USER.nome;
    if(cognome=="") cognome = Auth_Handler.CURRENT_USER.cognome;
    if(telefono=="") telefono = Auth_Handler.CURRENT_USER.telefono;
    await  myRef.collection("users").document(Auth_Handler.CURRENT_USER.email).updateData({
      'email':Auth_Handler.CURRENT_USER.email,
      'password':Auth_Handler.CURRENT_USER.password,
      'nome':nome.toLowerCase(),
      'cognome':cognome.toLowerCase(),
      'telefono':telefono
    });
    Auth_Handler.CURRENT_USER.nome = nome;
    Auth_Handler.CURRENT_USER.cognome = cognome;
    Auth_Handler.CURRENT_USER.telefono = telefono;
    callBack();
  }


  //DA TESTARE
  static getReservations(String email) async {
      List<Prenotazione> prenotazioni = [];
      var prenotazioniData = await myRef.collection("users").document(email).collection("prenotazioni").getDocuments();
      var data =  prenotazioniData.documents;
      data.forEach((element) {
        DocumentReference prenotatore = element.data["prenotatore"];
        Timestamp timestamp = element.data["oraInizio"];
        var millis = (timestamp.seconds * 1000 + timestamp.nanoseconds/1000000).toInt();
        var datainizio = DateTime.fromMillisecondsSinceEpoch(millis);
        timestamp = element.data["oraFine"];
        millis = (timestamp.seconds * 1000 + timestamp.nanoseconds/1000000).toInt();
        var dataFine = DateTime.fromMillisecondsSinceEpoch(millis);
        prenotazioni.add(Prenotazione(
          element.documentID,
          prenotatore.documentID,
          datainizio,
          dataFine
        ));
      });
      return prenotazioni;
  }


}