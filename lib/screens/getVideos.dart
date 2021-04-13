import 'package:eschool360/loading.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/styles/viewVideo.dart';
import 'package:flutter/material.dart';

class VideoLectures extends StatefulWidget {
  @override
  _VideoLecturesState createState() => _VideoLecturesState();
}

class _VideoLecturesState extends State<VideoLectures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        title: Text('Video Lectures'),
        backgroundColor: bluecolor,
      ),
      body: StreamBuilder(
          stream: Database().getVideoLectures(classname),
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
                  for (int i = 0; i < snapshot.data.documents.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: RawMaterialButton(
                        onPressed: () {
                          videoUrl = snapshot.data.documents[i]['video'];
                          Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewVideo()));
                        },
                        elevation: 6.0,
                        fillColor: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
    );
  }
}
