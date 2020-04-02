import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:own_dog/models/dog_model.dart';

class ShowListDog extends StatefulWidget {
  @override
  ShowListDogState createState() => ShowListDogState();
}

class ShowListDogState extends State<ShowListDog> {
  // Field
  List<DogModel> dogModels = List();

  // Method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllData();
  }

  Future<void> readAllData() async {
    Firestore firestore = Firestore.instance;
    // collection จาก firestore มีได้มากกว่าหนึ่ง
    CollectionReference collectionReference = firestore.collection('dogs');
    //snapshot จะเอาทั้งสามอันที่ link กันมา collection, document, field
    await collectionReference.snapshots().listen((respone) {
      List<DocumentSnapshot> snapshots = respone.documents;
      for (var snapshot in snapshots) {
        print('Name = ${snapshot.data['name']}');

        DogModel dogM = DogModel.fromMap(
            snapshot.data); // โยนค่าใน firebase เข้าไปใน object

        setState(() {
          dogModels.add(dogM); // มันได้ค่ามาปุ๊ปก็จะให้ทำrefresh statelessใหม่
        });
      }
    });
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.all(15.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            image: DecorationImage(
              image: NetworkImage(dogModels[index].imagePath),
              fit: BoxFit.cover,
            )),
      ),
    ); //การหาของจอทั้งหมด
  }

  Widget showName(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          dogModels[index].name,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Mitr',
            color: Colors.brown[600],
          ),
        ),
      ],
    );
  }

  Widget showDetail(int index) {
    String tempDetail = dogModels[index].detail;

    if (tempDetail.length > 100) {
      tempDetail = tempDetail.substring(0, 99);
      tempDetail = '$tempDetail...';
    }
    return Text(
      tempDetail,
      style: TextStyle(
        fontSize: 14,
        fontFamily: 'Mitr',
        fontStyle: FontStyle.italic,
        color: Colors.grey[800],
      ),
    );
  }

  Widget showText(int index) {
    return Container(padding: EdgeInsets.only(right: 12.0),
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            showName(index),
            showDetail(index),
          ],
        ));
  }

  Widget showListView(int index) {
    return Row(
      children: <Widget>[
        showImage(index),
        showText(index),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: dogModels.length,
        itemBuilder: (BuildContext context, int index) {
          return showListView(index);
        },
      ),
    );
  }
}
