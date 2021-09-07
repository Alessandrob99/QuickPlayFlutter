

import 'package:cloud_firestore/cloud_firestore.dart';
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
        var foundUser = User(result["nome"], result["cognome"],  result["email"],  result["telefono"]);
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
      'nome':nomeSafe.toLowerCase(),
      'cognome':cognomeSafe.toLowerCase(),
      'telefono':telefono
    });
  }


  static applyMod(String nome,String cognome,String telefono,callBack()) async {
    if(nome=="") nome = Auth_Handler.CURRENT_USER.nome;
    if(cognome=="") cognome = Auth_Handler.CURRENT_USER.cognome;
    if(telefono=="") telefono = Auth_Handler.CURRENT_USER.telefono;
    await  myRef.collection("users").document(Auth_Handler.CURRENT_USER.email).updateData({
      'email':Auth_Handler.CURRENT_USER.email,
      'nome':nome.toLowerCase(),
      'cognome':cognome.toLowerCase(),
      'telefono':telefono
    });
    Auth_Handler.CURRENT_USER.nome = nome;
    Auth_Handler.CURRENT_USER.cognome = cognome;
    Auth_Handler.CURRENT_USER.telefono = telefono;
    callBack();
  }

  static Future<List<User>> searchUsers(String nome,String cognome) async{
    var usersList = await myRef.collection("users").getDocuments();
    List<User> returnedUsers = [];
    if(nome!="" && cognome!=""){
      usersList.documents.forEach((element) {
        if(element.data["nome"]==nome && element.data["cognome"]==cognome){
          returnedUsers.add(User(element.data["nome"],element.data["cognome"],element.documentID,element.data["telefono"]));
        }
      });
    }else{
      if(nome!=""){
        usersList.documents.forEach((element) {
          if(element.data["nome"]==nome){
            returnedUsers.add(User(element.data["nome"],element.data["cognome"],element.documentID,element.data["telefono"]));
          }
        });
      }
      if(cognome!=""){
        usersList.documents.forEach((element) {
          if(element.data["cognome"]==cognome){
            returnedUsers.add(User(element.data["nome"],element.data["cognome"],element.documentID,element.data["telefono"]));
          }
        });
      }

    }
    return returnedUsers;

  }


  static Future<List<Prenotazione>> getReservations(String email) async {
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