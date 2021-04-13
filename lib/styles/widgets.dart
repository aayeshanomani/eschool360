import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool360/screens/Attendance.dart';
import 'package:eschool360/screens/Diary.dart';
import 'package:eschool360/screens/Information.dart';
import 'package:eschool360/screens/Marks.dart';
import 'package:eschool360/screens/StudentTimetable.dart';
import 'package:eschool360/screens/Syllabus.dart';
import 'package:eschool360/screens/wholeDiary.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/teacherScreens/AddMarks.dart';
import 'package:eschool360/teacherScreens/AddTimetable.dart';
import 'package:eschool360/teacherScreens/TeacherAttendance.dart';
import 'package:eschool360/teacherScreens/TeacherDiary.dart';
import 'package:eschool360/teacherScreens/syllabus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'common.dart';

Widget homeIcons(String imPath, String text, int dsPath, context) {
  return RawMaterialButton(
    onPressed: () {
      switch (dsPath) {
        case 1:
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Information()));
          break;
        case 2:
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => WholeDiary()));
          break;
        case 3:
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => Syllabus()));
          break;
        case 5:
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => Marks()));
          break;
        case 4:
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Attendance()));
          break;
        case 6:
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => StudentTimetable()));
          break;
      }
    },
    elevation: 6.0,
    fillColor: Colors.white,
    child: Column(
      children: <Widget>[
        Container(
          child: Image.asset(
            imPath,
            fit: BoxFit.cover,
            width: 120,
            height: 90,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: TextStyle(color: bluecolor, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    padding: EdgeInsets.all(20.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      //side: BorderSide(color: bluecolor)
    ),
  );
}

class nameContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: screenHeight(context, dividedBy: 8),
      left: screenWidth(context, dividedBy: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: containerRadius,
        ),
        height: 90,
        width: screenWidth(context) / 1.12,
      ),
    );
  }
}

class dpContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: screenHeight(context, dividedBy: 11),
      left: screenWidth(context, dividedBy: 7),
      child: Container(
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.lightBlue[50]),
        child: Icon(
          Icons.person,
          size: 70,
          color: bluecolor,
        ),
        height: 90,
        width: 90,
      ),
    );
  }
}

class name extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Database().getDocument(),
        builder: (context, snapshot) {
          return Positioned(
            top: screenHeight(context, dividedBy: 12),
            left: screenWidth(context, dividedBy: 2.5),
            child: Text(
              snapshot.data.documents[0]['name'].toString(), //TODO
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          );
        });
  }
}

class about extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Database().getDocument(),
        builder: (context, snapshot) {
          return Positioned(
            top: screenHeight(context, dividedBy: 7),
            left: screenWidth(context, dividedBy: 2.5),
            child: Text(
              type == 'student'
                  ? 'Roll No.: ' +
                      snapshot.data.documents[0]['rollno'].toString() +
                      '\n\nClass: ' +
                      classname +
                      ' | Section: ' +
                      snapshot.data.documents[0]['section'].toString()
                  : "\nAdmin", //TODO
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          );
        });
  }
}

Widget teacherhomeIcons(String imPath, String text, int dsPath, context) {
  return RawMaterialButton(
    onPressed: () {
      switch (dsPath) {
        case 1:
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => Information()));
          break;
        case 2:
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => TeacherDiary()));
          break;
        case 3:
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => TeacherSyllabus()));
          break;
        case 5:
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => AddMarks()));
          break;
        case 4:
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => TeacherAttendance()));
          break;
        case 6:
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => AddTimetable()));
          break;
      }
    },
    elevation: 6.0,
    fillColor: Colors.white,
    child: Column(
      children: <Widget>[
        Container(
          child: Image.asset(
            imPath,
            fit: BoxFit.cover,
            width: 120,
            height: 90,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: TextStyle(color: bluecolor, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    padding: EdgeInsets.all(20.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      //side: BorderSide(color: bluecolor)
    ),
  );
}
