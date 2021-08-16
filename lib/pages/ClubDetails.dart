import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickplay/models/models.dart';
import 'package:quickplay/pages/SelezioneOrario.dart';
import 'package:quickplay/utils/constants.dart';

class ClubDetails extends StatefulWidget {
  const ClubDetails({Key key, this.campi, this.circolo,this.data}) : super(key: key);
  @override
  final List<Court> campi;
  final Club circolo;
  final DateTime data;
  _ClubDetails createState() => _ClubDetails(campi, circolo,data);
}

class _ClubDetails extends State<ClubDetails> {
  List<Court> campi = [];
  Club circolo;
  DateTime data;

  _ClubDetails(this.campi, this.circolo,this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 100,bottom: 20),
            child: Center(
              child: Text(circolo.nome),
            ),
          ),
          SizedBox(
            height: 500,
            width: 400,
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: campi.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Text(
                          'campo n° ${campi[index].n_c} in ${campi[index].superficie}'
                      ),

                      FlatButton(
                        onPressed: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => SelezioneOrario(campo: campi[index],circolo: circolo, data: data,)));
                        },
                        child: Text('Prenota', style: kLabelStyle),
                      )
                    ],
                  );
                })
          )

        ],
      ),
    );
  }
}
