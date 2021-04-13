import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/styles/widgets.dart';
import 'package:flutter/material.dart';

import '../loading.dart';
class Syllabus extends StatefulWidget {
  @override
  _SyllabusState createState() => _SyllabusState();
}

class _SyllabusState extends State<Syllabus> {
  String dropdownvalue = "Subjects";
  String _value = "Exams";
  Database database = Database();

  Widget syllabuscontainer(String subject,
      String date,
      String maxmarks,
      passmarks,
      String syllabus) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
    height: 180,
    width: screenWidth(context,dividedBy: 1.1),
    decoration:containerdecoration,
    child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Subject : $subject",style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            RichText(text: TextSpan(
              text: "Exam Date : ",
              style: blacktext,
              children: <TextSpan>[
                TextSpan(text: "$date",style: bluetext)
              ]
            ),),
            SizedBox(height: 10,),
            RichText(text: TextSpan(
                text: "Maximum Marks : ",
                style: blacktext,
                children: <TextSpan>[
                  TextSpan(text: "$maxmarks",style: bluetext)
                ]
            ),),
            SizedBox(height: 10,),
            RichText(text: TextSpan(
                text: "Pass Marks : ",
                style: blacktext,
                children: <TextSpan>[
                  TextSpan(text: "$passmarks",style: bluetext)
                ]
            ),),
            SizedBox(height: 10,),
            RichText(text: TextSpan(
                text: "Syllabus : ",
                style: blacktext,
                children: <TextSpan>[
                  TextSpan(text: "$syllabus",style: bluetext)
                ]
            ),),
          ],
        ),
    ),
  ),
      );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: database.getStudentSyllabus(_value),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Scaffold(body: Loading());
        return Scaffold(
          appBar: AppBar
            (
            backgroundColor: Colors.indigo[900],
            elevation: 0.0,
            title: Text("Syllabus"),
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: screenHeight(context)*2,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: bluecolor
                  ),
                  height: screenHeight(context,dividedBy: 2),
                  width: screenWidth(context),
                ),
                name(),
                nameContainer(),
                dpContainer(),
                about(),
                Positioned(
                  top: screenHeight(context,dividedBy: 3.7),
                  child: Container(
                    height: screenHeight(context)*1.6,
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: whitecolor,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 30,),
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
                       
                        if(_value!="EXAMS")
                          for(var i =0;i<snapshot.data.documents.length;i++)
                        syllabuscontainer(snapshot.data.documents[i]['subject'],
                            snapshot.data.documents[i]['date'],
                            snapshot.data.documents[i]['maxmarks'],
                            snapshot.data.documents[i]['passmarks'],
                            snapshot.data.documents[i]['syllabus']),

                      ],
                    ) ,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
