import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:uasmikail/earthquake_list.dart';
import 'package:uasmikail/notes.dart';
import 'package:uasmikail/user_profile.dart';

class Navbar extends StatefulWidget {
  final String userEmail;

  Navbar({required this.userEmail});

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      EarthquakeList(),
      Notes(),
      UserProfile()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent, //atau white 24
        color: Color.fromRGBO(116, 53, 242, 1),
        items: <Widget>[
          Icon(Icons.data_object, color: Colors.white, size: 30),
          Icon(Icons.edit_note_sharp, color: Colors.white, size: 30),
          Icon(Icons.person, color: Colors.white, size: 30),
        ],
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
