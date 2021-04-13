import 'package:eschool360/loading.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/styles/viewVideo.dart';
import 'package:eschool360/teacherScreens/uploadingScreen.dart';
import 'package:flutter/material.dart';

class UploadVideos extends StatefulWidget {
  @override
  _UploadVideosState createState() => _UploadVideosState();
}

class _UploadVideosState extends State<UploadVideos> {
  String _value = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        title: Text('Video Lectures'),
        backgroundColor: bluecolor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: screenWidth(context, dividedBy: 1.1),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: bluecolor,
                      ),
                      items: [
                        DropdownMenuItem(
                          child: Text(" L"),
                          value: "L",
                        ),
                        DropdownMenuItem(
                          child: Text(" U"),
                          value: "U",
                        ),
                        DropdownMenuItem(
                          child: Text(" 1"),
                          value: "1",
                        ),
                        DropdownMenuItem(
                          child: Text("2"),
                          value: "2",
                        ),
                        DropdownMenuItem(
                          child: Text("3"),
                          value: "3",
                        ),
                        DropdownMenuItem(
                          child: Text("4"),
                          value: "4",
                        ),
                        DropdownMenuItem(
                          child: Text(" 5"),
                          value: "5",
                        ),
                        DropdownMenuItem(
                          child: Text(" 6"),
                          value: "6",
                        ),
                        DropdownMenuItem(
                          child: Text(" 7"),
                          value: "7",
                        ),
                        DropdownMenuItem(
                          child: Text(" 8"),
                          value: "8",
                        ),
                        DropdownMenuItem(
                          child: Text(" 9"),
                          value: "9",
                        ),
                        DropdownMenuItem(
                          child: Text(" 10"),
                          value: "10",
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                      hint: _value == ""
                          ? Text(
                              "  Select Class",
                              style: TextStyle(color: bluecolor),
                            )
                          : Text(
                              "  $_value",
                              style: TextStyle(color: bluecolor),
                            )),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            if (_value != "")
              StreamBuilder(
                  stream: Database().getVideoLectures(_value),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Loading();
                    } else if (snapshot.data.documents.length < 1) {
                      return Container(
                        height: 500,
                        child: Center(child: Text('No Videos Uploaded yet!!')),
                      );
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          for (int i = 0;
                              i < snapshot.data.documents.length;
                              i++)
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: RawMaterialButton(
                                onPressed: () {
                                  videoUrl =
                                      snapshot.data.documents[i]['video'];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewVideo()));
                                },
                                elevation: 5.0,
                                fillColor: Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Subject: ',
                                          style: blacktext,
                                        ),
                                        Text(
                                          snapshot.data.documents[i]['subject'],
                                          style: bluetext,
                                        ),
                                        Text(
                                          '   |   Student: ',
                                          style: blacktext,
                                        ),
                                        Text(
                                          'All',
                                          style: bluetext,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Topic: ',
                                          style: bigblacktext,
                                        ),
                                        Text(
                                          snapshot.data.documents[i]['topics'],
                                          style: bluetext,
                                        ),
                                        SizedBox(
                                          width: 25.0,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 20.0),
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: bluecolor,
                                        borderRadius: containerRadius,
                                      ),
                                      child: Text(
                                        'Watch',
                                        style: TextStyle(color: whitecolor),
                                      ),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(20.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  //side: BorderSide(color: Colors.indigo[600])
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UploadingScreen()));
                },
                color: Colors.white,
                elevation: 7.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'UPLOAD VIDEOS',
                    style: bigbluetext,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
