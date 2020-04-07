import 'package:flutter/material.dart';
import 'package:own_dog/views/pages/login_page.dart';

class OwnDog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Owner Dog',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
