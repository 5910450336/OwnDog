import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:own_dog/models/dog.dart';
import 'package:tflite/tflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PredictDogWidget extends StatefulWidget {
  @override
  _PredictDogWidgetState createState() => _PredictDogWidgetState();
}

class _PredictDogWidgetState extends State<PredictDogWidget> {
  List _outputs;
  File _image;
  bool _loading = false;
  DocumentSnapshot documentSnapshot;
  List<Dog> dogModels = List();

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
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

        Dog dogM =
            Dog.fromMap(snapshot.data); // โยนค่าใน firebase เข้าไปใน object

        setState(() {
          dogModels.add(dogM); // มันได้ค่ามาปุ๊ปก็จะให้ทำrefresh statelessใหม่
        });
      }
    });
  }

  Widget showLoopDog() {
    for (int i = 0; i < dogModels.length; i++) {
      if (_outputs[0]["label"].contains(dogModels[i].name)) {
        print("DOGS Length=${dogModels[i].name}");
        return Column(
          children: <Widget>[
            Text(
              "ANNOUNCE",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'K2D',
              ),
            ),
            Image.network(dogModels[i].imagePath),
            Text(
              "Name: ${dogModels[i].name} ${dogModels[i].detail}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontFamily: 'K2D',
              ),
            ),
          ],
        );
      }
    }
    return Container();
  }

  Widget showUserPicture() {
    return Column(
      children: <Widget>[
        Text(
          "MY PICTURE",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'K2D',
          ),
        ),
        Image.file(_image)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _image == null ? Container() : showUserPicture(),
                      SizedBox(
                        height: 20,
                      ),
                      _outputs != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  // readDocument(),
                                  showLoopDog(),
                                ],
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            onPressed: pickImage,
            child: Icon(Icons.image),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: cameraPickImage,
            child: Icon(Icons.camera),
          ),
        ],
      ),
    );
  }

  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  cameraPickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
