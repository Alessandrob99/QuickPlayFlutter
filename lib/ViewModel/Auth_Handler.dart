import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickplay/ViewModel/DB_Handler_Users.dart';
import "package:quickplay/models/models.dart";
import 'package:shared_preferences/shared_preferences.dart';



class Auth_Handler{


  static SharedPreferences prefs;
  static Firestore myRef = Firestore.instance;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static bool LOGGED_IN = false;
  static User CURRENT_USER  = null;
  static String profileImg = "";


  static setLOGGED_IN(){
    LOGGED_IN = true;
  }


  static setLOGGED_IN_Context( BuildContext context,bool ricordami ,String email,String password, myCallBack(bool result)) async {
    LOGGED_IN = true;
    if (ricordami) {
      prefs = await SharedPreferences.getInstance();
      var ref;
      String location;
      try{

        ref = FirebaseStorage.instance.ref().child("usersPics/"+email);
        location = await ref.getDownloadURL();

      }catch(Exception){

        ref = FirebaseStorage.instance.ref().child("usersPics/Sample_User_Icon.png");
        location = await ref.getDownloadURL();

      }


      profileImg = location;
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
            returnedUser.telefono,
        );
        myCallBack(true);
      }else{
        CURRENT_USER = null;
        myCallBack(false);
      }


    });

  }


  static setLOGGET_OUT(BuildContext context) async {
  LOGGED_IN = false;
  CURRENT_USER = null;
  prefs = await SharedPreferences.getInstance();
  prefs.setString("email", "");
  prefs.setString("password", "");
  prefs.setBool("remember", false);
  }

  static FireBaseLogin(bool ricordami,BuildContext context,String email,String password,myCallBack(bool result,String msg)) async{
       try{
         var user = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
         if(user.user.isEmailVerified){
           setLOGGED_IN_Context(context, ricordami, email, password, (result) {
             myCallBack(true, "");
           });
         }else{
           myCallBack(false, "L'account non è stato verificato.");
         }

       }catch (e){
         switch(e.code){
           case  "ERROR_INVALID_EMAIL" :
             myCallBack(false,"L'email non è scritta correttamente.");
             break;
           case  "ERROR_WRONG_PASSWORD" :
             myCallBack(false,"Password errata.");
             break;
           case  "ERROR_USER_NOT_FOUND" :
             myCallBack(false,"L'account non risulta registrato.");
             break;
           case  "ERROR_OPERATION_NOT_ALLOWED" :
             myCallBack(false,"L'account non risulta abilitato.");
             break;
           case  "ERROR_USER_DISABLED" :
             myCallBack(false,"L'account risulta disabilitato.");
             break;
           case  "ERROR_TOO_MANY_REQUESTS" :
             myCallBack(false,"Sono stati fatti troppi tentativi di accesso.");
             break;
           default :
             myCallBack(false,"Errore durante il Login.");
         }
       };
  }

  static FireBaseRegistration(String email,String password,String nome,String cognome,String telefono,myCallBack(bool result,String msg)) async {
    try{
      var user = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      user.user.sendEmailVerification();
      //Aggiungere invio mail
      myCallBack(true,"");
    }catch(e){
      switch(e.code){
        case  "ERROR_INVALID_EMAIL" :
          myCallBack(false,"L'email non è scritta correttamente.");
          break;
        case  "ERROR_EMAIL_ALREADY_IN_USE" :
          myCallBack(false,"L'email è già in uso.");
          break;
        case  "ERROR_WEAK_PASSWORD" :
          myCallBack(false,"Scegliere una password migliore.");
          break;
        default :
          myCallBack(false,"Errore durante la registrazione.");
      }
    }

  }


}