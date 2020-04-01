import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:own_dog/homePage.dart';
import 'package:own_dog/registerPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyHomePage());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }
  }

  Widget showLogo() {
    return Container(
      width: 140.0,
      height: 140.0,
      child: Image.asset(
        'images/logoDog.png',
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
            // icon: Icon(
            //   Icons.email,
            //   size: 25.0,
            //   color: Colors.brown,
            // ),
            labelText: 'E-MAIL',
            labelStyle: TextStyle(
              color: Colors.brown,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }

  Widget passwordInputText() {
    return Container(
      width: 350.0,
      child: TextFormField(
        decoration: InputDecoration(
          // icon: Icon(
          //   Icons.lock_outline,
          //   size: 25.0,
          //   color: Colors.brown,
          // ),
          labelText: 'PASSWORD',
          labelStyle: TextStyle(
            color: Colors.brown,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
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
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        onPressed: () {},
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
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        onPressed: () {
          print("Click Register");

          MaterialPageRoute materialPageRoute = new MaterialPageRoute(
              builder: (BuildContext context) => RegisterPage());
          Navigator.of(context).push(materialPageRoute);
        },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.yellow[100], Colors.yellowAccent[700]],
              radius: 0.7,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  showLogo(),
                  SizedBox(
                    height: 10.0,
                  ),
                  showAppName(),
                  emailInputText(),
                  SizedBox(
                    height: 10.0,
                  ),
                  passwordInputText(),
                  SizedBox(
                    height: 35.0,
                  ),
                  showButton(),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
