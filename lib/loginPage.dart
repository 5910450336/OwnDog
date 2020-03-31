import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget showLogo() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('images/logoDog.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'OWNER DOG',
      style: TextStyle(
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
          color: Colors.brown[900],
          fontFamily: 'Mitr'),
    );
  }

  Widget logInButton() {
    return RaisedButton(
      color: Colors.yellowAccent[700],
      child: Text(
        'LOG IN',
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {},
    );
  }

  Widget registerButton() {
    return RaisedButton(
      color: Colors.blueGrey[100],
      child: Text('REGISTER'),
      onPressed: () {},
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        logInButton(),
        SizedBox(
          width: 10.0,
        ),
        registerButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            showLogo(), 
            showAppName(), 
            showButton()
          ],
        ),
      )),
    );
  }
}
