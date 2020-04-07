import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:own_dog/views/login_page.dart';
import 'dart:io' show Platform;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String login = '...';

  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Future<void> findDisplayName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      login = firebaseUser.displayName;
    });
  }

  Widget signOutButton() {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Sign Out',
      onPressed: () => myAlert(),
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

  Widget showLogin() {
    return Text('LogIn by $login');
  }

  Widget showLogoProfile() {
    return Padding(
      padding: EdgeInsets.all(7.0),
      child: Icon(
        Icons.face,
        size: 60,
      ),
    );
  }

  Widget showContent() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.blueGrey[50],
            child: Column(
              children: <Widget>[
                // Image.network(document['imagePath']),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      showLogoProfile(),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.note),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "$login",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'K2D',
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.call),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '0122334567',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'K2D',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.indigo[50],
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.pets),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'My pet1',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'K2D',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.indigo[50],
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.pets),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'My pet2',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'K2D',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.indigoAccent,
        elevation: 1.0,
        actions: <Widget>[
          signOutButton(),
        ],
      ),
      body: ListView(
        children: <Widget>[
          showContent(),
        ],
      ),
    );
  }
}
