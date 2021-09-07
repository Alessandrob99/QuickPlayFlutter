

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickplay/ViewModel/DB_Handler_Reservations.dart';
import 'package:quickplay/models/models.dart';
import 'package:quickplay/pages/home_page.dart';
import 'package:quickplay/widgets/snackbar.dart';

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

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height*0.69) / 9;
    final double itemWidth = size.width / 4;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05 ),
            color: Colors.white,
            child: Center(
              child: Text(
                "SELEZIONA ORA INIZIO E FINE",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
            height: MediaQuery.of(context).size.height*0.71,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: (itemWidth/itemHeight),
                padding: const EdgeInsets.all(8.0),
                mainAxisSpacing: 6.0,
                crossAxisSpacing: 6.0,
                children: [
                  _buildCounterButton('6:30'),
                  _buildCounterButton('11:00'),
                  _buildCounterButton('15:30'),
                  _buildCounterButton('20:00'),
                  _buildCounterButton('7:00'),
                  _buildCounterButton('11:30'),
                  _buildCounterButton('16:00'),
                  _buildCounterButton('20:30'),
                  _buildCounterButton('7:30'),
                  _buildCounterButton('12:00'),
                  _buildCounterButton('16:30'),
                  _buildCounterButton('21:00'),
                  _buildCounterButton('8:00'),
                  _buildCounterButton('12:30'),
                  _buildCounterButton('17:00'),
                  _buildCounterButton('21:30'),
                  _buildCounterButton('8:30'),
                  _buildCounterButton('13:00'),
                  _buildCounterButton('17:30'),
                  _buildCounterButton('22:00'),
                  _buildCounterButton('9:00'),
                  _buildCounterButton('13:30'),
                  _buildCounterButton('18:00'),
                  _buildCounterButton('22:30'),
                  _buildCounterButton('9:30'),
                  _buildCounterButton('14:00'),
                  _buildCounterButton('18:30'),
                  _buildCounterButton('23:00'),
                  _buildCounterButton('10:00'),
                  _buildCounterButton('14:30'),
                  _buildCounterButton('19:00'),
                  _buildCounterButton('23:30'),
                  _buildCounterButton('10:30'),
                  _buildCounterButton('15:00'),
                  _buildCounterButton('19:30'),
                  _buildCounterButton('24:00'),
                ].map((Widget btn) {
                  return GridTile(
                      child: btn);
                }).toList()),
          ),
          Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.20,right: MediaQuery.of(context).size.width*0.20),
            padding: EdgeInsets.symmetric(vertical: 25.0),
            width: double.infinity,
            child: RaisedButton(
              elevation: 5.0,
              onPressed: (){
                initialize();
              },
              padding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(
                      color: Colors.black26, width: 2.0)),
              color: Colors.white38,
              child: Text(
                'RESETTA',
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1.5,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }


  Widget _buildCounterButton(String btn) {
    return  SizedBox(
      height: MediaQuery.of(context).size.height*0.02,
      width: MediaQuery.of(context).size.width*0.08,
      child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(
                  color: Colors.black26, width: 2.0)),
          color: buttonsColour[btn],
          child: Text(
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
              CustomSnackBar(context,const Text("Orario occupato"));
            }

          }
      ),
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

    var split =  DateTime.now().toString().split(" ");
    var oggi = split[0];



    if(oggi == splitStr[0]+"-"+splitStr[1]+"-"+splitStr[2]){
      String oraNow = ((DateTime.now().hour)).toString();
      buttonsEnabled["6:30"] = false;
      buttonsColour["6:30"] = Colors.red;
      int ora = 7;
      while(ora.toString()!=oraNow){
        buttonsEnabled[ora.toString()+":00"] = false;
        buttonsColour[ora.toString()+":00"] = Colors.red;
        buttonsEnabled[ora.toString()+":30"] = false;
        buttonsColour[ora.toString()+":30"] = Colors.red;
        ora+=1;
      }
      buttonsEnabled[ora.toString()+":00"] = false;
      buttonsColour[ora.toString()+":00"] = Colors.red;
      buttonsEnabled[ora.toString()+":30"] = false;
      buttonsColour[ora.toString()+":30"] = Colors.red;
    }



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
      CustomSnackBar(context, const Text("Orario non disponibile"));
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
      showAlertDialog(context);

    }

  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Annulla"),
      onPressed:  () {
        Navigator.of(context).pop();
        initialize();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Conferma"),
      onPressed:  () {
        Navigator.of(context).pop();
        print("Prenotazione Confermata");
        String dataStr = "";
        if(data.day.toString().length==1){
          dataStr += "0"+data.day.toString();
        }else{
          dataStr += data.day.toString();
        }
        if(data.month.toString().length==1){
          dataStr += ("-0"+data.month.toString());
        }else{
          dataStr += ("-"+data.month.toString());
        }
        dataStr += ("-"+data.year.toString());
        DB_Handler_Reservations.newReservation(dataStr, oraInizioSel, oraFineSel, campo.n_c.toString(), circolo.id.toString());
        backHomeAlert(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confermare prenotazione?"),
      content: Text("Data : "+data.day.toString()+"/"+data.month.toString()+"/"+data.year.toString()+"\nDalle "+oraInizioSel+" alle "+oraFineSel+"\nCircolo : "+circolo.nome+"\nCampo n° : "+campo.n_c.toString()),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void backHomeAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("Prenotazione Confermata"),
          actions: [
            FlatButton(
              onPressed: (){
                Navigator.pop(context, true);
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Home()));
              }, // passing true
              child: Text('Home'),
            ),
          ]
        )).then((value){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>Home()));
    });
  }

}


/*

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










 */
