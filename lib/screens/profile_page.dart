import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:own_dog/screens/login_page.dart';
import 'dart:io' show Platform;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //Explicit
  String login = '...';
  String phone = '...';

  //Method
  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Future<void> findDisplayName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser =
        await firebaseAuth.currentUser(); // ดึง data ที่ user login ในขณะมา
    setState(() {
      // ทำการ setstate refresh ใหม่
      login = firebaseUser.displayName;
    });
    print('Login = $login\nPhone = $phone');
  }

  Widget showLogin() {
    return Text('LogIN by $login');
  }

  Widget signOutButton() {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Sign Out',
      onPressed: () {
        myAlert();
      },
    );
  }

  void myAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text('Are you sure?'),
                content: Text('Do you want to SIGN OUT?'),
                actions: <Widget>[
                  cancelButton(),
                  okButton(),
                ],
              )
            : AlertDialog(
                title: Text('Are you sure?'),
                content: Text('Do you want to SIGN OUT?'),
                actions: <Widget>[
                  cancelButton(),
                  okButton(),
                ],
              );
      },
    );
  }

  Widget okButton() {
    return FlatButton(
      child: Text(
        'OK',
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        processSignOut();
      },
    );
  }

  Future<void> processSignOut() async {
    // method sign out
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then(
      (response) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => LoginPage(),
          ),
          (Route<dynamic> route) => false,
        );
      },
    );
  }

  Widget cancelButton() {
    return FlatButton(
      child: Text(
        'Cancel',
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rewind and remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You will never be satisfied.'),
                Text('You\’re like me. I’m never satisfied.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Regret'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildAnimalListItem(BuildContext context, String name) {
    return Container(
        padding: EdgeInsets.all(16),
        child: Text(name, style: TextStyle(fontSize: 22)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          signOutButton(),
        ],
      ),
      body: ListView(
        children: <Widget>[
          buildAnimalListItem(context, "Dog"),
          buildAnimalListItem(context, "Cat"),
          showLogin(),
        ],
      ),
    );
  }
}
