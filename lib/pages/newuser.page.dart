import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:login_minimalist/pages/login.page.dart';
// import 'package:login_minimalist/widget/buttonNewUser.dart';
// import 'package:login_minimalist/widget/newEmail.dart';
// import 'package:login_minimalist/widget/newName.dart';
// import 'package:login_minimalist/widget/password.dart';
import 'package:login_minimalist/widget/show.dart';
import 'package:login_minimalist/widget/singup.dart';
import 'package:login_minimalist/widget/textNew.dart';
import 'package:login_minimalist/widget/userOld.dart';
// import 'package:login_minimalist/widget/height.dart';
// import 'package:login_minimalist/widget/weight.dart';
// import 'package:login_minimalist/widget/age.dart';

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  String email, password, name, age, weight, height, gender;
  var month;
  var selectedType;
  List<String> _bloodType = <String>[
    'ชาย',
    'หญิง',
  
  ];
  // int age, weight, height;
  final database = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    var children2 = <Widget>[
      Row(
        children: <Widget>[
          SingUp(),
          TextNew(),
        ],
      ),
      nameuser(),
      emaill(),
      passwordd(),
      heightt(),
      weightt(),
      agee(),
      buildTextFieldMonth(),
      button(),
      UserOld(),
    ];
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: children2,
            ),
          ],
        ),
      ),
    );
  }

  Widget button() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.blue[300],
            blurRadius: 10.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            offset: Offset(
              5.0, // horizontal, move right 10
              5.0, // vertical, move down 10
            ),
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: FlatButton(
          onPressed: () {
            print(height);
            print(weight);
            print(age);

            if (name == null ||
                name.isEmpty ||
                email == null ||
                email.isEmpty ||
                password == null ||
                password.isEmpty ||
                height == null ||
                weight == null ||
                age == null) {
              normalDialog(context, 'กรุณากรอกข้อมูล');
            } else {
              var root = database.child("user");
              root.child(email).once().then((DataSnapshot snapshot) {
                if ('${snapshot.value}' == 'null') {
                  regis();
                } else {
                  normalDialog(context, 'มีข้อมูลแล้ว');
                }
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'OK',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.lightBlueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget agee() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          onChanged: (value) => age = value.trim(),
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'อายุ',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  Container buildTextFieldMonth() {
    return Container(
        child: DropdownButton(
      items: _bloodType.map((value) {
        var dropdownMenuItem = DropdownMenuItem(
          child: Text(
            value,
          ),
          value: value,
        );
        return dropdownMenuItem;
      }).toList(),
      onChanged: (selectMonth) {
        setState(() {
          month = selectMonth;
        });
      },
      value: month,
      hint: Text('เพศ', style: TextStyle(fontSize: 20)),
    ));
  }

  Widget weightt() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          onChanged: (value) => weight = value.trim(),
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'น้ำหนัก',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  Widget heightt() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          onChanged: (value) => height = value.trim(),
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'ส่วนสูง',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  Widget passwordd() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Password',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  Widget nameuser() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          onChanged: (value) => name = value.trim(),
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'ชื่อ-นามสกุล',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  Widget emaill() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          onChanged: (value) => email = value.trim(),
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'Username',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> regis() async {
    var root = database.child("user");
    root.child(email).set({
      'name': name,
      'password': password,
      'height': height,
      'weight': weight,
      'age': age,
      'email': email,
      'gender': month,
      // 'gender': gender
    });
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => LoginPage(),
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
