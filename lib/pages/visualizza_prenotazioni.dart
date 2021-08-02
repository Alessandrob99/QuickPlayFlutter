import "package:flutter/material.dart";
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
              Row(children: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Cancella',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 14.0,
                          fontFamily: 'WorkSansMedium'),
                    )),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Partecipanti',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 14.0,
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
      itemExtent: 150.0,
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
}
