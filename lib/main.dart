import 'package:eschool360/models/user.dart';
import 'package:eschool360/screens/Attendance.dart';
import 'package:eschool360/screens/SplashScreen.dart';
import 'package:eschool360/screens/Syllabus.dart';
import 'package:eschool360/services/auth.dart';
import 'package:eschool360/teacherScreens/home.dart';
import 'package:eschool360/teacherScreens/syllabus.dart';
import 'package:eschool360/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: Auth().user,
      child: MaterialApp
      (
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          '/teacherSyllabus': (_)=> TeacherSyllabus(),
          '/teacherHome': (_)=> TeacherHome(),
          '/wrapper': (_)=> Wrapper()
        },
      ),
    );
  }
}

