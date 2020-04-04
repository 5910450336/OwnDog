import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:own_dog/screens/home_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Explicit
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //key ที่เช็ค validation
  String nameString, emailString, passwordString, tempPassword, phoneString;

  // Method
  Widget okRegisterButton() {
    return IconButton(
      icon: Icon(Icons.done),
      tooltip: 'DONE',
      onPressed: () {
        print('Click OK');
        if (_formKey.currentState.validate() &&
            tempPassword == passwordString) {
          _formKey.currentState
              .save(); // ถ้าผ่านจะเอาอันที่ onsaved มาเก็บบันทึกค่าไว้
          print(
            'name = $nameString, email = $emailString, password = $passwordString, phone = $phoneString',
          );
          registerThread();
        } else if (_formKey.currentState.validate() &&
            tempPassword != passwordString) {
          myAlert('Re-Password and Password must match',
              'Please enter the same password.');
        }
      },
    );
  }

  Future<void> registerThread() async {
    // Method Add Email/Password to Firebase
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      print('Register Success for Email = $emailString');

      setupDisplayName();
    }).catchError((response) {
      String title = response.code;
      String message = response.message;
      print('title = $title, message = $message');
      myAlert(title, message);
    });
  }

  Future<void> setupDisplayName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.currentUser().then(
      (response) {
        UserUpdateInfo userUpdateInfo = UserUpdateInfo();
        userUpdateInfo.displayName = nameString;
        response.updateProfile(userUpdateInfo);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage(),
          ),
          (Route<dynamic> route) => false,
        );
      },
    );
  }

  void myAlert(String title, String message) {
    // Show Alert Box
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: ListTile(
            leading: Icon(
              Icons.error,
              color: Colors.red,
              size: 40,
            ),
            title: Text(
              title,
              style: TextStyle(color: Colors.red),
            ),
          ),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Widget nameInputText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.face,
          color: Colors.grey[800],
          size: 35.0,
        ),
        labelText: 'NAME',
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        helperText: 'e.g. name nickname ',
        helperStyle: TextStyle(fontStyle: FontStyle.italic),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please Fill Your Name in the Blank';
        } else {
          return null;
        }
      },
      onSaved: (String value) =>
          nameString = value.trim(), // ตัดช่องว่างอัตโนมัติ
    );
  }

  Widget emailInputText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          color: Colors.grey[800],
          size: 35.0,
        ),
        labelText: 'E-MAIL',
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        helperText: 'e.g. name@email.com',
        helperStyle: TextStyle(fontStyle: FontStyle.italic),
      ),
      validator: (String value) {
        if (!((value.contains('@') && (value.contains('.'))))) {
          return 'Please Type Email e.g. you@email.com';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        emailString = value.trim();
      },
    );
  }

  Widget passwordInputText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.lock,
          color: Colors.grey[800],
          size: 35.0,
        ),
        labelText: 'PASSWORD',
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        helperText: 'Password must contain at least 6 characters and Number',
        helperStyle: TextStyle(fontStyle: FontStyle.italic),
      ),
      validator: (String value) {
        if (value.length < 6) {
          return 'Password More 6 character';
        } else {
          return null;
        }
      },
      onChanged: (String value) {
        passwordString = value.trim();
      },
      onSaved: (String value) {
        passwordString = value.trim();
      },
      obscureText: true,
    );
  }

  Widget rePasswordInputText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.lock,
          color: Colors.grey[800],
          size: 35.0,
        ),
        labelText: 'RE-PASSWORD',
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        helperText: 'Re-Password must match Password',
        helperStyle: TextStyle(fontStyle: FontStyle.italic),
      ),
      validator: (String value) {
        if (value.length < 6) {
          return 'Re-Password must match Password';
        } else {
          return null;
        }
      },
      onChanged: (String value) {
        tempPassword = value.trim();
      },
      obscureText: true,
    );
  }

  Widget phoneInputText() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        icon: Icon(
          Icons.contact_phone,
          color: Colors.grey[800],
          size: 35.0,
        ),
        labelText: 'PHONE NUMBER',
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        helperText: 'e.g. 0123456789, 029994445',
        helperStyle: TextStyle(fontStyle: FontStyle.italic),
      ),
      validator: (String value) {
        if (value.isEmpty || value.length < 9 || value.length > 10) {
          return 'Phone number must contain at 9-10 digit\n e.g. 0123456789';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        phoneString = value.trim(); // ใส่ค่า phone
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade700,
        title: Text('REGISTER'),
        elevation: 1.0,
        actions: <Widget>[okRegisterButton()],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            nameInputText(),
            emailInputText(),
            passwordInputText(),
            rePasswordInputText(),
            phoneInputText(),
          ],
        ),
      ),
    );
  }
}
