import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';

class AddSyllabus extends StatefulWidget {
  final String exam;

  const AddSyllabus({Key key, this.exam}) : super(key: key);
  @override
  _AddSyllabusState createState() => _AddSyllabusState();
}

class _AddSyllabusState extends State<AddSyllabus> {
  String sysClass="", subject="", date, maxmarks, passmarks, topic;
  bool moveBack = false;

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        setState(() {
          moveBack = true;
        });
        Navigator.of(context).pushNamedAndRemoveUntil('/teacherSyllabus', (route) => false);
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
        backgroundColor: Colors.indigo[900],
        elevation: 0.0,
        title: Text("Add Syllabus"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
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
                                              sysClass = value;
                                            });
                                          },
                                          hint: sysClass == ""
                                              ? Text(
                                                  "  Select Class",
                                                  style: TextStyle(
                                                      color: bluecolor),
                                                )
                                              : Text(
                                                  "  $sysClass",
                                                  style: TextStyle(
                                                      color: bluecolor),
                                                )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
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
                                            subject = value;
                                          });
                                        },
                                        //value: _value1,
                                        hint: subject == ""
                                            ? Text(
                                                "   Select Subject",
                                                style:
                                                    TextStyle(color: bluecolor),
                                              )
                                            : Text(
                                                "  $subject",
                                                style:
                                                    TextStyle(color: bluecolor),
                                              ),
                                      ),
                                    ),
                                  ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: containerRadius),
                  width: screenWidth(context, dividedBy: 1.1),
                  height: 60,
                  child: Center(
                    child: TextField(
                      onChanged: (value) {
                        date = value;
                      },
                      keyboardType: TextInputType.datetime,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Date",
                          hintStyle: bluetext),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: containerRadius),
                  width: screenWidth(context, dividedBy: 1.1),
                  height: 60,
                  child: Center(
                    child: TextField(
                      onChanged: (value) {
                        maxmarks = value;
                      },
                      keyboardType: TextInputType.number,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Max Marks",
                          hintStyle: bluetext),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: containerRadius),
                  width: screenWidth(context, dividedBy: 1.1),
                  height: 60,
                  child: Center(
                    child: TextField(
                      onChanged: (value) {
                        passmarks = value;
                      },
                      keyboardType: TextInputType.number,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Passing Marks",
                          hintStyle: bluetext),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: containerRadius),
                  width: screenWidth(context, dividedBy: 1.1),
                  height: 60,
                  child: Center(
                    child: TextField(
                      onChanged: (value) {
                        topic = value;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Syllabus",
                          hintStyle: bluetext),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                RaisedButton(
                    onPressed: () {
                      Map<String, dynamic> syllabus = {
                        'class': sysClass,
                        'subject': subject,
                        'date': date,
                        'maxmarks': maxmarks,
                        'passmarks': passmarks,
                        'syllabus': topic
                      };
                      Database().addSyllabus(
                          widget.exam, sysClass, subject, syllabus);
                      showAlertDialog(context, 'Syllabus Uploaded');
                    },
                    child: Text(
                      'Save Syllabus',
                      style: TextStyle(color: whitecolor),
                    ),
                    color: bluecolor,
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
