import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
        height: screenHeight(context),
        color: bluecolor,
        child: Column(
          children: <Widget>[
            Container
            (
              height: 500,
              child: Center(
                child: SpinKitSpinningCircle
                (
                  color: whitecolor,
                  size: 50.0,
                ),
              ),
            ),
            Text('Loading...',
            style: TextStyle(color: whitecolor),)
          ],
        )
      ),
    );
  }
}