//need to put all values and also have to check if field exist

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/styles/widgets.dart';
import 'package:flutter/material.dart';

import '../loading.dart';

class Marks extends StatefulWidget {
  @override
  _MarksState createState() => _MarksState();
}

class _MarksState extends State<Marks> {
  String _value = "EXAMS";
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection(schoolID)
            .document(username)
            .collection('marks')
            .document(_value)
            .collection('marks')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Scaffold(body: Loading());
          print(snapshot.data.documents.length);
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
                    height: screenHeight(context) * 1.2,
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
                      height: screenHeight(context) * 1.5,
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
                                    value: "Half Yearly Exam",
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Final Exams"),
                                    value: "Final Exam",
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
                          if (_value != "EXAMS")
                            Padding(
                              padding: const EdgeInsets.all(22.0),
                              child: Container(
                                width: screenWidth(context, dividedBy: 1.1),
                                height: screenHeight(context, dividedBy: 1.35),
                                decoration: containerdecoration,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text("Subject"),
                                            Spacer(),
                                            Text("Maximum"),
                                            Spacer(),
                                            Text("Scored"),
                                            Spacer(),
                                            Text("%"),
                                            Spacer(),
                                            Text("Grade"),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      for (int i = 0;
                                          i < snapshot.data.documents.length;
                                          i++)
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(snapshot.data.documents[i]
                                                  ['subject']),
                                              Spacer(),
                                              Text(
                                                snapshot.data.documents[i]
                                                  ['totalMarks'],
                                                style: bluetext,
                                              ),
                                              Spacer(),
                                              Text(
                                                snapshot.data.documents[i]
                                                  ['marksObtained'],
                                                style: bluetext,
                                              ),
                                              Spacer(),
                                              Text(
                                                (double.parse(snapshot.data.documents[i]
                                                  ['marksObtained'])/double.parse(snapshot.data.documents[i]
                                                  ['totalMarks'])*100).toString()+'%',
                                                style: bluetext,
                                              ),
                                              Spacer(),
                                              
                                              Text(
                                                (double.parse(snapshot.data.documents[i]
                                                  ['marksObtained'])/double.parse(snapshot.data.documents[i]
                                                  ['totalMarks'])*100>90)?"A":(double.parse(snapshot.data.documents[i]
                                                  ['marksObtained'])/double.parse(snapshot.data.documents[i]
                                                  ['totalMarks'])*100>80)?'B':(double.parse(snapshot.data.documents[i]
                                                  ['marksObtained'])/double.parse(snapshot.data.documents[i]
                                                  ['totalMarks'])*100>70)?'C':
                                                  (double.parse(snapshot.data.documents[i]
                                                  ['marksObtained'])/double.parse(snapshot.data.documents[i]
                                                  ['totalMarks'])*100>60)?'D':
                                                  (double.parse(snapshot.data.documents[i]
                                                  ['marksObtained'])/double.parse(snapshot.data.documents[i]
                                                  ['totalMarks'])*100>50)?'E':'F',
                                                style: bluetext,
                                              ),
                                              
                                            ],
                                          ),
                                        ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      /*Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Spacer(),
                                            Text("CGPA"),
                                            Spacer(),
                                            Text("Overall%"),
                                            Spacer(),
                                            Text("Grade"),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Spacer(),
                                            Text(
                                              "8",
                                              style: bluetext,
                                            ),
                                            Spacer(),
                                            Text(
                                              "80",
                                              style: bluetext,
                                            ),
                                            Spacer(),
                                            Text(
                                              "B+",
                                              style: bluetext,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),*/
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
