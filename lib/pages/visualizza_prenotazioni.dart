import 'package:clipboard_manager/clipboard_manager.dart';
import "package:flutter/material.dart";
import 'package:quickplay/ViewModel/DB_Handler_Reservations.dart';
import 'package:quickplay/models/models.dart';
import 'home_page_menu.dart';


class VisualizzaPrenotazioni extends StatefulWidget {
  VisualizzaPrenotazioni(this.layoutInfo,{Key key, this.group, this.onClick}) : super(key: key);
  final VoidCallback onClick;

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


  _ListState(List<LayoutInfo> prenotazioni ){
    layoutInfo = prenotazioni;
  }

  Widget _itemTitle(LayoutInfo prenotazione) {
    return ListTile(
      title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: <Widget>[
              Text(prenotazione.circolo,style: TextStyle(
                fontSize: 13.0,
                color: Colors.black,
              ),
              ),
              Text("Campo n° "+prenotazione.campo),
              Text(prenotazione.data),
              Text("Dalle "+prenotazione.orainizio+" Alle "+prenotazione.oraFine,style: TextStyle(
                fontSize: 13.0,
                color: Colors.black,
              ),
              ),
              Row(
                children: [
                  Text("Codice : "),
                  Text(prenotazione.codice,style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),
                  TextButton(
                    child: Text('Copia'),
                    onPressed: () {
                      ClipboardManager.copyToClipBoard(prenotazione.codice);
                      final snackBar = SnackBar(
                        content: Text('Copiato negli appunti'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                ],
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
                    onPressed: () {},
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
      itemExtent: 175.0,
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

  showCancelDialog(BuildContext context,LayoutInfo prenotazione) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Si"),
      onPressed:  () {
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
}
