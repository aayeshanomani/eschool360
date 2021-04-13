import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool360/alumniHome.dart';
import 'package:eschool360/hostel/screens/login.dart';
import 'package:eschool360/models/user.dart';
import 'package:eschool360/screens/HomeScreen.dart';
import 'package:eschool360/screens/LoginScreen.dart';
import 'package:eschool360/screens/counsellorHome.dart';
import 'package:eschool360/screens/librarianHome.dart';
import 'package:eschool360/screens/principalHome.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/services/helper.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/teacherScreens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Database database = Database();
  Stream<QuerySnapshot> docStream;

  readyScreen() async {
    isLoggedIn = await HelperFunc.getUserloggedIn();
  }

  @override
  void initState() {
    super.initState();
    readyScreen();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      return LoginScreen();
    } else if (!isLoggedIn) {
      return LoginScreen();
    } else {
      if (type == 'teacher') {
        return TeacherHome();
      } else if (type == 'principal') {
        return PrincipalHome();
      } else if (type == 'counsellor') {
        return CounsellorHome();
      } else if (type == 'librarian') {
        return LibrarianHome();
      } else if (type == 'hostelManager') {
        return Login();
      } else if (type == 'alumni') {
        return AlumniHome();
      } else {
        return HomeScreen();
      }
    }
  }
}
