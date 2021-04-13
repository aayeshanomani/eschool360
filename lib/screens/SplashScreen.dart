import 'dart:async';
import 'package:eschool360/screens/LoginScreen.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/services/helper.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/wrapper.dart';
import 'package:eschool360/services/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getInfo() async {
    username = await HelperFunc.getUsername();
    schoolID = await HelperFunc.getSchoolId();
    isLoggedIn = await HelperFunc.getUserloggedIn();
    type = await HelperFunc.getType();
    //if (type == 'student') classname = Database().getClass();
  }

  @override
  void initState() {
    super.initState();
    getInfo();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Wrapper())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/images/logo.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  height: 200,
                  //width: 200,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text
                (
                  'SMGV',
                  style: TextStyle(
                    color: bluecolor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              SpinKitThreeBounce(
                color: bluecolor,
                size: 24,
              ),
              SizedBox(height: 50,),
              Center(
                child: Text
                (
                  'Powered by Edukaizen',
                  style: TextStyle(
                    color: bluecolor,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
