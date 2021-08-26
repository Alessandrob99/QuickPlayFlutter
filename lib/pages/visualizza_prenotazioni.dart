import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:quickplay/ViewModel/Auth_Handler.dart';
import 'package:quickplay/ViewModel/DB_Handler_Reservations.dart';
import 'package:quickplay/models/models.dart';
import 'package:quickplay/pages/selezione1.dart';
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
          color: backgroung, border: Border.all(color: Colors.black, width: 3)),
      child: ListTile(
        title: Container(
            child: Column(
          children: <Widget>[
            Text(
              prenotazione.circolo,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    text: "Campo n° :  ",
                    children: [
                  TextSpan(
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      text: prenotazione.campo),
                ])),
            Text(
              prenotazione.data,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    text: "Dalle ",
                    children: [
                  TextSpan(
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      text: prenotazione.orainizio),
                  TextSpan(
                      style: TextStyle(color: Colors.black), text: " alle "),
                  TextSpan(
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      text: prenotazione.oraFine),
                ])),
            getRow(prenotazione),
            Row(children: [
              TextButton(
                  onPressed: () {
                    showCancelDialog(context, prenotazione);
                  },
                  child: Text(
                    "Cancella",
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
                    DB_Handler_Reservations.getPartecipanti(
                      prenotazione.codice,
                    ).then((value) {
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
    if (layoutInfo.isEmpty) {
      return Container(
          child: Column(
        children: [
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            child: Text(
              "Nessuna prenotazione ancora registrata",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Selezione1()));
            },
            child: Text("Effettua una prenotazione ora"),
          )
        ],
      ));
    }
    return ListView.builder(
      scrollDirection: _direction,
      itemCount: layoutInfo.length,
      itemExtent: MediaQuery.of(context).size.height * 0.25,
      itemBuilder: (context, index) {
        return Container(
          alignment: AlignmentDirectional.center,
          color: Colors.white,
          margin: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width * 0.9,
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
      child: RichText(
        text: WidgetSpan(child: Icon(Icons.copy)),
      ),
      onPressed: () {
        ClipboardManager.copyToClipBoard(pren.codice);
        final snackBar = SnackBar(
          content: Text('Copiato negli appunti'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }

  getRow(LayoutInfo pren) {
    var giornoSplit = pren.data.split("-");
    String giornoFormatoAmericano =
        giornoSplit[2] + "-" + giornoSplit[1] + "-" + giornoSplit[0];
    int tsFine = DateTime.parse(giornoFormatoAmericano + " " + pren.oraFine)
        .millisecondsSinceEpoch;
    int tsNow = DateTime.now().millisecondsSinceEpoch;
    if (tsFine < tsNow) {
      return Row(
        children: [
          Text(
            "Prenotazione scaduta",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),
          )
        ],
      );
    } else {
      if (pren.prenotatoreEmail == Auth_Handler.CURRENT_USER.email) {
        return Row(
          children: [
            Text(
              "Codice : " + pren.codice,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            getCopyBtn(pren)
          ],
        );
      } else {
        return Container(
          child: Column(
            children: [
              Text("Organizzatore :"),
              Text(
                pren.prenotatoreNome,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )
            ],
          ),
        );
      }
    }
  }

  randomColorPicker(){
    List<Color> colori = [
      Colors.white,
      Colors.yellow,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.redAccent,
      Colors.grey,
      Color.fromRGBO(166, 44, 0, 1)
    ];
    return (colori..shuffle()).first;
  }

  Widget _item(Partecipante partecipante) {
    return Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 4),color: randomColorPicker()),
        child: ListTile(
            title: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Text(partecipante.nome.capitalize() +
                      " " +
                      partecipante.cognome.capitalize()),
                ))));
  }

  getAlertContent(List<Partecipante> partecipanti) {
    if (partecipanti.isEmpty) {
      return Container(
        margin: EdgeInsets.all(30),
        child: Text("Nessun partecipante oltre all'organizzatore"),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.width * 0.8,
        width: MediaQuery.of(context).size.width * 0.8,
        child: ListView.builder(
          itemCount: partecipanti.length,
          itemBuilder: (context, index) {
            return _item(partecipanti[index]);
          },
        ),
      );
    }
  }

  showPartecipanti(List<Partecipante> partecipanti) {
    AlertDialog alert = AlertDialog(
        scrollable: true,
        contentPadding: EdgeInsets.only(left: 25, right: 25),
        title: Center(child: Text("Partecipanti")),
        content: getAlertContent(partecipanti));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Caricamento...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

/*

          child:

 */
