import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/styles/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../loading.dart';

class TeacherAttendance extends StatefulWidget {
  @override
  _TeacherAttendanceState createState() => _TeacherAttendanceState();
}

class _TeacherAttendanceState extends State<TeacherAttendance> {
  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/teacherHome', (route) => false);
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

  String _value = "Class";
  String date;
  List<String> present = List.generate(500, (i) => 'not present');
  //bool checkP = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        elevation: 0.0,
        title: Text("Attendance"),
      ),
      body: StreamBuilder(
          stream: Database().getStudents(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Loading();
            return SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: screenHeight(context) * 3,
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
                      height: screenHeight(context) * 2.6,
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
                                  hint: Text(
                                    "   " + _value,
                                    style: TextStyle(color: bluecolor),
                                  ),
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
                                //borderRadius: containerRadius
                              ),
                              child: FlatButton(
                                  onPressed: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2020),
                                            lastDate: DateTime(2100))
                                        .then((value) {
                                          setState(() {
                                            date = value.toString().split(' ')[0];
                                          });
                                      print(date);
                                    });
                                  },
                                  child: Text(
                                    date==null?"Select date":date,
                                    style: TextStyle(color: bluecolor),
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: containerRadius,
                              ),
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Name',
                                        style: bigblacktext,
                                      ),
                                      Spacer(),
                                      Text(
                                        'Present',
                                        style: bigbluetext,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        'Absent',
                                        style: bigbluetext,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  for (int i = 0;
                                      i < snapshot.data.documents.length;
                                      i++)
                                    if (snapshot.data.documents[i]['class']
                                            .toString() ==
                                        _value)
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              snapshot.data.documents[i]
                                                  ['name'],
                                              style: blacktext,
                                            ),
                                            Spacer(),
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    present[i] = 'present';
                                                    //checkP = true;
                                                  });
                                                },
                                                child: Icon((present[i] ==
                                                        'present')
                                                    ? Icons.check
                                                    : FontAwesomeIcons.square)),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    present[i] = 'not present';
                                                    //checkP = false;
                                                  });
                                                },
                                                child: Icon((present[i] ==
                                                        'present')
                                                    ? FontAwesomeIcons.square
                                                    : Icons.check)),
                                          ],
                                        ),
                                      )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: screenWidth(context, dividedBy: 2),
                              decoration: BoxDecoration(
                                  color: bluecolor,
                                  borderRadius: containerRadius),
                              child: FlatButton(
                                  onPressed: () {
                                    for (int i = 0;
                                        i < snapshot.data.documents.length;
                                        i++) {
                                      if (snapshot.data.documents[i]['class']
                                              .toString() ==
                                          _value) {
                                        Map<String, dynamic> attendance = {
                                          'date': date,
                                          date: present[i],
                                        };

                                        Database().markAttendance(
                                            snapshot
                                                .data.documents[i]['username']
                                                .toString(),
                                            attendance);
                                      }
                                    }
                                    showAlertDialog(context,
                                        'Attendance Marked Successfully');
                                  },
                                  child: Text(
                                    "Save",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            )
                          ],
                        ),
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
