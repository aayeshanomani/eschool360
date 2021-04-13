import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool360/loading.dart';
import 'package:eschool360/services/database.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../styles/common.dart';

class Diary extends StatefulWidget {
  @override
  _DiaryState createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  Database database = Database();
  bool uploading = false;
  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/wrapper', (route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget card(String subject, String note, bool submitted) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: RawMaterialButton(
          onPressed: () async {
            if (!submitted) {
              setState(() {
                uploading = true;
              });
              String url = await getPdfAndUpload();
              var data = {"submission": url, "submitted": true};
              Database().submitHomeworkDiary(subject, data);
              showAlertDialog(context, 'Homework Submitted Successfully');
            }
          },
          elevation: submitted ? 1.0 : 6.0,
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
                    subject,
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
                    'Note: ',
                    style: bigblacktext,
                  ),
                  Text(
                    note,
                    style: bigbluetext,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: bluecolor,
                  borderRadius: containerRadius,
                ),
                child: Text(
                  submitted ? 'Submitted' : 'Click to submit',
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
      );

  @override
  void initState() {
    // TODO: implement initState
    uploading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return uploading
        ? Loading()
        : StreamBuilder(
            stream: database.getDiary(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Loading();
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.indigo[900],
                  elevation: 0.0,
                  title: Text("Digital Diary"),
                ),
                body: SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: screenHeight(context) * 1.6,
                      ),
                      Container(
                        decoration: BoxDecoration(color: bluecolor),
                        height: screenHeight(context, dividedBy: 2),
                        width: screenWidth(context),
                      ),
                      Positioned(
                        top: screenHeight(context, dividedBy: 12),
                        left: screenWidth(context, dividedBy: 20),
                        child: GestureDetector(
                          onTap: () {
                            //TODO: show calender to select date
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: containerRadius,
                            ),
                            height: 90,
                            width: screenWidth(context) / 1.12,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Today',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.calendarAlt,
                                    color: bluecolor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: screenHeight(context, dividedBy: 4.5),
                        child: SingleChildScrollView(
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.lightBlue[50],
                                borderRadius: borderRadius,
                              ),
                              height: screenHeight(context) * 2,
                              width: screenWidth(context),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      for (var i = 0;
                                          i < snapshot.data.documents.length;
                                          i++)
                                        card(
                                            snapshot.data.documents[i]
                                                ['subject'],
                                            snapshot.data.documents[i]['note'],
                                            snapshot.data.documents[i]
                                                ['submitted']),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ]),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
  }

  getPdfAndUpload() async {
    try {
      var range = new Random();
      String randomname = "";
      for (int i = 0; i < 20; i++) {
        randomname += range.nextInt(100).toString();
      }
      File file = await FilePicker.getFile(type: FileType.custom);
      String filename = randomname + '.pdf';
      var url = await savePdf(file.readAsBytesSync(), filename);
      print(url);
      return url;
    } catch (e) {
      print(e.toString());
    }
  }

  savePdf(Uint8List readAsBytesSync, String filename) async {
    try {
      StorageReference reference =
          FirebaseStorage.instance.ref().child('submissions').child(filename);
      StorageUploadTask uploadTask = reference.putData(readAsBytesSync);
      String url = await (await uploadTask.onComplete).ref.getDownloadURL();
      print(url);
      return url;
    } catch (e) {
      showAlertDialog(context, 'Upload unsuccessful: ' + e.toString());
    }
  }
}
