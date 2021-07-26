import 'package:flutter/material.dart';
import 'package:quickplay/ViewModel/Auth_Handler.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(tabs: [
              Tab(text: "Accedi"),
              Tab(text: "Registrati"),
            ],
            ),
          ),
          body: TabBarView(
            children: [
              Accedi(),
              Registrati(),
            ],
          ),
        ),
      ),
    );
  }
}


class Accedi extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _MyHomePageState();
  }
}



class _MyHomePageState extends State<Accedi> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool rememberMe = false;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      new Flexible(child: new TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          //Puoi prendere il valore con emailController.text
                          controller: emailController,
                          validator: (value){
                            if(value!.isNotEmpty){
                              return null;
                            }else{
                              return "Inserisci la tua email";
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          )
                      ), flex: 1,),
                      SizedBox(height: 50.0,),
                      new Flexible(child: new TextFormField(
                          controller: passwordController,
                          validator: (value){
                            if(value!.isNotEmpty){
                              return null;
                            }else{
                              return "Inserisci la password";
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          )
                      ),flex: 1,),
                      SizedBox(height: 50.0,),
                      Text("Ricordami"),
                      new Flexible(child: new CheckboxListTile(
                          value: rememberMe,
                          onChanged: (bool? val){
                            setState(() {
                              rememberMe = val!;
                            });
                          }), flex: 1,
                      ),
                      SizedBox(height: 50.0,),
                      OutlinedButton(
                        onPressed: () {
                          if(!_formKey.currentState!.validate())
                          {
                            return;
                          }
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
                        ),
                        child: const Text("Conferma"),
                      ),
                    ],
                  ),
                )
            )
        ),
      ),
    );
  }

}



class Registrati extends StatelessWidget{
  TextEditingController emailController = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confermaPassword = new TextEditingController();
  TextEditingController nome = new TextEditingController();
  TextEditingController cognome = new TextEditingController();
  TextEditingController telefono = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Flexible(child: new TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  //Puoi prendere il valore con emailController.text
                  controller: emailController,
                  validator: (value){
                    if(value!.isNotEmpty){
                      return null;
                    }else{
                      return "Inserisci la tua email";
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  )
              ), flex: 1,),
              SizedBox(height: 5.0,),
              new Flexible(child: new TextFormField(
                  controller: password,
                  validator: (value){
                    if(value!.isNotEmpty){
                      return null;
                    }else{
                      return "Inserisci la password";
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  )
              ),flex: 1,),
              SizedBox(height: 5.0,),
              new Flexible(child: new TextFormField(
                  controller: confermaPassword,
                  validator: (value){
                    if(value != password.text)
                    {
                      return "Le password non combaciano";
                    }else{
                      return null;
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Conferma password',
                  )),flex: 1,),
              SizedBox(height: 5.0,),
              new Flexible(child: new TextFormField(
                  controller: nome,
                  validator: (value){
                    if(value!.isNotEmpty){
                      return null;
                    }else{
                      return "Inserisci il tuo nome";
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                  )
              ),flex: 1,),
              SizedBox(height: 5.0,),
              new Flexible(child: new TextFormField(
                  controller: cognome,
                  validator: (value){
                    if(value!.isNotEmpty){
                      return null;
                    }else{
                      return "Inserisci il tuo cognome";
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Cognome',
                  )
              ),flex:1),
              SizedBox(height: 5.0,),
              new Flexible(child: new TextFormField(
                  controller: telefono,
                  validator: (value){
                    if(value!.isNotEmpty){
                      return null;
                    }else{
                      return "Inserisci il tuo telefono";
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Telefono',
                  )
              ),flex: 1, ),
              SizedBox(height: 5.0,),
              new Flexible(child: new  OutlinedButton(
                onPressed: () {
                  if(!_formKey.currentState!.validate())
                  {

                    //CheckCredenziali
                    Auth_Handler.setLOGGED_IN_Context(context, true, "alessandrobedetta941@gmail.com", "123456", (result){

                      if(result){
                        //Utente trovato - Credenziali giuste
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Credenziali giuste"),
                        ));
                      }else{
                        //Utente non esistente o credenziali errate
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Credenziali errate"),
                        ));
                      }

                    });

                    return;
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
                ),
                child: const Text("Conferma"),
              ),flex: 1,),
            ],
          ),
        ),
      ),
    );
  }
}

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

   */
Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('Popup example'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Hello"),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}