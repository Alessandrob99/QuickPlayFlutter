

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickplay/ViewModel/DB_Handler_Reservations.dart';
import 'package:quickplay/models/models.dart';

class SelezioneOrario extends StatefulWidget {
  const SelezioneOrario({Key key, this.campo, this.circolo, this.data})
      : super(key: key);
  @override
  final Court campo;
  final Club circolo;
  final DateTime data;

  _SelezioneOrario createState() => _SelezioneOrario(campo, circolo, data);
}

class _SelezioneOrario extends State<SelezioneOrario> {
  Club circolo;
  Court campo;
  DateTime data;
  bool flag = false;
  bool clickFlag = false;

  String oraInizioSel;
  String oraFineSel;

  _SelezioneOrario(this.campo, this.circolo, this.data);

  List<Prenotazione> prenotazioni= [];



  Map<String,Color> buttonsColour = {
    '6:30':Colors.red,
    '7:00':Colors.red,
    '7:30':Colors.red,
    '8:00':Colors.red,
    '8:30':Colors.red,
    '9:00':Colors.red,
    '9:30':Colors.red,
    '10:00':Colors.red,
    '10:30':Colors.red,
    '11:00':Colors.red,
    '11:30':Colors.red,
    '12:00':Colors.red,
    '12:30':Colors.red,
    '13:00':Colors.red,
    '13:30':Colors.red,
    '14:00':Colors.red,
    '14:30':Colors.red,
    '15:00':Colors.red,
    '15:30':Colors.red,
    '16:00':Colors.red,
    '16:30':Colors.red,
    '17:00':Colors.red,
    '17:30':Colors.red,
    '18:00':Colors.red,
    '18:30':Colors.red,
    '19:00':Colors.red,
    '19:30':Colors.red,
    '20:00':Colors.red,
    '20:30':Colors.red,
    '21:00':Colors.red,
    '21:30':Colors.red,
    '22:00':Colors.red,
    '22:30':Colors.red,
    '23:00':Colors.red,
    '23:30':Colors.red,
    '24:00':Colors.red
  };

  Map<String,bool> buttonsEnabled = {
  '6:30':false,
  '7:00':false,
  '7:30':false,
  '8:00':false,
  '8:30':false,
  '9:00':false,
  '9:30':false,
  '10:00':false,
  '10:30':false,
  '11:00':false,
  '11:30':false,
  '12:00':false,
  '12:30':false,
  '13:00':false,
  '13:30':false,
  '14:00':false,
  '14:30':false,
  '15:00':false,
  '15:30':false,
  '16:00':false,
  '16:30':false,
  '17:00':false,
  '17:30':false,
  '18:00':false,
  '18:30':false,
  '19:00':false,
  '19:30':false,
  '20:00':false,
  '20:30':false,
  '21:00':false,
  '21:30':false,
  '22:00':false,
  '22:30':false,
  '23:00':false,
  '23:30':false,
  '24:00':false
  };

  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    if(!flag){
      initialize();
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height*0.8,
      width: MediaQuery.of(context).size.width,
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Row(
           children: [
             _buildCounterButton('6:30'),
             _buildCounterButton('11:00'),
             _buildCounterButton('15:30'),
             _buildCounterButton('20:00'),
           ],
         ),
         Row(
           children: [
             _buildCounterButton('7:00'),
             _buildCounterButton('11:30'),
             _buildCounterButton('16:00'),
             _buildCounterButton('20:30'),
           ],
         ),
         Row(
           children: [
             _buildCounterButton('7:30'),
             _buildCounterButton('12:00'),
             _buildCounterButton('16:30'),
             _buildCounterButton('21:00'),
           ],
         ),
         Row(
           children: [
             _buildCounterButton('8:00'),
             _buildCounterButton('12:30'),
             _buildCounterButton('17:00'),
             _buildCounterButton('21:30'),
           ],
         ),
         Row(
           children: [
             _buildCounterButton('8:30'),
             _buildCounterButton('13:00'),
             _buildCounterButton('17:30'),
             _buildCounterButton('22:00'),
           ],
         ),Row(
           children: [
             _buildCounterButton('9:00'),
             _buildCounterButton('13:30'),
             _buildCounterButton('18:00'),
             _buildCounterButton('22:30'),
           ],
         ),Row(
           children: [
             _buildCounterButton('9:30'),
             _buildCounterButton('14:00'),
             _buildCounterButton('18:30'),
             _buildCounterButton('23:00'),
           ],
         ),Row(
           children: [
             _buildCounterButton('10:00'),
             _buildCounterButton('14:30'),
             _buildCounterButton('19:00'),
             _buildCounterButton('23:30'),
           ],
         ),Row(
           children: [
             _buildCounterButton('10:30'),
             _buildCounterButton('15:00'),
             _buildCounterButton('19:30'),
             _buildCounterButton('24:00'),
           ],
         ),
         Row(
            children: [
              RaisedButton(
                  child: Text("Annulla"),
                  onPressed: initialize
              ),
              RaisedButton(
                  child: Text("Conferma"),
                  onPressed: conferma
              )
            ],
         )
       ],
     ),
    );
  }


  Widget _buildCounterButton(String btn) {
    return new RaisedButton(
      color: buttonsColour[btn],
      child: new Text(
          btn
      ),
      onPressed: (){
        if(buttonsEnabled[btn]){
          if(!clickFlag){
            firstClick(btn);
          }else{
            secondClick(btn);
          }
        }else{
          print("Orario occupato");
        }

      }
    );
  }

  // funge anche da reset
  void initialize() {

    buttonsEnabled = {
      '6:30':true,
      '7:00':true,
      '7:30':true,
      '8:00':true,
      '8:30':true,
      '9:00':true,
      '9:30':true,
      '10:00':true,
      '10:30':true,
      '11:00':true,
      '11:30':true,
      '12:00':true,
      '12:30':true,
      '13:00':true,
      '13:30':true,
      '14:00':true,
      '14:30':true,
      '15:00':true,
      '15:30':true,
      '16:00':true,
      '16:30':true,
      '17:00':true,
      '17:30':true,
      '18:00':true,
      '18:30':true,
      '19:00':true,
      '19:30':true,
      '20:00':true,
      '20:30':true,
      '21:00':true,
      '21:30':true,
      '22:00':true,
      '22:30':true,
      '23:00':true,
      '23:30':true,
      '24:00':false
    };
    buttonsColour = {
      '6:30':Colors.white,
      '7:00':Colors.white,
      '7:30':Colors.white,
      '8:00':Colors.white,
      '8:30':Colors.white,
      '9:00':Colors.white,
      '9:30':Colors.white,
      '10:00':Colors.white,
      '10:30':Colors.white,
      '11:00':Colors.white,
      '11:30':Colors.white,
      '12:00':Colors.white,
      '12:30':Colors.white,
      '13:00':Colors.white,
      '13:30':Colors.white,
      '14:00':Colors.white,
      '14:30':Colors.white,
      '15:00':Colors.white,
      '15:30':Colors.white,
      '16:00':Colors.white,
      '16:30':Colors.white,
      '17:00':Colors.white,
      '17:30':Colors.white,
      '18:00':Colors.white,
      '18:30':Colors.white,
      '19:00':Colors.white,
      '19:30':Colors.white,
      '20:00':Colors.white,
      '20:30':Colors.white,
      '21:00':Colors.white,
      '21:30':Colors.white,
      '22:00':Colors.white,
      '22:30':Colors.white,
      '23:00':Colors.white,
      '23:30':Colors.white,
      '24:00':Colors.red
    };

    var splitStr = data.toString().split(" ");
    splitStr = splitStr[0].split("-");
    String giorno = splitStr[2]+"-"+splitStr[1]+"-"+splitStr[0];
    DB_Handler_Reservations.getListOfReservations(giorno, campo.n_c, circolo.id,(returnedPrenotazioni){
      returnedPrenotazioni.forEach((element) {
        String ora = element.oraInizio.hour.toString();
        String minuti;

        if(element.oraInizio.minute.toString().length==1){
          minuti = "0"+element.oraInizio.minute.toString();
        }else{
          minuti = element.oraInizio.minute.toString();
        }
        String oraFine = element.oraFine.hour.toString();
        String minutiFine;
        if(element.oraFine.minute.toString().length==1){
          minutiFine = "0"+element.oraFine.minute.toString();
        }else{
          minutiFine = element.oraFine.minute.toString();
        }
        if(oraFine+":"+minutiFine =="23:59"){
          buttonsEnabled["24:00"] = false;
          buttonsColour["24:00"] = Colors.red;
        }else{
          buttonsEnabled[oraFine+":"+minutiFine] = false;
          buttonsColour[oraFine+":"+minutiFine] = Colors.red;
        }


        while(ora+":"+minuti != oraFine+":"+minutiFine){
          buttonsEnabled[ora+":"+minuti] = false;
          buttonsColour[ora+":"+minuti] = Colors.red;
          if(minuti=="00") {
            minuti = "30";
          }else{
            if(ora=="23"){
              minuti="59";
            }else{
              int oraInt = int.parse(ora)+1;
              ora = oraInt.toString();
              minuti = "00";
            }
          }
        }

      });
      setState(() {
        prenotazioni = returnedPrenotazioni;
        flag = true;
        clickFlag = false;
      });
    });

  }

  void firstClick(String btn){
    clickFlag = true;
    oraInizioSel = btn;
    buttonsEnabled["24:00"] = true;
    buttonsColour["24:00"] = Colors.white;

    String ora;
    String minuti;

    //Sblocchiamo gli orari iniziali per poterli selezionare poi come orari finali
    prenotazioni.forEach((element) {
      if(element.oraInizio.minute.toString().length ==1){ minuti = "0"+element.oraInizio.minute.toString();
      }else{ minuti = element.oraFine.minute.toString();}
      ora = element.oraInizio.hour.toString();
      buttonsEnabled[ora+":"+minuti] = true;
      buttonsColour[ora+":"+minuti] = Colors.white;
    });

    //Blocchiamo gli orari fino a quello selezionato

    ora = "6";
    minuti = "30";
    while(ora+":"+minuti != btn){
      buttonsEnabled[ora+":"+minuti] = false;
      buttonsColour[ora+":"+minuti] = Colors.red;
      if(minuti=="00") {
        minuti = "30";
      }else{
        if(ora=="23"){
          minuti="59";
        }else{
          int oraInt = int.parse(ora)+1;
          ora = oraInt.toString();
          minuti = "00";
        }
      }
    }
    buttonsColour[btn] = Colors.cyan;
    buttonsEnabled[btn] = false;

    setState(() {

    });
  }

  void secondClick(String btn){
    var dateSplit = data.toString().split(" ");
    String giorno = dateSplit[0];
    String oraFine;
    if(btn=="24:00"){oraFine = "23:59";}else{oraFine = btn;}
    bool result = DB_Handler_Reservations.checkAvailability(giorno, oraInizioSel, oraFine, prenotazioni);
    if(result){
      print("Collisione!");
      initialize();
    }else{
      oraFineSel = oraFine;
      var orainizioSplit = oraInizioSel.split(":");
      String ora = orainizioSplit[0];
      String minuti = orainizioSplit[1];
      while(ora+":"+minuti != oraFine){
        buttonsEnabled[ora+":"+minuti] = false;
        buttonsColour[ora+":"+minuti] = Colors.cyan;
        if(minuti=="00") {
          minuti = "30";
        }else{
          if(ora=="23"){
            minuti="59";
          }else{
            int oraInt = int.parse(ora)+1;
            ora = oraInt.toString();
            minuti = "00";
          }
        }
      }
      if(ora+":"+minuti == "23:59"){
        buttonsEnabled["24:00"] = false;
        buttonsColour["24:00"] = Colors.cyan;
      }else{
        buttonsEnabled[ora+":"+minuti] = false;
        buttonsColour[ora+":"+minuti] = Colors.cyan;
      }

      setState(() {

      });
      //Richiesta/Riepilogo e richiesta di conferma
    }

  }

  void conferma(){

  }


}
