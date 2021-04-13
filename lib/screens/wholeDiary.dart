import 'package:eschool360/screens/Diary.dart';
import 'package:eschool360/screens/pdfDiary.dart';
import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WholeDiary extends StatefulWidget {
  @override
  _WholeDiaryState createState() => _WholeDiaryState();
}

class _WholeDiaryState extends State<WholeDiary> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Diary(),
    PdfDiary()
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.book),
            title: Text('Diary'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.pen),
            title: Text('Homework'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: bluecolor,
        onTap: _onItemTapped,
      ),
    );
  }
}
