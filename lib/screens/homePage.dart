import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:own_dog/screens/loginPage.dart';
import 'package:own_dog/screens/profilePage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Method

  Widget profileButton() {
    return IconButton(
        icon: Icon(Icons.account_circle, size: 30,),
        tooltip: 'Profile',
        onPressed: () {
          MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext context) => ProfilePage());
          Navigator.of(context).push(materialPageRoute);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home DOG'),
        elevation: 1.0,
        backgroundColor: Colors.yellowAccent[700],
        actions: <Widget>[
          profileButton(),
        ],
      ),
      body: Text('OWOWOWOWO'),
    );
  }
}
