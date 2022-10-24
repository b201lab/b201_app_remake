import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar>{
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Calendar',
      style: optionStyle,
    ),
    Text(
      'Index 2: Kas',
      style: optionStyle,
    ),
    Text(
      'Index 3: Users',
      style: optionStyle,
    ),
  ];
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CreateBottombar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 85.0,
        width: 85.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
            },
            backgroundColor: Colors.red,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100.0),
                boxShadow: [BoxShadow(
                  offset: Offset(0.0,15.0),
                  blurRadius: 45.0,
                  spreadRadius: 12.0,
                  color: Colors.red.shade800,
                )]
              ),
              child: Image.asset("img/barcode.png",
                height: 25.0,
                width: 25.0,),
            ),
          ),
        ),
      )

    );
  }

  Container CreateBottombar(BuildContext context) {
    return Container(
      height: 80,
      //add ClipRRect widget for Round Corner
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                  // margin: EdgeInsets.all(10.0),
                  child: Icon(FeatherIcons.home, size: 30.0,),
              ),
              label: '',
              // backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
              icon: Container(
                  margin: EdgeInsets.only(right: 75.0),
                  child: Icon(FeatherIcons.calendar,size: 30.0,)
              ),
              label: '',
              // backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
              icon: Container(
                  margin: EdgeInsets.only(left: 75.0),
                  child: Icon(FeatherIcons.dollarSign,size: 30.0,),
              ),
              label: '',
              // backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
                icon: Container(
                    child: Icon(FeatherIcons.users, size: 30.0,)
                ),
                label: '',
                // backgroundColor: Colors.black
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        )
      ),
    );
  }
}
