import 'package:eschool360/loading.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/styles/widgets.dart';
import 'package:eschool360/teacherScreens/addSyllabus.dart';
import 'package:flutter/material.dart';

class TeacherSyllabus extends StatefulWidget {
  @override
  _TeacherSyllabusState createState() => _TeacherSyllabusState();
}

class _TeacherSyllabusState extends State<TeacherSyllabus> {
  String dropdownvalue = "Subjects";
  String _value = "EXAMS";
  Database database = Database();
  String sysClass = "";
  bool showSyllabus = false;

  Widget syllabuscontainer(String subject, String date, String maxmarks,
          passmarks, String syllabus) =>
      Container(
        height: 180,
        margin: EdgeInsets.all(10.0),
        width: screenWidth(context, dividedBy: 1.1),
        decoration: containerdecoration,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Subject : $subject",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                    text: "Exam Date : ",
                    style: blacktext,
                    children: <TextSpan>[
                      TextSpan(text: "$date", style: bluetext)
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                    text: "Maximum Marks : ",
                    style: blacktext,
                    children: <TextSpan>[
                      TextSpan(text: "$maxmarks", style: bluetext)
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                    text: "Pass Marks : ",
                    style: blacktext,
                    children: <TextSpan>[
                      TextSpan(text: "$passmarks", style: bluetext)
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                    text: "Syllabus : ",
                    style: blacktext,
                    children: <TextSpan>[
                      TextSpan(text: "$syllabus", style: bluetext)
                    ]),
              ),
            ],
          ),
        ),
      );

  Widget getSyllabus(snapshot, i) {
    //ready(snapshot, i);
    //if (checkSyllabus == null) return Container();
    //if (checkSyllabus) return Container();
    try {
      return StreamBuilder(
        stream: database.getSyllabus(
            snapshot.data.documents[i]['username'].toString(),
            _value,
            sysClass),
        builder: (context, snapshot1) {
          //print(snapshot1.data.documents[0]);
          if (!snapshot1.hasData) return Container();
          if (snapshot1.data.documents.length >= 1)
            return Column(
              children: <Widget>[
                for (int j = 0; j < snapshot1.data.documents.length; j++)
                  syllabuscontainer(
                      snapshot1.data.documents[j]['subject'],
                      snapshot1.data.documents[j]['date'],
                      snapshot1.data.documents[j]['maxmarks'],
                      snapshot1.data.documents[j]['passmarks'],
                      snapshot1.data.documents[j]['syllabus'])
              ],
            );
          else
            return Container(
              margin: EdgeInsets.only(top: 100, bottom: 50),
              child: Center(
                child: Text('No Syllabus Updated'),
              ),
            );
        },
      );
    } catch (e) {
      print(e.toString());
      return Container(
        margin: EdgeInsets.only(top: 100),
        child: Center(
          child: Text('No Syllabus Updated'),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //ready();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: database.getSyllabusDoc(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Scaffold(body: Loading());
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.indigo[900],
                elevation: 0.0,
                title: Text("Syllabus"),
              ),
              body: SingleChildScrollView(
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
                                      child: Text("Half-yearly Exams"),
                                      value: "Half-yearly Exams",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Final Exams"),
                                      value: "Final Exams",
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
                                            style: TextStyle(color: bluecolor),
                                          )
                                        : Text(
                                            "  $sysClass",
                                            style: TextStyle(color: bluecolor),
                                          )),
                              ),
                            ),
                            if (snapshot.data.documents.length < 1)
                              Container(
                                margin: EdgeInsets.only(top: 100),
                                child: Center(
                                  child: Text('No Syllabus Updated'),
                                ),
                              ),
                            if (snapshot.data.documents.length >= 1 &&
                                showSyllabus)
                              for (int i = 0;
                                  i < snapshot.data.documents.length;
                                  i++)
                                getSyllabus(snapshot, i),
                            SizedBox(
                              height: 50,
                            ),
                            RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    showSyllabus = !showSyllabus;
                                  });
                                },
                                child: Text(
                                  showSyllabus
                                      ? 'Hide Syllabus'
                                      : 'Show Syllabus',
                                  style: TextStyle(color: whitecolor),
                                ),
                                color: bluecolor,
                                elevation: 3.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                )),
                            SizedBox(
                              height: 50,
                            ),
                            RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddSyllabus(
                                                exam: _value,
                                              )));
                                },
                                child: Text(
                                  'Add Syllabus',
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
                  ],
                ),
              ));
        });
  }
}
