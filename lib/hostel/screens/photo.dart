import 'package:flutter/material.dart';

import '../utils/utils.dart';

class PhotoActivity extends StatefulWidget {
  final String url;

  PhotoActivity(this.url);

  @override
  State<StatefulWidget> createState() {
    return new PhotoActivityState(url);
  }
}

class PhotoActivityState extends State<PhotoActivity> {
  String url;

  PhotoActivityState(this.url);

  @override
  void initState() {
    super.initState();
    checkInternet().then((internet) {
      if (internet == null || !internet) {
        oneButtonDialog(context, "No Internet connection", "", true);
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 4.0,
      ),
      body: new Image.network(url),
    );
  }
}
