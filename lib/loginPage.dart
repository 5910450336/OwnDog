import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Own Dog", style: TextStyle(color: Colors.white),),),
      
    );
  }
}

