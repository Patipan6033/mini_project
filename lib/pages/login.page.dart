
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_minimalist/widget/first.dart';
import 'package:login_minimalist/widget/textLogin.dart';
import 'package:login_minimalist/widget/verticalText.dart';
import 'package:login_minimalist/pages/home.dart';
import 'package:login_minimalist/widget/show.dart';


String ee;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final database = FirebaseDatabase.instance.reference();
  String email, password;
  @override
  Widget build(BuildContext context) {
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
              children: <Widget>[
                Row(children: <Widget>[
                  VerticalText(),
                  TextLogin(),
                ]),
                emaill(),
                pass(),
                logins(),
                FirstTime(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget emaill() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
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

  Widget pass() {
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

  Widget logins() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blue[300],
              blurRadius: 10.0, // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FlatButton(
          onPressed: () {
            print('$email $password');
            loginss();
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

  Future<Null> loginss() async {
    var data = database.child("user");

    await data.child(email).once().then((DataSnapshot snapshot) {
      ee = snapshot.key;
      print("${snapshot.value}");
      if ('${snapshot.value}' == 'null') {
        normalDialog(context, 'emailผิดดดดด');
      } else if (password == '${snapshot.value['password']}') {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => FoodOrderingApp(),
        );
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
      } else {
        print('รหัสไม่ถูก');
        normalDialog(context, 'รหัสไม่ถูกต้อง กรุณากรอกใหม่');
      }
    });
  }
}
