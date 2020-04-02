import 'package:flutter/material.dart';

class AddListDog extends StatefulWidget {
  @override
  _AddListDogState createState() => _AddListDogState();
}

class _AddListDogState extends State<AddListDog> {
  // Explicit

  // Method
  Widget uploadButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width*0.5,
          height: 40,
          child: RaisedButton.icon(
            color: Colors.yellow[700],
            onPressed: () {},
            icon: Icon(
              Icons.cloud_upload,
              color: Colors.white,
            ),
            label: Text(
              'REGISTER DOG',
              style: TextStyle(color: Colors.white),
            ),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget nameInputForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'DOG NAME',
          helperText: 'Your dog name',
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange[900],
          ),
          icon: Icon(
            Icons.pets,
            size: 30,
            color: Colors.orange[900],
          ),
        ),
      ),
    );
  }

  Widget detailInputForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'DETAIL',
          helperText: 'Detail Your dog e.g. age, breed, habit',
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange[900],
          ),
          icon: Icon(
            Icons.description,
            size: 30,
            color: Colors.orange[900],
          ),
        ),
      ),
    );
  }

  Widget cameraButton() {
    return IconButton(
        icon: Icon(
          Icons.add_a_photo,
          size: 36.0,
          color: Colors.green[700],
        ),
        onPressed: () {});
  }

  Widget galleryButton() {
    return IconButton(
        icon: Icon(
          Icons.add_photo_alternate,
          size: 38.0,
          color: Colors.green[700],
        ),
        onPressed: () {});
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        cameraButton(),
        galleryButton(),
      ],
    );
  }

  Widget showImage() {
    return Container(
      padding: EdgeInsets.all(1.0),
      // color: Colors.brown,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.4,
      child: Image.asset('images/pic.png'),
    );
  }

  Widget showContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          showImage(),
          showButton(),
          SizedBox(
            height: 20,
          ),
          nameInputForm(),
          detailInputForm(),
          SizedBox(
            height: 50,
          ),
          uploadButton(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          showContent(),
          
        ],
      ),
    );
  }
}
