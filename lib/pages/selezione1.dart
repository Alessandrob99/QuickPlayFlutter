import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickplay/ViewModel/DB_Handler_Courts.dart';
import 'package:quickplay/models/models.dart';
import 'package:quickplay/widgets/snackbar.dart';


import 'effettua_prenotazione.dart';

class Selezione1 extends StatefulWidget {
  const Selezione1({Key key}) : super(key: key);

  @override
  _createSelezione1 createState() => _createSelezione1();
}

class _createSelezione1 extends State<Selezione1> {
  List<String> _sports = ['Tennis', 'Calcetto', 'Paddle', 'Basket']; // Option 2
  String _selectedSport; // Option 2
  DateTime date;

  String getText() {
    if (date == null) {
      return "Data";
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "A COSA VUOI GIOCARE E QUANDO?",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 6, 117, 1),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    children: [
                      Card(
                          elevation: 2.0,
                          color: Colors.white, //Colore interno
                          shape: new RoundedRectangleBorder(
                              //Colore del bordo
                              side: new BorderSide(
                                  color: Colors.black26, width: 2.0),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Column(children: [
                            SizedBox(height: 70),
                            HeaderWidget(
                                title: "Seleziona lo sport",
                                child: DropdownButton(
                                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                                  hint: Text('Sport '),
                                  // Not necessary for Option 1
                                  value: _selectedSport,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedSport = newValue;
                                    });
                                  },
                                  items: _sports.map((location) {
                                    return DropdownMenuItem(

                                      child: new Text(location),
                                      value: location,
                                    );
                                  }).toList(),
                                )),
                            SizedBox(height: 100),
                            Container(
                                color: Colors.white,
                                child: Expanded(
                                  child: ButtonHeaderWidget(
                                    title: "Seleziona la data",
                                    text: getText(),
                                    onClicked: () => pickDate(context),
                                  ),
                                )),
                            SizedBox(height: 70.0),
                            Container(
                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.20,right: MediaQuery.of(context).size.width*0.20),
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              width: double.infinity,
                              child: RaisedButton(
                                elevation: 5.0,
                                  onPressed: () async {
                                    if(date==null || _selectedSport==null){
                                      //Errore
                                      CustomSnackBar(context, const Text("Inserisci tutti i campi"));
                                    }else{
                                      //Trova i campi per quello sport
                                      List<Court> campiPerSport = await DB_Handler_Courts.getCourtsBySport(_selectedSport.toLowerCase());
                                      //cambia page
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context)=>EffettuaPrenotazione(campiPerSport: campiPerSport,data: date,)));
                                    }
                                  },
                                padding: EdgeInsets.all(10.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                        color: Colors.black26, width: 2.0)),
                                color: Color.fromRGBO(54, 64, 255, 1),
                                child: Text(
                                  'Conferma',
                                  style: TextStyle(
                                    color: Colors.black,
                                    letterSpacing: 1.5,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ),
                            )
                          ])),
                    ],
                  ),
                ],
              ),
            )));

    /*Column(children: <Widget>[
      Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: (MaterialApp(
            home: Scaffold(
              body: Center(
                child: DropdownButton(
                  hint: Text('Sport '), // Not necessary for Option 1
                  value: _selectedSport,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedSport = newValue;
                    });
                  },
                  items: _sports.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
            ),
          ))),
      Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.4,
          child: ButtonWithHeader(
            title: "Data",
            text: getText(),
            onClicked: ()=> pickDate(context),
          ),

          ),
      Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.2,
        child: ElevatedButton(

          child: FittedBox(

            child:
            Text("Conferma"),
          ),
          onPressed: () async {
            if(date==null || _selectedSport==null){
              //Errore
              print("Inserisci tutti i campi!!!");
            }else{
              //Trova i campi per quello sport
              List<Court> campiPerSport = await DB_Handler_Courts.getCourtsBySport(_selectedSport.toLowerCase());
              //cambia page

              Navigator.push(context,
              MaterialPageRoute(builder: (context)=>EffettuaPrenotazione(campiPerSport: campiPerSport,data: date,)));

            }
          },
        ),
      )
    ]);*/
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final lastDate = DateTime(
        DateTime.now().year, DateTime.now().month + 2, DateTime.now().day);
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      lastDate: lastDate,
      firstDate: DateTime.now(),
    );

    if (newDate == null) return;

    setState(() {
      date = newDate;
    });
  }
}

class ButtonHeaderWidget extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onClicked;

  const ButtonHeaderWidget({
    Key key,
    @required this.title,
    @required this.text,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => HeaderWidget(
        title: title,
        child: ButtonWidget(
          text: text,
          onClicked: onClicked,
        ),
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key key,
    @required this.text,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.15,
          right: MediaQuery.of(context).size.width * 0.15),
      child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
              width: MediaQuery.of(context).size.width * 0.7, height: 30),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(40),
              primary: Colors.white,
            ),
            child: FittedBox(
              child: Text(
                text,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            onPressed: onClicked,
          )));
}

class HeaderWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const HeaderWidget({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );
}
