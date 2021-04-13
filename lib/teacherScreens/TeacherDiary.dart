import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool360/loading.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/styles/widgets.dart';
import 'package:eschool360/teacherScreens/checkSub.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class TeacherDiary extends StatefulWidget {
  @override
  _TeacherDiaryState createState() => _TeacherDiaryState();
}

class _TeacherDiaryState extends State<TeacherDiary> {
  TextEditingController note = TextEditingController();
  String _value = "";
  String _value1 = "";
  bool uploading = false;
  @override
  void dispose() {
    //_value = "";
    //_value1 = "";
    note.text = "";
    super.dispose();
  }

  Database database = Database();

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

  Widget card(String std, String note, String subject) => Container(
        height: 130,
        width: screenWidth(context, dividedBy: 1.1),
        child: InkWell(
          onDoubleTap: () {
            Database().delHomework(std);
            showAlertDialog(context, "Diary note successfully deleted");
            print("deleted");
          },
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Spacer(),
                  Row(
                    children: <Widget>[
                      Text(
                        "Class - $std",
                        style: bluebold,
                      ),
                      Spacer(),
                      Text(
                        "Subject - $subject",
                        style: bluebold,
                      )
                    ],
                  ),
                  Spacer(),
                  Text("$note"),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection(schoolID).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(body: Loading());
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo[900],
              elevation: 0.0,
              title: Text("Diary"),
            ),
            body: uploading
                ? Loading()
                : SingleChildScrollView(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: screenHeight(context) * 2,
                        ),
                        Container(
                          decoration: BoxDecoration(color: bluecolor),
                          height: screenHeight(context, dividedBy: 2),
                          width: screenWidth(context),
                        ),
                        name(),
                        nameContainer(),
                        dpContainer(),
                        about(),
                        Positioned(
                          top: screenHeight(context, dividedBy: 3.7),
                          child: Container(
                            height: screenHeight(context) * 1.6,
                            width: screenWidth(context),
                            decoration: BoxDecoration(
                              borderRadius: borderRadius,
                              color: whitecolor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(22.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
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
                                                  style: TextStyle(
                                                      color: bluecolor),
                                                )
                                              : Text(
                                                  "  $_value",
                                                  style: TextStyle(
                                                      color: bluecolor),
                                                )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
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
                                            child: Text("Hindi"),
                                            value: "Hindi",
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Kannada"),
                                            value: "Kannada",
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Phusical Education"),
                                            value: "Physicaleducation",
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Social Science"),
                                            value: "Socialscience",
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Science"),
                                            value: "Science",
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Maths"),
                                            value: "Maths",
                                          ),
                                          DropdownMenuItem(
                                            child: Text("English"),
                                            value: "English",
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Computer"),
                                            value: "Computer",
                                          ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _value1 = value;
                                          });
                                        },
                                        //value: _value1,
                                        hint: _value1 == ""
                                            ? Text(
                                                "   Select Subject",
                                                style:
                                                    TextStyle(color: bluecolor),
                                              )
                                            : Text(
                                                "  $_value1",
                                                style:
                                                    TextStyle(color: bluecolor),
                                              ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    width: screenWidth(context, dividedBy: 1.1),
                                    height: 100,
                                    child: TextField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      controller: note,
                                      textInputAction: TextInputAction.newline,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 15,
                                              bottom: 11,
                                              top: 11,
                                              right: 15),
                                          hintText: "Write your Note here"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                    width: screenWidth(context, dividedBy: 2),
                                    decoration: BoxDecoration(
                                        color: bluecolor,
                                        borderRadius: containerRadius),
                                    child: FlatButton(
                                        onPressed: () {
                                          Database().addHomework(
                                              _value, _value1, note.text);
                                          showAlertDialog(context,
                                              "Diary note successfully sent.");
                                          for (var i = 0;
                                              i <
                                                  snapshot
                                                      .data.documents.length;
                                              i++)
                                            if (snapshot
                                                    .data.documents[i]['class']
                                                    .toString() ==
                                                _value)
                                              database.addDiary(
                                                  snapshot.data.documents[i]
                                                      ['username'],
                                                  _value1,
                                                  note.text);
                                        },
                                        child: Text(
                                          "Send",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    width: screenWidth(context, dividedBy: 2),
                                    decoration: BoxDecoration(
                                        color: bluecolor,
                                        borderRadius: containerRadius),
                                    child: FlatButton(
                                        onPressed: () async {
                                          if (_value == "" || _value1 == "") {
                                            showAlertDialog(context,
                                                'Select Class and Subject');
                                          } else {
                                            setState(() {
                                              uploading = true;
                                            });
                                            String url =
                                                await getPdfAndUpload();

                                            var data = {
                                              "PDF": url,
                                              "Filename":
                                                  'Homework' + _value + _value1,
                                              "subject": _value1,
                                              "submitted": false
                                            };
                                            print(url);
                                            for (var i = 0;
                                                i <
                                                    snapshot
                                                        .data.documents.length;
                                                i++)
                                              if (snapshot.data
                                                      .documents[i]['class']
                                                      .toString() ==
                                                  _value)
                                                database.addPdfDiary(
                                                    snapshot.data.documents[i]
                                                        ['username'],
                                                    _value1,
                                                    data);
                                            showAlertDialog(context,
                                                'PDF uploaded Successfully');
                                          }
                                        },
                                        child: Text(
                                          "Upload PDF",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    width: screenWidth(context, dividedBy: 2),
                                    decoration: BoxDecoration(
                                        color: bluecolor,
                                        borderRadius: containerRadius),
                                    child: FlatButton(
                                        onPressed: () async {
                                          Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CheckSub()));
                                        },
                                        child: Text(
                                          "Check Submissions",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ],
                              ),
                            ),
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
      File file = await FilePicker.getFile(type: FileType.custom);
      String filename = _value + _value1 + '.pdf';
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
          FirebaseStorage.instance.ref().child(_value + _value1 + 'homework');
      StorageUploadTask uploadTask = reference.putData(readAsBytesSync);
      String url = await (await uploadTask.onComplete).ref.getDownloadURL();
      print(url);
      return url;
    } catch (e) {
      showAlertDialog(context,
          'Either the class or the subject is not selected ' + e.toString());
    }
  }
}
