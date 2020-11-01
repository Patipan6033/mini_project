import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:login_minimalist/pages/login.page.dart';
import 'package:login_minimalist/pages/home.dart';



class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final database = FirebaseDatabase.instance.reference();
  String email, show;
 
  var _weight, _height, _age, _name, _email, _gender;
//  var _weight, _height, _age;
  @override
  void initState() {
    super.initState();
    showUser();
  }



  void showUser() async {
    var data = database.child("user");

    await data.child(ee).once().then((DataSnapshot snapshot) {
      _height = snapshot.value['height'].toString();
      _weight = snapshot.value['weight'].toString();
      _age = snapshot.value['age'].toString();
      _name = snapshot.value['name'].toString();
      _email = snapshot.key;
       _gender = snapshot.value['gender'].toString();
      // Map<dynamic, dynamic> values = snapshot.value;
      // print(values);
      // values.forEach((k, v) {
      //   String no_room = k.toString();
      //   print(no_room);
      // });

      // print(_name);
      // print(_email);
      // print(_height);
      // print('น้ำหนัก' + _weight);
      // print('อายุ' + _age);

      // print(snapshot.value);
      // print('===$show');

      // return Center(child: Text("${snapshot.value}"),);
    });
  }

  @override
  Widget build(BuildContext context) {
      

    return SafeArea(
      
      child: Stack(children: <Widget>[
        Container (
        decoration: BoxDecoration(
           image: DecorationImage(
           image: NetworkImage('https://www.healthline.com/hlcmsresource/images/AN_images/low-carb-fast-foods-1200x628-facebook.jpg',
           ), fit: BoxFit.cover),
        

        )),
        // new Image.asset('assets/pro.png'),

        
        agetext(),
        wetext(),
        hitext(),
        name(),
        emailtext(),
        gender(),
        img(),

      ]),

    );
  }

   

  Widget img() => Container(
      margin: EdgeInsets.only(top: 40,left: 20), child: Text('Profile: ',style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.w800,)));

  Widget wetext() => Container(
      margin: EdgeInsets.only(top: 340,left: 20), child: Text('น้ำหนัก:   ' + _weight,style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,)));
Widget  agetext() => Container(
      margin: EdgeInsets.only(top: 290,left: 20), child: Text('อายุ:   ' +  _age,style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,)));


  Widget hitext() => Container(
      margin: EdgeInsets.only(top: 240,left: 20), child: Text('ส่วนสูง:    ' + _height,style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,)));

  Widget name() => Container(
      margin: EdgeInsets.only(top: 140,left: 20),
      child: Text('ชื่อ-นามสกุล:     ' + _name,style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,)));
  Widget emailtext() => Container(
      margin: EdgeInsets.only(top: 190,left: 20), child: Text('ชื่อผู้ใช้:' + _email,style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,)));
 Widget gender() => Container(
      margin: EdgeInsets.only(top: 390,left: 20), child: Text('เพศ:   ' + _gender,style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,)));
}
