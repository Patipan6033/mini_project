import 'package:flutter/material.dart';
import 'package:login_minimalist/pages/food_item_page.dart';
import 'package:login_minimalist/pages/liked_page.dart';
import 'package:login_minimalist/pages/menu_page.dart';
import 'package:login_minimalist/pages/previous_orders_page.dart';
import 'package:login_minimalist/pages/profile_page.dart';
import 'package:login_minimalist/pages/login.page.dart';
import 'package:login_minimalist/providers/food_items_provider.dart';

import 'package:login_minimalist/components/action_button.dart';
import 'package:login_minimalist/components/food_item_card.dart';
import 'package:login_minimalist/model/food_item.dart';

void main() => runApp(FoodOrderingApp());
class FoodOrderingApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        accentColor: Color(0xff127A73),
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Widget> _pages = [MenuPage(), PreviousOrdersPage(),ProfilePage()];

  List<IconData> _bottomBarIcons = [Icons.home, Icons.calendar_today, Icons.person_outline,];
  List<String> _bottomBarLabels = ["Menu","Result", "Profile"];

  int _currentBottomTabSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _buildAppBar(),
            Expanded(child: _pages[_currentBottomTabSelected]),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }


  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: Text("Diater", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600,),)),
           IconButton(
          icon: Icon(Icons.arrow_forward ),
          onPressed: () {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => LoginPage(),
            );
            Navigator.pushAndRemoveUntil(context, route, (route) => false);
          },
          iconSize: 40, 
        ),
        ],
      ),
    );
  }


  Widget _buildBottomBar() {
    return Container(
      color: Color(0xffB9D7D5),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(26), topRight: Radius.circular(26,),),
        child: Container(
          color: Colors.white,
          child: Row(
            children: _bottomBarIcons.map((icon) {
              int position = _bottomBarIcons.indexOf(icon);
              return Expanded(child:
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentBottomTabSelected = position;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _currentBottomTabSelected == position ? _getCircle() : Icon(_bottomBarIcons[position]),
                        Visibility(
                          visible: position == _currentBottomTabSelected,
                          child: Text(_bottomBarLabels[position],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Theme.of(context).accentColor, fontSize: 12,),),
                        )
                      ],
                    ),
                  ),
                )
              );
            }).toList(),
          ),
        ),
      ),
    );
  }


  Widget _getCircle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: CircleAvatar(
        backgroundColor: Theme.of(context).accentColor,
        radius: 4,
      ),
    );
  }




}



