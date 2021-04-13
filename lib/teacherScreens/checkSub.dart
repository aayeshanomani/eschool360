import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool360/loading.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/styles/viewPdf.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CheckSub extends StatefulWidget {
  @override
  _CheckSubState createState() => _CheckSubState();
}

class _CheckSubState extends State<CheckSub> {
  String _value = '';
  String _value1 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        title: Text('Submissions'),
        backgroundColor: bluecolor,
      ),
      body: StreamBuilder(
          stream: Database().getStudents(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
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
                  if (_value != "" && _value1 != "")
                    for (int i = 0; i < snapshot.data.documents.length; i++)
                      if (snapshot.data.documents[i]['class'].toString() ==
                          _value)
                        Column(
                          children: <Widget>[
                            StreamBuilder(
                                stream: Firestore.instance
                                    .collection(schoolID)
                                    .document(
                                        snapshot.data.documents[i]['username'])
                                    .collection('diary')
                                    .where('subject', isEqualTo: _value1)
                                    .snapshots(),
                                builder: (context, snapshot2) {
                                  if (!snapshot2.hasData)
                                    return Loading();
                                  else if (snapshot2.data.documents.length <
                                      1) {
                                    return Container(
                                      
                                      
                                    );
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: RawMaterialButton(
                                      onPressed: () {
                                        if (snapshot2.data.documents[0]
                                            ['submitted']) {
                                          String passdata = snapshot2
                                              .data.documents[0]['submission']
                                              .toString();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Viewpdf(),
                                                  settings: RouteSettings(
                                                      arguments: passdata)));
                                        }
                                      },
                                      elevation: 6.0,
                                      fillColor: Colors.white,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Student: ',
                                                style: blacktext,
                                              ),
                                              Text(
                                                snapshot.data.documents[i]
                                                    ['name'],
                                                style: bluetext,
                                              ),
                                              Text(
                                                '   |   Status: ',
                                                style: blacktext,
                                              ),
                                              Text(
                                                snapshot2.data.documents[0]
                                                        ['submitted']
                                                    ? 'Submitted'
                                                    : 'NA',
                                                style: bluetext,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      'Format: Text  |  Note: ',
                                                      style: blacktext,
                                                    ),
                                                    Text(
                                                      snapshot2.data.documents[0]['note'],
                                                      style: bluetext,
                                                    ),
                                                  ],
                                                ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          snapshot2.data.documents[0]
                                                  ['submitted']
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '[Open]',
                                                      style: bigbluetext,
                                                    ),
                                                  ],
                                                )
                                              : Container()
                                        ],
                                      ),
                                      padding: EdgeInsets.all(20.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        //side: BorderSide(color: Colors.indigo[600])
                                      ),
                                    ),
                                  );
                                }),
                                StreamBuilder(
                                stream: Firestore.instance
                                    .collection(schoolID)
                                    .document(
                                        snapshot.data.documents[i]['username'])
                                    .collection('Pdfdiary')
                                    .where('subject', isEqualTo: _value1)
                                    .snapshots(),
                                builder: (context, snapshot2) {
                                  if (!snapshot2.hasData)
                                    return Loading();
                                  else if (snapshot2.data.documents.length <
                                      1) {
                                    return Container(
                                      
                                    );
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: RawMaterialButton(
                                      onPressed: () {
                                        if (snapshot2.data.documents[0]
                                            ['submitted']) {
                                          String passdata = snapshot2
                                              .data.documents[0]['submission']
                                              .toString();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Viewpdf(),
                                                  settings: RouteSettings(
                                                      arguments: passdata)));
                                        }
                                      },
                                      elevation: 6.0,
                                      fillColor: Colors.white,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Student: ',
                                                style: blacktext,
                                              ),
                                              Text(
                                                snapshot.data.documents[i]
                                                    ['name'],
                                                style: bluetext,
                                              ),
                                              Text(
                                                '   |   Status: ',
                                                style: blacktext,
                                              ),
                                              Text(
                                                snapshot2.data.documents[0]
                                                        ['submitted']
                                                    ? 'Submitted'
                                                    : 'NA',
                                                style: bluetext,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      'Format: ',
                                                      style: blacktext,
                                                    ),
                                                    Text(
                                                      'PDF',
                                                      style: bluetext,
                                                    ),
                                                  ],
                                                ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          snapshot2.data.documents[0]
                                                  ['submitted']
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '[Open]',
                                                      style: bigbluetext,
                                                    ),
                                                  ],
                                                )
                                              : Container()
                                        ],
                                      ),
                                      padding: EdgeInsets.all(20.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        //side: BorderSide(color: Colors.indigo[600])
                                      ),
                                    ),
                                  );
                                }),
                                Divider(thickness: 2, color: bluecolor,)
                          ],
                        )
                ],
              ),
            );
          }),
    );
  }
}
