import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickplay/ViewModel/DB_Handler_Courts.dart';
import 'package:quickplay/models/models.dart';
import 'package:quickplay/widgets/snackbar.dart';


import 'ClubSelection.dart';
import 'home_page_menu.dart';

class Selezione1 extends StatefulWidget {
  const Selezione1({Key key}) : super(key: key);

  @override
  _createSelezione1 createState() => _createSelezione1();
}

class _createSelezione1 extends State<Selezione1> {
  List<String> _sports = [
    "Atletica",
    "Badminton",
    "Basket",
    "Bocce",
    "Calcetto",
    "Golf",
    "Nuoto",
    "Padel",
    "Paintball",
    "Squash",
    "Tennis",
    "Touchtennis"]; // Option 2
  String _selectedSport; // Option 2
  DateTime date;

  String getText() {
    if (date == null) {
      return "Seleziona";
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Future<bool> onBackPressed() {
    return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return DrawerScreen();
      },
    ), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: onBackPressed,
          ),
        ),
      ),
      body: Column(children: [
        Flexible(
            fit: FlexFit.loose,
            flex: 1,
            child: Container()
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text('Seleziona uno sport',
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans'
            ),
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Container(
            child: HeaderWidget(
                title: "",
                child: DropdownButton(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,color: Colors.black
                  ),
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
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Text('Inserisci una data',
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans'
            ),
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Container(
            child: ButtonHeaderWidget(
              title: "",
              text: getText(),
              onClicked: () => pickDate(context),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: Container(
            width: 170,
            height: 75,
            child: TextButton(
              child: Text(
                "CONFERMA".toUpperCase(),
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black26),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black)
                      )
                  )
              ),
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
            ),
          ),
        ),
        Flexible(
            fit: FlexFit.loose,
            flex: 1,
            child: Container()
        ),
      ],
      ),
    );
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
