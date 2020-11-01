import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:login_minimalist/pages/login.page.dart';

// class PreviousOrdersPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("Not contructed"),);
//   }
// }
class PreviousOrdersPage extends StatefulWidget {
  @override
  _PreviousOrdersPageState createState() => _PreviousOrdersPageState();
}

class _PreviousOrdersPageState extends State<PreviousOrdersPage> {
  @override
  final database = FirebaseDatabase.instance.reference();
  String email, show, newresult, newlbm, realresult, newbmi, rebmi,dis;

  var _weight, _height, _age, _name, _email, _gender;
//  var _weight, _height, _age;
  @override
  void initState() {
    super.initState();
    showUser();
  }

  void showUser() async {
    var data = database.child("user");
    var h1, w1, a1, result, lbm, bmi, bmih1, bmih2;

    await data.child(ee).once().then((DataSnapshot snapshot) {
      _height = snapshot.value['height'];
      _weight = snapshot.value['weight'];
      _age = snapshot.value['age'];
      _name = snapshot.value['name'];
      _email = snapshot.key;
      _gender = snapshot.value['gender'];

      h1 = int.parse(_height);
      w1 = int.parse(_weight);
      a1 = int.parse(_age);
      bmih1 = h1 / 100;
      bmih2 = bmih1 * 2;
      print(bmih1);
      print(bmih2);

      bmi = (w1 / bmih2)+2.3;
      print(bmi);
      newbmi = bmi.toStringAsPrecision(3);

      if (bmi < 18.5) {
        rebmi = 'ค่า BMI น้อยกว่า 18.5';
        dis = 'ผอม';
      }
      else if (bmi > 18.5 && bmi < 24) {
        rebmi = 'ค่า BMI  18.5 ถึง 24';
        dis = 'สมส่วน';
      }
       else if (bmi > 24) {
        rebmi = 'ค่า BMI  มากกว่า 24';
        dis = 'อ้วน';
      }

      if (_gender == 'ชาย') {
        lbm = (0.32810 * (w1)) + ((0.33929 * (h1)) - 29.5336);
        newlbm = lbm.toStringAsPrecision(3);

        result = (370 + (21.6 * lbm)) * 1.4;
        newresult = result.toStringAsPrecision(4);
      } else if (_gender == 'หญิง') {
        lbm = (0.29569 * (w1)) + ((0.42813 * (h1)) - 43.2933);
        newlbm = lbm.toStringAsPrecision(3);

        result = (370 + (21.6 * lbm)) * 1.4;
        newresult = result.toStringAsPrecision(4);
      }

      // realresult =  String.format("%1.2f", newresult);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: <Widget>[
        Container(
            decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://bloximages.chicago2.vip.townnews.com/tdn.com/content/tncms/assets/v3/editorial/f/da/fda485d2-87e7-547b-8c86-6a026ff418ec/59e7cb648a982.image.jpg?resize=1200%2C928'),
              fit: BoxFit.cover),
        )),

        wetext(),
        hitext(),
        // name(),
        emailtext(),
        bmii(),
        textbmi1(),
        textbmi2(),
        // textbmi3(),
      ]),
    );
  }

  // Widget agetext() => Container(
  //     margin: EdgeInsets.only(top: 300), child: Text('อายุ:   ' + _age));

  Widget wetext() => Container(
      margin: EdgeInsets.only(top: 200, left: 120),
      child: Text(' *ค่า LBM =>   ' + newlbm,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          )));

  Widget hitext() => Container(
      margin: EdgeInsets.only(top: 150, left: 100),
      child: Text('ไม่ควรเกิน ' + ' ' + newresult + '  kcal/day',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          )));

  // Widget name() => Container(
  //     margin: EdgeInsets.only(top: 1, left: 1),
  //     child: Text('ผลลัพท์ของคุณ:   ' + _name,
  //         style: TextStyle(
  //           color: Colors.black, fontSize: 22,
  //             fontWeight: FontWeight.w800,
  //         )));
  Widget emailtext() => Container(
      margin: EdgeInsets.only(top: 120, left: 155),
      child: Text("For YOU ! ",
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          )));

  Widget bmii() => Container(
      margin: EdgeInsets.only(top: 240, left: 130),
      child: Text("*BMI => " + newbmi,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w900,
          )));

  Widget textbmi1() => Container(
      margin: EdgeInsets.only(top: 280, left: 120),
      child: Text(rebmi,
          style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          )));

  Widget textbmi2() => Container(
      margin: EdgeInsets.only(top: 320, left: 150),
      child: Text('"'+dis+'"',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          )));
//   Widget textbmi3() => Container(
//       margin: EdgeInsets.only(top: 380, left: 50),
//       child: Text("BMI => อ้วน = 25.0 - 29.9",
//           style: TextStyle(
//             color: Colors.white,
//           )));
}
