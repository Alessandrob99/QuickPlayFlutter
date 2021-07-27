import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickplay/ViewModel/Auth_Handler.dart';
import 'package:quickplay/ViewModel/DB_Handler_Users.dart';
import 'package:quickplay/utils/constants.dart';
import 'package:quickplay/widgets/snackbar.dart';

import 'Login.dart';
import 'home_page_menu.dart';

class Register extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<Register> {
  bool _rememberMe = false;
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeConfirmPassword = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodeName = FocusNode();
  final FocusNode focusNodeCognome = FocusNode();
  final FocusNode focusNodeTel = FocusNode();

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupCognomeController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController = TextEditingController();
  TextEditingController signupConfirmTelController = TextEditingController();

  @override
  void dispose() {
    focusNodeTel.dispose();
    focusNodeCognome.dispose();
    focusNodePassword.dispose();
    focusNodeConfirmPassword.dispose();
    focusNodeEmail.dispose();
    focusNodeName.dispose();
    super.dispose();
  }


  Widget _buildNome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            focusNode: focusNodeName,
            controller: signupNameController,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
              hintText: 'Nome',
              hintStyle: kHintTextStyle,
            ),
            onSubmitted: (_) {
              focusNodeCognome.requestFocus();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCognome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            focusNode: focusNodeCognome,
            controller: signupCognomeController,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
              hintText: 'Cognome',
              hintStyle: kHintTextStyle,
            ),
            onSubmitted: (_) {
              focusNodeEmail.requestFocus();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            focusNode: focusNodeEmail,
            controller: signupEmailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              hintText: 'Email',
              hintStyle: kHintTextStyle,
            ),
            onSubmitted: (_) {
              focusNodePassword.requestFocus();
            },
          ),
        ),
      ],
    );
  }


  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            focusNode: focusNodePassword,
            controller: signupPasswordController,
            obscureText: _obscureTextPassword,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: _toggleSignup,
                child: Icon(
                  _obscureTextPassword
                      ? FontAwesomeIcons.eye
                      : FontAwesomeIcons.eyeSlash,
                  size: 18.0,
                  color: Colors.black,
                ),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              hintText: 'Password',
              hintStyle: kHintTextStyle,
            ),
            onSubmitted: (_) {
              focusNodeConfirmPassword.requestFocus();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildConfermaPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            focusNode: focusNodeConfirmPassword,
            controller: signupConfirmPasswordController,
            obscureText: _obscureTextConfirmPassword,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: _toggleSignupConfirm,
                child: Icon(
                  _obscureTextPassword
                      ? FontAwesomeIcons.eye
                      : FontAwesomeIcons.eyeSlash,
                  size: 18.0,
                  color: Colors.black,
                ),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              hintText: 'Conferma Password',
              hintStyle: kHintTextStyle,
            ),
            onSubmitted: (_) {
              focusNodeTel.requestFocus();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCellulare() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            focusNode: focusNodeTel,
            controller: signupConfirmTelController,
            obscureText: _obscureTextPassword,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone_android,
                color: Colors.black,
              ),
              hintText: 'Cellulare',
              hintStyle: kHintTextStyle,
            ),
            onSubmitted: (_) {
              _toggleSignUpButton();
            },
            textInputAction: TextInputAction.go,
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerLeft,
      child: FlatButton(
        onPressed: () => print("Metodo da fare"),
        child: Text(
          'Password dimenticata?',
          style: kLabelStyle,
        ),
      ),
    );
  }


  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          _toggleSignUpButton();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.black26, width: 2.0)),
        color: Colors.white,
        child: Text(
          'REGISTRATI',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Inserisci le credenziali:",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans'),
                      ),
                      SizedBox(height: 30.0),
                      Card(
                          elevation: 2.0,
                          color: Colors.white, //Colore interno
                          shape: new RoundedRectangleBorder(
                            //Colore del bordo
                              side: new BorderSide(
                                  color: Colors.black26, width: 2.0),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Column(children: [
                            _buildNome(),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            _buildCognome(),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            _buildEmailTF(),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            _buildPasswordTF(),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            _buildConfermaPassword(),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            _buildCellulare(),
                            SizedBox(height: 10.0),
                          ])),
                      _buildRegisterBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showRegistrationDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Operazione conclusa",),
            content: Text("Account registrato con successo.\nAbbiamo inviato una mail all'account:\n"+signupEmailController.text+"\nCliccare sul link per attivare l'account.\n(CONTROLLARE CHE LA MAIL NON SIA FINITA NELLO SPAM)"),
            //buttons?
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () { Navigator.of(context).pop(); }, //closes popup
              ),
            ],
          );
        }
    );
  }

  Future<bool> onBackPressed() {
    return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return LoginScreen();
      },
    ), (route) => false);
  }


  void showTegistrationErrorDialog(BuildContext context, String msg) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Errore",),
            content: Text(msg),
            //buttons?
            actions: <Widget>[
              FlatButton(
                child: Text("Riprova"),
                onPressed: () { Navigator.of(context).pop(); }, //closes popup
              ),
            ],
          );
        }
    );
  }

  showCheckCredenzialiDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Controllando le credenziali..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  void _toggleSignUpButton() {
    if(signupNameController.text == "" || signupCognomeController.text == "" || signupEmailController.text == "" ||
        signupConfirmTelController.text == "" || signupPasswordController.text == "" || signupConfirmPasswordController.text == "")
    {
      CustomSnackBar(context, const Text('Inserisci le credenziali'));
    }
    else if(signupPasswordController.text != signupConfirmPasswordController.text)
    {
      CustomSnackBar(context, const Text('Le password non combaciano'));
    } else {

      Auth_Handler.FireBaseRegistration(signupEmailController.text, signupPasswordController.text, signupNameController.text, signupCognomeController.text, signupConfirmTelController.text, (result, msg){
        if(result){
          DB_Handler_Users.newUser(signupEmailController.text, signupPasswordController.text, signupNameController.text, signupCognomeController.text, signupConfirmTelController.text);
          showRegistrationDialog(context);
        }else{
          CustomSnackBar(context, Text(msg));
        }
      });
    }

  }

  void _toggleSignup() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }
}
