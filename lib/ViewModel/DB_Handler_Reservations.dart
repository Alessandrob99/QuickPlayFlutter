
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickplay/ViewModel/Auth_Handler.dart';
import 'package:quickplay/ViewModel/DB_Handler_Clubs.dart';
import 'package:quickplay/models/models.dart';

class DB_Handler_Reservations {

  static Firestore myRef = Firestore.instance;

  static getReservationLayoutInfo(Prenotazione prenotazione) async{
      String codice = decrypt(prenotazione.id, 15);
      var codSplit = codice.split("&");
      String oraFine = prenotazione.oraFine.hour.toString()+":"+prenotazione.oraFine.minute.toString();

      Club _circolo =  await DB_Handler_Clubs.getClubById(codSplit[0]);

      return LayoutInfo(_circolo.nome, codSplit[1], codSplit[2], codSplit[3], oraFine, prenotazione.id);
  }


  static void getListOfReservations(String giorno,int campo,int circolo,callback(List<Prenotazione> prenotazioni)) async{
    String reservationDocument = circolo.toString()+"-"+campo.toString()+"-"+giorno;
    var records = await myRef.collection("prenotazione").document(reservationDocument).collection("prenotazioni").getDocuments();
    List<Prenotazione> prenotazioni = [];
    records.documents.forEach((element) {
      DocumentReference ref = element.data['prenotatore'] as DocumentReference;
      Timestamp timestamp = element.data['oraInizio'];
      DateTime oraInizio = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
      timestamp = element.data['oraFine'];
      DateTime oraFine = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
      prenotazioni.add(Prenotazione(element.documentID, ref.documentID , oraInizio, oraFine));
    });
    callback(prenotazioni);
  }

  static Future<void> newReservation(String data,String oraInizio,String oraFine,String n_campo,String id_circolo) async {

    String uncodedID = id_circolo+"&"+n_campo+"&"+data+"&"+oraInizio;
    String codedID = crypt(uncodedID, 15);

    var giornoSplit = data.split("-");
    String giornoFormatoAmericano = giornoSplit[2]+"-"+giornoSplit[1]+"-"+giornoSplit[0];


    DateTime dtInizio = DateTime.parse(giornoFormatoAmericano+" "+oraInizio);
    DateTime dtFine = DateTime.parse(giornoFormatoAmericano+" "+oraFine);
    Timestamp tsInizio = Timestamp.fromMillisecondsSinceEpoch(dtInizio.millisecondsSinceEpoch);
    Timestamp tsFine = Timestamp.fromMillisecondsSinceEpoch(dtFine.millisecondsSinceEpoch);
    DocumentReference prenotatore = myRef.document("/users/"+Auth_Handler.CURRENT_USER.email);

    var doc = await myRef.collection("prenotazione").document(id_circolo.toString()+"-"+n_campo.toString()+"-"+data).get();
    if(doc.exists){
      //Registra la prenotazione
    }else{
      //Crea il documento (compreso il dummy text) e registra la prenotazione

    }

  }


  static bool checkAvailability(String giorno,String oraInizio,String oraFine,List<Prenotazione> prenotazioni){
    bool result = false;
    DateTime dtInizio = DateTime.parse(giorno+" "+oraInizio);
    DateTime dtFine = DateTime.parse(giorno+" "+oraFine);

    prenotazioni.forEach((element) {
      if(element.oraInizio.millisecondsSinceEpoch<dtFine.millisecondsSinceEpoch && element.oraFine.millisecondsSinceEpoch>dtInizio.millisecondsSinceEpoch){ result = true;}
    });
    return result;

  }

  static String crypt(String text, int shift){
    List<int> codeStr = [];
    int xxx = "1".codeUnitAt(0);
    int firstCharCode = "A".codeUnitAt(0);
    String newChar = String.fromCharCode(64);
    int offset = ("z".codeUnitAt(0) - "A".codeUnitAt(0)) +1;
    for(int i =0;i<text.length;i++){
      int oldCharCode = text[i].toString().codeUnitAt(0);
      //int oldIdxInAlphabet = oldCharCode - firstCharCode;
      int newIdxInAlphabet = (oldCharCode +shift);
      codeStr.add(newIdxInAlphabet);
    }
    String result = Utf8Decoder().convert(codeStr);

    return  result;
  }

  static String decrypt(String cryptedText, shift){
    return crypt(cryptedText, (-1)*shift);
  }


}