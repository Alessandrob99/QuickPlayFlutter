import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:quickplay/ViewModel/DB_Handler_Users.dart';
import "package:quickplay/models/models.dart";
import 'package:shared_preferences/shared_preferences.dart';



class Auth_Handler{

  static Firestore myRef = Firestore.instance;
  static bool LOGGED_IN = false;
  static User CURRENT_USER  = null;


  static testFunction(Function func){
    //Qualcosa che prende tempo
    Future.delayed(const Duration(milliseconds: 5000), () {

      func();//faccio questa roba appena ho finito le cose sopra

    });

  }

  static setLOGGED_IN(){
    LOGGED_IN = true;
  }


  static setLOGGED_IN_Context( BuildContext context,bool ricordami ,String email,String password, myCallBack(bool result)) async {
    LOGGED_IN = true;
    if (ricordami) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("ricordami", true);
      await prefs.setString("email", email);
      await prefs.setString("password", password);
    }
    DB_Handler_Users.SearchUsersByEmail(email, (returnedUser){

      //Assegno a CURRENT USER i parametri ritornati (se sono != da null)

      if(returnedUser!=null){
        CURRENT_USER = User(
            returnedUser.nome,
            returnedUser.cognome,
            returnedUser.email,
            returnedUser.password,
            returnedUser.telefono,
        );
        myCallBack(true);
      }else{
        CURRENT_USER = null;
        myCallBack(false);
      }


    });

  }


}