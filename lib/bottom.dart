import 'package:flutter/material.dart';

import 'Home.dart';
import 'fav.dart';
import 'profile.dart';
import 'search.dart';
import 'ui.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar();

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    const name1(),
    const name2(),
    const name4(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Increment',
        backgroundColor: Colors.greenAccent,
        child: new Icon(
          Icons.add,
        ),
        elevation: 4.0,
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.card_travel_outlined),
                color: Colors.grey,
                onPressed: () {},
              ),
            ),
            Expanded(child: new Text('')),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colors.grey,
                onPressed: () {},
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.person_outline),
                color: Colors.grey,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
