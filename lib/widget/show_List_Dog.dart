import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowListDog extends StatelessWidget {
  //Method
  Container dogCard(DocumentSnapshot document) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[300]),
      child: Card(
        child: Column(
          children: <Widget>[
            Image.network(document['imagePath']),
            Padding(
              padding: EdgeInsets.all(7.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      "Name: ${document['name']} ${document['detail']}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'K2D',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(7.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Icon(Icons.thumb_up),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      'Like',
                      style: TextStyle(fontSize: 18.0, fontFamily: 'Mitr',),
                      
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Icon(Icons.comment),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text(
                      'Comments',
                      style: TextStyle(fontSize: 18.0, fontFamily: 'Mitr',),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('dogs').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return ListView(
              children: snapshot.data.documents.map(
                (DocumentSnapshot document) {
                  return dogCard(document);
                },
              ).toList(),
            );
        }
      },
    );
  }
}
