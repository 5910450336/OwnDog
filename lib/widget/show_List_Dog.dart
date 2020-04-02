import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowListDog extends StatefulWidget {
  @override
  ShowListDogState createState() => ShowListDogState();
}

class ShowListDogState extends State<ShowListDog> {
  // Field

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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('This is showListDog'),
    );
  }
}
