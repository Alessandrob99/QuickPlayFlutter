import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      /** PARTE SUPERIORE DELLA HOME (Sta sotto la classe) **/
                      child: HeaderView(),
                    ),
                    Expanded(
                      flex: 3,
                      child: HomeServiceView(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/** PARTE SUPERIORE DELLA HOME **/

class HeaderView extends StatelessWidget {
  const HeaderView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Benvenuto',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Nome da aggiungere',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}


class HomeServiceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        direction: Axis.horizontal,
        children: _buildHomeServiceMenu(context),
      ),
    );
  }

  List<Padding> _buildHomeServiceMenu(BuildContext context) {
    final services = Service.getHomeService();
    return List.generate(
          //Gli elementi presenti
          3,
          (index) => Padding(
        padding:
        const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 8.0),
        child: _buildContainer(index, context, services[index]),
      ),
    );
  }

  Container _buildContainer(int index, BuildContext context, Service service) {
    BorderRadius borderRaidus;

    switch (index) {
      case 0:
        borderRaidus = BorderRadius.only(topLeft: Radius.circular(15.0));
        break;
      case 1:
        borderRaidus = BorderRadius.only(topRight: Radius.circular(15.0));
        break;
      case 2:
        borderRaidus = BorderRadius.only(bottomLeft: Radius.circular(15.0));
        break;
      default:
        borderRaidus = BorderRadius.only(bottomRight: Radius.circular(15.0));
    }

    return Container(
      padding: const EdgeInsets.all(10.0),
      height: MediaQuery.of(context).size.height / 6,
      width: MediaQuery.of(context).size.width / 2.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(service.icon, color: Colors.blueGrey,),
                ClipOval(
                  child: Container(height: 10.0, width: 10.0, color: service.status ? Colors.pinkAccent[700] : Theme.of(context).primaryColor,),
                ),
              ],
            ),
            Text(
              service.name,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: borderRaidus,
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(3, 3),
            color: Colors.black12,
            blurRadius: 3,
          ),
          BoxShadow(
            offset: Offset(-3, -3),
            color: Colors.white,
            blurRadius: 3,
          ),
        ],
      ),
    );
  }
}


class Service {
  Service({
    @required this.name,
    @required this.icon,
    this.status = false,
  });
  String name;
  IconData icon;
  bool status;

  static List<Service> getHomeService() {
    List<Service> services = [
      Service(name: 'Smart TV', icon: Icons.live_tv),
      Service(name: 'Wifi', icon: Icons.wifi, status: true),
      Service(name: 'Temperature', icon: Icons.wb_sunny),
    ];
    return services;
  }
}


