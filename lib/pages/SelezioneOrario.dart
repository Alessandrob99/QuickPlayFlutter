import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickplay/models/models.dart';

class SelezioneOrario extends StatefulWidget {
  const SelezioneOrario({Key key, this.campo, this.circolo, this.data})
      : super(key: key);
  @override
  final Court campo;
  final Club circolo;
  final DateTime data;

  _SelezioneOrario createState() => _SelezioneOrario(campo, circolo, data);
}

class _SelezioneOrario extends State<SelezioneOrario> {
  Club circolo;
  Court campo;
  DateTime data;

  Map<String,bool> buttonsEnabled = {
    '6:30':false,
    '7:00':true,
    '7:30':true,
    '8:00':true,
    '8:30':true,
    '9:00':true,
    '9:30':true,
    '10:00':true,
    '10:30':true,
    '11:00':true,
    '11:30':true,
    '12:00':true,
    '12:30':true,
    '13:00':true,
    '13:30':true,
    '14:00':true,
    '14:30':true,
    '15:00':true,
    '15:30':true,
    '16:00':true,
    '16:30':true,
    '17:00':true,
    '17:30':true,
    '18:00':true,
    '18:30':true,
    '19:00':true,
    '19:30':true,
    '20:00':true,
    '20:30':true,
    '21:00':true,
    '21:30':true,
    '22:00':true,
    '22:30':true,
    '23:00':true,
    '23:30':true,
    '00:00':true
  };

  _SelezioneOrario(this.campo, this.circolo, this.data);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.8,
      width: MediaQuery.of(context).size.width,
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Row(
           children: [
             _buildCounterButton('6:30'),
             _buildCounterButton('11:00'),
             _buildCounterButton('15:30'),
             _buildCounterButton('20:00'),
           ],
         ),
         Row(
           children: [
             RaisedButton(onPressed: (){}, child: Text('7:00')),
             RaisedButton(onPressed: (){}, child: Text('11:30')),
             RaisedButton(onPressed: (){}, child: Text('16:00')),
             RaisedButton(onPressed: (){}, child: Text('20:30')),
           ],
         ),
         Row(
           children: [
             RaisedButton(onPressed: (){}, child: Text('7:30')),
             RaisedButton(onPressed: (){}, child: Text('12:00')),
             RaisedButton(onPressed: (){}, child: Text('16:30')),
             RaisedButton(onPressed: (){}, child: Text('21:00')),
           ],
         ),
         Row(
           children: [
             RaisedButton(onPressed: (){}, child: Text('8:00')),
             RaisedButton(onPressed: (){}, child: Text('12:30')),
             RaisedButton(onPressed: (){}, child: Text('17:00')),
             RaisedButton(onPressed: (){}, child: Text('21:30')),
           ],
         ),
         Row(
           children: [
             RaisedButton(onPressed: (){}, child: Text('8:30')),
             RaisedButton(onPressed: (){}, child: Text('13:00')),
             RaisedButton(onPressed: (){}, child: Text('17:30')),
             RaisedButton(onPressed: (){}, child: Text('22:00')),
           ],
         ),Row(
           children: [
             RaisedButton(onPressed: (){}, child: Text('9:00')),
             RaisedButton(onPressed: (){}, child: Text('13:30')),
             RaisedButton(onPressed: (){}, child: Text('18:00')),
             RaisedButton(onPressed: (){}, child: Text('22:30')),
           ],
         ),Row(
           children: [
             RaisedButton(onPressed: (){}, child: Text('9:30')),
             RaisedButton(onPressed: (){}, child: Text('14:00')),
             RaisedButton(onPressed: (){}, child: Text('18:30')),
             RaisedButton(onPressed: (){}, child: Text('23:00')),
           ],
         ),Row(
           children: [
             RaisedButton(onPressed: (){}, child: Text('10:00')),
             RaisedButton(onPressed: (){}, child: Text('14:30')),
             RaisedButton(onPressed: (){}, child: Text('19:00')),
             RaisedButton(onPressed: (){}, child: Text('23:30')),
           ],
         ),Row(
           children: [
             RaisedButton(onPressed: (){}, child: Text('10:30')),
             RaisedButton(onPressed: (){}, child: Text('15:00')),
             RaisedButton(onPressed: (){}, child: Text('19:30')),
             RaisedButton(onPressed: (){}, child: Text('24:00')),
           ],
         ),
         Row(

         )
       ],
     ),
    );
  }


  Widget _buildCounterButton(String btn) {
    var color;
    if(buttonsEnabled[btn]){
      color = Colors.white;
    }else{
      color = Colors.red;
    }
    return new RaisedButton(
      color: color,
      child: new Text(
          btn
      ),
      onPressed: buttonsEnabled[btn] ? (){
        print("Ora : "+btn);
      } : (){
        print("Orario già occupato");
      }
    );
  }

}
