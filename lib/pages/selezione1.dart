
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickplay/ViewModel/DB_Handler_Courts.dart';
import 'package:quickplay/models/models.dart';
import 'package:quickplay/pages/effettua_prenotazione.dart';

class Selezione1 extends StatefulWidget {
  const Selezione1({Key key}) : super(key: key);

  @override
  _createSelezione1 createState() => _createSelezione1();
}

class _createSelezione1 extends State<Selezione1> {
  List<String> _sports = ['Tennis', 'Calcetto', 'Paddle', 'Basket']; // Option 2
  String _selectedSport; // Option 2
  DateTime date;

  String getText(){
    if(date == null){
      return "Seleziona una data";
    }else{
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
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
    ]);
  }

  Future pickDate(BuildContext context) async{
    final initialDate = DateTime.now();
    final lastDate = DateTime(DateTime.now().year,DateTime.now().month+2,DateTime.now().day);
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
      lastDate: lastDate,
      firstDate: DateTime.now(),
    );

    if(newDate==null) return;

    setState(() {
      date = newDate;
    });


  }


}

class ButtonWithHeader extends StatelessWidget{
  final String title;
  final String text;
  final VoidCallback onClicked;

  const ButtonWithHeader({
    Key key,
    @required this.title,
    @required this.text,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(40),
      primary: Colors.grey,
    ),

    child: FittedBox(
      child: Text(
        text,style: TextStyle(fontSize: 20,color: Colors.black),
      ),
    ),
    onPressed: onClicked,
  );

}
