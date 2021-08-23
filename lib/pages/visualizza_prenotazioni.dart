import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:quickplay/ViewModel/Auth_Handler.dart';
import 'package:quickplay/ViewModel/DB_Handler_Reservations.dart';
import 'package:quickplay/models/models.dart';
import 'home_page_menu.dart';
import 'package:quickplay/pages/home_page.dart';


class VisualizzaPrenotazioni extends StatefulWidget {
  VisualizzaPrenotazioni(this.layoutInfo, {Key key, this.group})
      : super(key: key);

  final GroupType group;

  final List<LayoutInfo> layoutInfo;

  @override
  _ListState createState() => _ListState(layoutInfo);
}

enum GroupType {
  simple,
  scroll,
}

class _ListState extends State<VisualizzaPrenotazioni> {
  var _direction = Axis.vertical;

  List<LayoutInfo> layoutInfo = [];

  _ListState(List<LayoutInfo> prenotazioni) {
    layoutInfo = prenotazioni;
  }

  Widget _itemTitle(LayoutInfo prenotazione) {
    Color backgroung = getColor(prenotazione);
    return Container(
      decoration: BoxDecoration(
          color: backgroung,
          border: Border(bottom: BorderSide(color: Colors.black, width: 3))),
      child: ListTile(
        title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              children: <Widget>[
                Text(
                  prenotazione.circolo,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                  ),
                ),
                Text("Campo n° " + prenotazione.campo),
                Text(prenotazione.data),
                Text(
                  "Dalle " +
                      prenotazione.orainizio +
                      " Alle " +
                      prenotazione.oraFine,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [getCod(prenotazione), getCopyBtn(prenotazione)],
                ),
                Row(children: [
                  TextButton(
                      onPressed: () {
                        showCancelDialog(context, prenotazione);
                      },
                      child: const Text(
                        'Cancella',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            fontFamily: 'WorkSansMedium'),
                      )),
                  TextButton(
                      onPressed: () async {
                          showLoaderDialog(context);
                          DB_Handler_Reservations.getPartecipanti(prenotazione.codice,).then((value){
                            Navigator.of(context).pop();
                            showPartecipanti(value);
                          });
                        },
                      child: const Text(
                        'Partecipanti',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            fontFamily: 'WorkSansMedium'),
                      ))
                ])
              ],
            )),
        leading: CircleAvatar(
          backgroundImage: ExactAssetImage(
            'assets/img/sport.png',
          ),
        ),
        dense: true,

        //onTap: () => ,
      ),
    );
  }

  Widget _bodyContent() {
    if (layoutInfo == []) {
      return null;
    }
    var isVertical = _direction == Axis.vertical;
    return ListView.builder(
      scrollDirection: _direction,
      itemCount: layoutInfo.length,
      itemExtent: 180.0,
      itemBuilder: (context, index) {
        return Container(
          alignment: AlignmentDirectional.center,
          color: Colors.white,
          margin: isVertical
              ? EdgeInsets.only(bottom: 1.0)
              : EdgeInsets.only(right: 1.0),
          constraints: isVertical
              ? BoxConstraints.tightForFinite(height: 80.0)
              : BoxConstraints.tightForFinite(width: 260.0),
          child: _itemTitle(layoutInfo[index]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: onBackPressed,
            ),
          ),
        ),
        body: Container(
          constraints: _direction == Axis.vertical
              ? null
              : BoxConstraints.tightForFinite(height: 80.0),
          child: Center(
            child: _bodyContent(),
          ),
        ),
      ),
      onWillPop: onBackPressed,
    );
  }

  Future<bool> onBackPressed() {
    return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return DrawerScreen();
      },
    ), (route) => false);
  }

  showCancelDialog(BuildContext context, LayoutInfo prenotazione) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Si"),
      onPressed: () {
        Navigator.of(context).pop();
        DB_Handler_Reservations.deleteReservation(prenotazione.codice);
        layoutInfo.remove(prenotazione);
        setState(() {});
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Sei sicuro?"),
      content: Text("Cancellare la prenotazione"),
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

  Color getColor(LayoutInfo pren) {
    var giornoSplit = pren.data.split("-");
    String giornoFormatoAmericano =
        giornoSplit[2] + "-" + giornoSplit[1] + "-" + giornoSplit[0];
    int tsFine = DateTime.parse(giornoFormatoAmericano + " " + pren.oraFine)
        .millisecondsSinceEpoch;
    int tsNow = DateTime.now().millisecondsSinceEpoch;
    if (tsFine < tsNow) {
      return Color.fromRGBO(255, 102, 102, 0.8);
    }
    return Colors.white;
  }

  Text getCod(LayoutInfo pren) {
    var giornoSplit = pren.data.split("-");
    String giornoFormatoAmericano =
        giornoSplit[2] + "-" + giornoSplit[1] + "-" + giornoSplit[0];
    int tsFine = DateTime.parse(giornoFormatoAmericano + " " + pren.oraFine)
        .millisecondsSinceEpoch;
    int tsNow = DateTime.now().millisecondsSinceEpoch;
    if (tsFine < tsNow) {
      return Text(
        "Prenotazione scaduta",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),
      );
    }
    return Text(
      "Codice : " + pren.codice,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  TextButton getCopyBtn(LayoutInfo pren) {
    var giornoSplit = pren.data.split("-");
    String giornoFormatoAmericano =
        giornoSplit[2] + "-" + giornoSplit[1] + "-" + giornoSplit[0];
    int tsFine = DateTime.parse(giornoFormatoAmericano + " " + pren.oraFine)
        .millisecondsSinceEpoch;
    int tsNow = DateTime.now().millisecondsSinceEpoch;
    if (tsFine < tsNow) {
      return TextButton(onPressed: () {}, child: null);
    }
    return TextButton(
      child: Text('Copia'),
      onPressed: () {
        ClipboardManager.copyToClipBoard(pren.codice);
        final snackBar = SnackBar(
          content: Text('Copiato negli appunti'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }

  Widget _item(Partecipante partecipante) {
    var ref = FirebaseStorage.instance.ref().child("usersPics/"+partecipante.email);
    var url="";
   /* ref.getDownloadURL().then((value){
      url = value;
      setState(() {
      });
    });*/
    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black, width: 3))),
        child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  Text(partecipante.nome.capitalize()+" "+partecipante.cognome.capitalize()),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: CircleAvatar(
                      radius: 22.0,
                      backgroundImage: NetworkImage(url),
                    ),
                  )

                ],
              )


            )
        )
    );
  }

  showPartecipanti(List<Partecipante> partecipanti) {
    var isVertical = _direction == Axis.vertical;

    AlertDialog alert = AlertDialog(
        scrollable: true,
        contentPadding: EdgeInsets.only(left: 25, right: 25),
        title: Center(child: Text("Partecipanti")),
        content: Container(
          height: MediaQuery.of(context).size.width*0.8,
          width: MediaQuery.of(context).size.width*0.8,
          child: ListView.builder(
            itemCount: partecipanti.length,
            itemBuilder: (context, index) {
              return _item(partecipanti[index]);
            },
          ),

          ),
        );


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Caricamento..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

}


/*

          child:

 */