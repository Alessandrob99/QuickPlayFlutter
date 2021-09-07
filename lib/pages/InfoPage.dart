import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:quickplay/ViewModel/DB_Handler_Clubs.dart';
import 'package:quickplay/widgets/snackbar.dart';

import 'ClubSelection.dart';
import 'home_page_menu.dart';

class Info extends KFDrawerContent {
  Info({
    Key key,
  });

  @override
  _Info createState() => _Info();
}

class _Info extends State<Info> with SingleTickerProviderStateMixin {


  Future<bool> onBackPressed() {
    return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return DrawerScreen();
      },
    ), (route) => false);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            leading: Builder(
              builder: (context) =>
                  IconButton(
                    icon: Icon(Icons.arrow_back_outlined),
                    onPressed: onBackPressed,
                  ),
            ),
          ),
          body: Column(
            children: [
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03,),
              Container(
                child: Center(
                  child: Text(
                    "Informazioni App",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    scrollDirection: Axis.vertical, //.horizontal
                    child: Center(
                      widthFactor: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9,
                      child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            text: "Con ",
                            children: [
                              TextSpan(
                                  style: TextStyle(color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                  text: ("QuickPlay ")
                              ),
                              TextSpan(
                                  style: TextStyle(color: Colors.black,
                                      fontSize: 18),
                                  text: ("abbiamo intenzione di offrire agli utenti uno strumento rapido ed efficiente per effettuare prenotazioni presso campi sportivi.\n"
                                      "\nAccedendo dalla home page alla sezione '")
                              ),
                              TextSpan(
                                style: TextStyle(color: Colors.red,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                                text: ("Effettua Prenotazione"),
                              ),
                              TextSpan(
                                  style: TextStyle(color: Colors.black,
                                      fontSize: 18),
                                  text: ("' l'utente sarà in grado ,dopo aver specificato la data e lo sport che intende praticare, di ottenere "
                                      "una lista di circoli che presentano campi ai quali l'utente potrebbe essere interessato.\nCliccando poi sulla scheda di uno di questi campi sarà possibile andare a "
                                      "visualizzare gli orari disponibili per piazzare la propria prenotazione.\n\nLa sezione '")
                              ),
                              TextSpan(
                                style: TextStyle(color: Colors.blue,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                                text: ("Partecipa a prenotazione"),
                              ),
                              TextSpan(
                                  style: TextStyle(color: Colors.black,
                                      fontSize: 18),
                                  text: ("' invece consentirà di unirsi a prenotazioni già registrate da "
                                      "altri utente; per far ciò è richiesto un codice relativo alla prenotazione che dovrà essere comunicato dall'utente che ha effettuato la prenotazione.\n"
                                      "\nLa sezione '")
                              ),
                              TextSpan(
                                style: TextStyle(color: Colors.green,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                                text: ("Le mie prenotazioni"),
                              ),
                              TextSpan(
                                  style: TextStyle(color: Colors.black,
                                      fontSize: 18),
                                  text: ("' invece è adibita alla gestione delle prenotazioni effettuate.\nCon gestione si intente la visualizzazione delle informazioni e la cancellazione.")
                              ),
                            ],
                          )
                      ),

                    ),
                  ),
                ),
              )

            ]
            ,
          )
          ,
        )
    );
  }


}
