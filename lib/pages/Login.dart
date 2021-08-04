import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickplay/ViewModel/Auth_Handler.dart';
import 'package:quickplay/pages/register_page.dart';
import 'package:quickplay/utils/constants.dart';
import 'package:quickplay/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page_menu.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();


}


class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  bool newUser;
  SharedPreferences logindata;
  SharedPreferences loginpw;

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();


  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();


  bool _obscureTextPassword = true;

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    check();
  }

  void check() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("email") != "") {
      _rememberMe = true;
      loginEmailController.text = prefs.getString("email");
      loginPasswordController.text = prefs.getString("password");
      setState(() {});
    }
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
            controller: loginEmailController,
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
            controller: loginPasswordController,
            obscureText: _obscureTextPassword,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: _toggleLogin,
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
              _toggleSignInButton();
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
        onPressed: () {
          _displayTextInputDialog(context);
        },
        child: Text(
          'Password dimenticata?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 40.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) async {
                if (!value) {
                  SharedPreferences prefs = await SharedPreferences
                      .getInstance();
                  prefs.setString("email", "");
                  prefs.setString("password", "");
                }
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Ricordami',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          _LoginButton();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.black26, width: 2.0)),
        color: Colors.white,
        child: Text(
          'ACCEDI',
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

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- O -',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20.0),
        FlatButton(
          onPressed: () =>
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Register())),
          child: Text('REGISTRATI', style: kLabelStyle),
        )
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    vertical: 0.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      Image(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height > 800
                              ? 191.0
                              : 150,
                          fit: BoxFit.fill,
                          image:
                          const AssetImage('assets/img/quickplaylogo.PNG')),
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
                            _buildEmailTF(),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            _buildPasswordTF(),
                            SizedBox(height: 10.0),
                          ])),
                      _buildRememberMeCheckbox(),
                      _buildForgotPasswordBtn(),
                      _buildLoginBtn(),
                      _buildSignInWithText(),
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

  void showLoginErrorDialog(BuildContext context, String msg) {
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
                onPressed: () {
                  Navigator.of(context).pop();
                }, //closes popup
              ),
            ],
          );
        }
    );
  }

  _displayTextInputDialog(BuildContext context) {

    TextEditingController emailResetPasswordController = TextEditingController();

    showDialog(context: context, barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text('Inserisci email di recupero'),
            content: Column(
              children: [
                TextField(

                  controller: emailResetPasswordController,
                  decoration: InputDecoration(hintText: "Email"),
                ),
                FlatButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    sendValidationEmail(emailResetPasswordController.text);
                  },
                  child: Text("Invia"),)
              ],
            ),

          );
        });
  }

  showCheckCredenzialiDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),
              child: Text("Controllando le credenziali...")),
        ],),
    );
    showDialog(barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //Metodo per l'invio dalla tastiera.
  void _toggleSignInButton() {
    if (loginEmailController.text == "" || loginPasswordController.text == "" ||
        (loginEmailController.text == "" &&
            loginPasswordController.text == "")) {
      CustomSnackBar(context, const Text("Inserisci le credenziali d'accesso"));
    } else {
      //Check della presenza di credenziali
      if (loginEmailController.text != "" &&
          loginPasswordController.text != "") {
        showCheckCredenzialiDialog(context);
        //CheckCredenziali corrette
        Auth_Handler.FireBaseLogin(
            _rememberMe, context, loginEmailController.text,
            loginPasswordController.text, (result, msg) {
          if (result) {
            //Credenziali corrette -> Facciamo partire la homePage
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DrawerScreen()),
            );
          } else {
            Navigator.pop(context);
            CustomSnackBar(context, Text(msg));
          }
        });
      }
    }
  }

  //Metodo per il click del bottone da touch
  Future<void> _LoginButton() async {
    if (loginEmailController.text == "" || loginPasswordController.text == "" ||
        (loginEmailController.text == "" &&
            loginPasswordController.text == "")) {
      CustomSnackBar(context, const Text("Inserisci le credenziali d'accesso"));
    } else {
      //Check della presenza di credenziali
      if (loginEmailController.text != "" &&
          loginPasswordController.text != "") {
        showCheckCredenzialiDialog(context);
        //CheckCredenziali corrette
        Auth_Handler.FireBaseLogin(
            _rememberMe, context, loginEmailController.text,
            loginPasswordController.text, (result, msg) {
          if (result) {
            //Credenziali corrette -> Facciamo partire la homePage
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DrawerScreen()),
            );
          } else {
            Navigator.pop(context);
            CustomSnackBar(context, Text(msg));
          }
        });
      }
    }
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }


  Future<void> sendValidationEmail(String email) async {
    try {
      await Auth_Handler.firebaseAuth.sendPasswordResetEmail(email : email);
    } catch (e) {
      switch (e.code) {
        case "ERROR_INVALID_EMAIL" :
          CustomSnackBar(context, const Text("Indirizzo email non valido."));
          break;
        case "ERROR_USER_NOT_FOUND":
          CustomSnackBar(context, const Text("La mail inserita non è legata a nessun account."));
          break;
        default :
          CustomSnackBar(context, const Text("Errore durante l'invio della mail."));
          break;
      }
    }
  }

}