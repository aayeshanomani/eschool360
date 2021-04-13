import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/styles/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddMarks extends StatefulWidget {
  @override
  _AddMarksState createState() => _AddMarksState();
}

class _AddMarksState extends State<AddMarks> {
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

  String _value = "";
  String _value1 = "";
  String _value2 = "";
  List<TextEditingController> _controller =
  List.generate(500, (i) => TextEditingController());
  TextEditingController totalmarks = TextEditingController();
  var i;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Database().getStudents(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo[900],
              elevation: 0.0,
              title: Text("Marks"),
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: screenHeight(context) * 5,
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
                      height: screenHeight(context) * 4.6,
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
                                      child: Text("Half Yearly Exam"),
                                      value: "Half Yearly Exam",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Final Exam"),
                                      value: "Final Exam",
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _value2 = value;
                                    });
                                    for (i = 0;
                                    i < snapshot.data.documents.length;
                                    i++) {
                                      if (snapshot.data.documents[i]['class']
                                          .toString() ==
                                          _value) {
                                        getMarks(
                                            snapshot
                                                .data.documents[i]['username']
                                                .toString(),
                                            _value2,
                                            _value1,
                                            i);
                                      }
                                    }
                                  },
                                  //value: _value1,
                                  hint: _value2 == ""
                                      ? Text(
                                    "   Select Exam",
                                    style: TextStyle(color: bluecolor),
                                  )
                                      : Text(
                                    "  $_value2",
                                    style: TextStyle(color: bluecolor),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            if (_value != "")
                              for (i = 0;
                              i < snapshot.data.documents.length;
                              i++)
                                if (snapshot.data.documents[i]['class']
                                    .toString() ==
                                    _value)
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    width: screenWidth(context, dividedBy: 1.1),
                                    color: Colors.white,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                            snapshot.data.documents[i]['name']),
                                        Spacer(),
                                        Container(
                                          color: bluecolor,
                                          width: 60,
                                          height: 30,
                                          child: TextField(
                                            controller: _controller[i],
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                    //height: 100,
                                  ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: screenWidth(context, dividedBy: 1),
                              height: 50,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Out Of :",
                                    style: bluebold,
                                  ),
                                  //Spacer(),
                                  Container(
                                      width: 60,
                                      height: 30,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: totalmarks,
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
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
                                        Map<String, dynamic> marks = 
                                          {
                                            'subject': _value1,
                                            "marksObtained":
                                            _controller[i].text.toString(),
                                            "totalMarks":
                                            totalmarks.text.toString()
                                          };
                                        
                                        Database().addMarks(
                                            snapshot
                                                .data.documents[i]['username']
                                                .toString(),
                                            _value2,
                                            _value1,
                                            marks);
                                      }
                                    }
                                    showAlertDialog(
                                        context, 'Marks Added Successfully');
                                  },
                                  child: Text(
                                    "Add Marks",
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
                  ),
                ],
              ),
            ),
          );
        });
  }

  getMarks(String username, String exam, String sub, int i) {
    StreamBuilder(
        stream: Database().getMarks(username, exam, sub),
        builder: (context, snapshot) {
          setState(() {
            print(snapshot.data.documents[0]['marksObtained'].toString());
            _controller[i] = TextEditingController(
                text: snapshot.data.documents[0]['marksObtained']);
          });
        });
  }
}
