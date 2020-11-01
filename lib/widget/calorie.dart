import 'package:login_minimalist/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';



class Calorie extends StatefulWidget {
  @override
  _CalorieState createState() => _CalorieState();
}

class _CalorieState extends State<Calorie> {
  final database = FirebaseDatabase.instance.reference();
  String email, show;
  var _w, _h, _a;
//  var _weight, _height, _age;
  @override
  void initState() {
    super.initState();
    showsar();
  }

  void showsar() async {
    var data = database.child("user");

    await data.child('bas').once().then((DataSnapshot snapshot) {
      _h = snapshot.value['height'].toString();
      _w = snapshot.value['weight'].toString();
      _a = snapshot.value['age'].toString();

      print(_h);
      print('น้ำหนัก' + _w);
      print('อายุ' + _a);

      print(snapshot.value);
      // print('===$show');

      // return Center(child: Text("${snapshot.value}"),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
