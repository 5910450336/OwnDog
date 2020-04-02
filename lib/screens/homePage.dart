import 'package:flutter/material.dart';
import 'package:own_dog/screens/profilePage.dart';
import 'package:own_dog/widget/show_List_Dog.dart';
import 'package:own_dog/widget/add_List_Dog.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Explcit
  List<Widget> showWidgets = [ShowListDog(), AddListDog()];
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
        onPressed: () {
          MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext context) => ProfilePage());
          Navigator.of(context).push(materialPageRoute);
        });
  }

  BottomNavigationBarItem homeNav() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.home, size: 40),
      title: Text('Home'),
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
        regisDogNav(),
      ],
    );
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
      body: showWidgets[index],
      bottomNavigationBar: myButtonNavBar(),
    );
  }
}
