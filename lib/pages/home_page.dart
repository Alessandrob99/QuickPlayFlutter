import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:quickplay/ViewModel/Auth_Handler.dart';
import 'package:quickplay/ViewModel/DB_Handler_Reservations.dart';
import 'package:quickplay/ViewModel/DB_Handler_Users.dart';
import 'package:quickplay/models/models.dart';
import 'package:quickplay/pages/Partecipa.dart';
import 'package:quickplay/pages/selezione1.dart';
import 'package:quickplay/pages/visualizza_prenotazioni.dart';
import 'package:quickplay/utils/dialog_helper.dart';


class Home extends KFDrawerContent {
  Home({Key key}) ;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}

class _MyHomePageState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
      primary: false,
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(85.0),
        child: AppBar(
          backgroundColor: Colors.indigo,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu_rounded),
              onPressed: widget.onMenuPressed,
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 200.0,
                width: double.infinity,
                color: Colors.indigo, //Colore in basso del drawer menu
              ),
              Positioned(
                //Cerchi del layout
                  bottom: 180,
                  left: -40,
                  child: Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        color: Colors.yellowAccent[100].withOpacity(0.1)),
                  )),
              Positioned(
                //Cerchi del layout
                  top: -120,
                  left: 100,
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        color: Colors.yellowAccent[100].withOpacity(0.1)),
                  )),
              Positioned(
                //Cerchi del layout
                  top: -50,
                  left: 0,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.yellowAccent[100].withOpacity(0.1)),
                  )),
              Positioned(
                //Cerchi del layout
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(75),
                        color: Colors.yellowAccent[100].withOpacity(0.1)),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    //Distanza dalla top bar al "Benvenuto"
                    height: 70.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Benvenuto",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    //Distanza tra il "Benvenuto" ed il blocco "Nome-Cognome"
                    child: Text(
                      "",
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        elevation: 2.0,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                Auth_Handler.CURRENT_USER.nome.capitalize()+"  "+Auth_Handler.CURRENT_USER.cognome.capitalize(),
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          getGridView()
        ],
      ),
      ),
      );
  }





  Widget getGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2, //Numero di elementi nella riga
      primary: false, //Il primo ha il distanziamento a sinistra di default
      childAspectRatio: (MediaQuery
          .of(context)
          .size
          .width - 60 / 2) / 280,
      children: <Widget>[
        //il "true" distanzia a destra
        //il "false" distanzia a sinistra
        createTile(0,_selectedIndex,false, 'Effettua Prenotazione', Colors.purple, Icons.sports_football),
        createTile(1,_selectedIndex,true, 'Visualizza Prenotazione', Colors.yellow, Icons.local_activity),
        createTile(2,_selectedIndex,false, 'Unisciti alla Prenotazione', Colors.red, Icons.app_settings_alt),
      ],
    );
  }
  int _selectedIndex = -1;


  Widget createTile(int index,int selectedIndex,bool isEven, String title, Color color, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(
          left:  isEven?10:20, right: isEven?20:10, top: 10, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: () async {
            _selectedIndex = index;

            /**
             * CREA PRENOTAZIONE
             */
            if(_selectedIndex == 0)
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Selezione1()));
            }




            /**
             * VISUALIZZA PRENOTAZIONI
             */
            if(_selectedIndex == 1) //Visualizza prenotazioni
                {
              //Leggo i dati
              List<LayoutInfo> layoutData = [];
              var prenotazioni = await DB_Handler_Users.getReservations(Auth_Handler.CURRENT_USER.email);
              await Future.forEach(prenotazioni,(element) async {
                LayoutInfo info = await DB_Handler_Reservations.getReservationLayoutInfo(element );
                layoutData.add(info);

              });

              Navigator.push(context, MaterialPageRoute(builder: (context) => VisualizzaPrenotazioni(layoutData)));
            }


            /**
             * UNISCITI A  PRENOTAZIONE
             */
            if(_selectedIndex == 2){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Partecipa()));
            }

            setState((){});
          },
          child: Material(
            elevation: 3.0,
            color: _selectedIndex==index?Colors.orange:Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(icon,color: _selectedIndex==index?Colors.white:color,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _selectedIndex==index?Colors.white:Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:2.0),
                        child: Container(
                          height: 3.0,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            color: _selectedIndex==index?Colors.orange:color, //Colore quando attivi un bottone
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return DialogHelper.exit(context);
  }

}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
