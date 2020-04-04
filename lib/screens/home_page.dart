import 'package:flutter/material.dart';
import 'package:own_dog/screens/profile_page.dart';
import 'package:own_dog/widgets/predict_dog.dart';
import 'package:own_dog/widgets/show_list_dog.dart';
import 'package:own_dog/widgets/add_list_dog.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Explcit
  List<Widget> showWidgets = [ShowListDog(), PredictDogWidget(), AddListDog()];
  int index = 0;
  String login = '...';

  //Method
  Widget profileButton() {
    return IconButton(
      icon: Icon(
        Icons.account_circle,
        size: 30,
      ),
      tooltip: 'Profile',
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => ProfilePage(),
        ),
      ),
    );
  }

  BottomNavigationBarItem homeNav() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.home, size: 40),
      title: Text('Home'),
    );
  }

  BottomNavigationBarItem findDogNav() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.pageview, size: 40),
      title: Text('Find Dog'),
    );
  }

  BottomNavigationBarItem regisDogNav() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.add_box, size: 40),
      title: Text('Register Dog'),
    );
  }

  Widget myButtonNavBar() {
    return BottomNavigationBar(
      onTap: (int i) {
        setState(() {
          index = i;
        });
      },
      currentIndex: index,
      items: <BottomNavigationBarItem>[
        homeNav(),
        findDogNav(),
        regisDogNav(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OWN DOGS',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'K2D'),
        ),
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: Colors.yellowAccent[700],
        actions: <Widget>[
          profileButton(),
        ],
      ),
      body: showWidgets[index],
      bottomNavigationBar: myButtonNavBar(),
    );
  }
}
