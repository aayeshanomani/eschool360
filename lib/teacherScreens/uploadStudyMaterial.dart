import 'dart:io';
import 'dart:typed_data';

import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../loading.dart';

class UploadStudyMaterial extends StatefulWidget {
  @override
  _UploadStudyMaterialState createState() => _UploadStudyMaterialState();
}

class _UploadStudyMaterialState extends State<UploadStudyMaterial> {
  String _value = "";
  String _value1 = "";
  String topics = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

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
      title: Text("Success"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        title: Text('Upload Study Material'),
        backgroundColor: bluecolor,
        elevation: 0.0,
      ),
      body: loading
          ? Loading()
          : SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
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
                                          style: TextStyle(color: bluecolor),
                                        )
                                      : Text(
                                          "  $_value",
                                          style: TextStyle(color: bluecolor),
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
                                    value: "Hindi",
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
                                        style: TextStyle(color: bluecolor),
                                      )
                                    : Text(
                                        "  $_value1",
                                        style: TextStyle(color: bluecolor),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(color: Colors.white),
                            width: screenWidth(context, dividedBy: 1.1),
                            height: 100,
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              onChanged: (value) {
                                setState(() {
                                  topics = value;
                                });
                              },
                              textInputAction: TextInputAction.newline,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: "Topics Covered"),
                            ),
                          ),
                          SizedBox(
                            height: 25,
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
                                  if (_value != "" &&
                                      _value1 != "" &&
                                      topics != "") {
                                    setState(() {
                                      loading = true;
                                    });
                                    String url = await getVideoAndUpload();
                                    Map<String, dynamic> data = {
                                      'class': _value,
                                      'subject': _value1,
                                      'topics': topics,
                                      'video': url
                                    };
                                    Database()
                                        .uploadVideoLectures(_value, data);
                                    setState(() {
                                      loading = false;
                                    });
                                    showAlertDialog(
                                        context, 'Uploaded Successfully');
                                  }
                                },
                                child: Text(
                                  "Upload Material",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  getVideoAndUpload() async {
    try {
      File file = await FilePicker.getFile(type: FileType.video);
      String filename = _value + _value1 + topics;
      var url = await saveVideo(file.readAsBytesSync(), filename);
      print(url);
      return url;
    } catch (e) {
      print(e.toString());
    }
  }

  saveVideo(Uint8List readAsBytesSync, String filename) async {
    try {
      StorageReference reference =
          FirebaseStorage.instance.ref().child('videos').child(filename);
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
