import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';

class LeaveApp extends StatefulWidget {
  const LeaveApp({ Key key }) : super(key: key);

  @override
  _LeaveAppState createState() => _LeaveAppState();
}

class _LeaveAppState extends State<LeaveApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
      (
        title: Text("Pending Leave Applications"),
        backgroundColor: bluecolor,
      ),
      body: Container
      (
        height: 399,
        child: Center(child: Text("No pending applications as of now."),),
      ),
    );
  }
}