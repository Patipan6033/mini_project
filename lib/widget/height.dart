import 'package:flutter/material.dart';

class InputHeight extends StatefulWidget {
  @override
  _InputHeightState createState() => _InputHeightState();
}

class _InputHeightState extends State<InputHeight> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 50, right: 50),
      child: Container(
        height: 30,
        width: MediaQuery.of(context).size.width,
        child: TextField(
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
}