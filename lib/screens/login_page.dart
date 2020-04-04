import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:own_dog/screens/home_page.dart';
import 'package:own_dog/screens/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Explicit
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey(); // เอาไว้เรียกใช้ scaffold จากที่อื่นๆ
  String emailString, passwordString;

  // Method
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    // check สถานะว่าเครื่องเราทำการ Log in อยู่หรือเปล่า
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser =
        await firebaseAuth.currentUser(); //ให้ทำการ connect กับ Firebase
    if (firebaseUser != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => MyHomePage(),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }

  Widget showLogo() {
    return SizedBox(
      width: 300.0,
      height: 300.0,
      child: FlareActor(
        'assets/flares/Doggo-storyoggo.flr',
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: 'stop',
      ),
    );
  }

  Widget showAppName() {
    return Text(
      'OWNER DOG',
      style: TextStyle(
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
        color: Colors.brown[900],
        fontFamily: 'Mitr',
      ),
    );
  }

  Widget emailInputText() {
    return Container(
      width: 350.0,
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            size: 25.0,
            color: Colors.brown,
          ),
          labelText: 'E-MAIL',
          labelStyle: TextStyle(
            color: Colors.brown,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onSaved: (String value) {
          emailString = value.trim();
        },
      ),
    );
  }

  Widget passwordInputText() {
    return Container(
      width: 350.0,
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock_outline,
            size: 25.0,
            color: Colors.brown,
          ),
          labelText: 'PASSWORD',
          labelStyle: TextStyle(
            color: Colors.brown,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onSaved: (String value) {
          passwordString = value.trim();
        },
        obscureText: true,
      ),
    );
  }

  Widget content() {
    // appname/ username/passwordTextField
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          showAppName(),
          emailInputText(),
          SizedBox(
            height: 10.0,
          ),
          passwordInputText(),
          SizedBox(
            height: 35.0,
          ),
        ],
      ),
    );
  }

  Widget logInButton() {
    return SizedBox(
      height: 40,
      width: 120,
      child: RaisedButton(
        color: Colors.yellow[800],
        child: Text(
          'LOG IN',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () {
          _formKey.currentState.save(); // เอาค่า email/password ส่งไป firebase
          print(
            "Click LOG IN\nemail = $emailString, password = $passwordString",
          );
          checkAuthen();
        },
      ),
    );
  }

  Widget registerButton() {
    return SizedBox(
      height: 40,
      width: 120,
      child: RaisedButton(
        color: Colors.blueGrey[100],
        child: Text('REGISTER'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => RegisterPage(),
          ),
        ),
      ),
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        logInButton(),
        SizedBox(
          width: 15.0,
        ),
        registerButton(),
      ],
    );
  }

  Future<void> checkAuthen() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then(
          (response) => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => MyHomePage(),
            ),
            (Route<dynamic> route) => false,
          ),
        )
        .catchError(
      (response) {
        alertScaffold(response.message);
      },
    );
  }

  void alertScaffold(String msg) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        // Show Error
        content: Text(msg, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.yellow[100],
              Colors.yellowAccent[700],
            ],
            radius: 0.7,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showLogo(),
                content(),
                showButton(),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
