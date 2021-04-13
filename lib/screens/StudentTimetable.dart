import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/styles/widgets.dart';
import 'package:flutter/material.dart';

import '../loading.dart';
class StudentTimetable extends StatefulWidget {
  @override
  _StudentTimetableState createState() => _StudentTimetableState();
}

class _StudentTimetableState extends State<StudentTimetable> {
  Database database = Database();
  Widget titlecell(String text) =>  Center(
    child: Container(
      child: Text(text),
    ),
  );
  Widget cell(String text)=>Container(
    height: 40,
    child: Center(
      child: Text(text==null?"":text),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
        stream: database.getTimetable(classname),
        builder: (context, snapshot) {
          if(!snapshot.hasData)
            return Scaffold(body: Loading());
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo[900],
              elevation: 0.0,
              title: Text("TimeTable"),
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
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                              Container(
                                width: screenWidth(context,dividedBy: 1.1),
                                color: Colors.white,
                                child: Table(
                                  border: TableBorder.all(color: Colors.white,width: 2),
                                  children: [
                                    TableRow(
                                        decoration: BoxDecoration(color: whitecolor),
                                        children: [
                                          titlecell("H\\D"),
                                          titlecell("MON"),
                                          titlecell("TUE"),
                                          titlecell("WED"),
                                          titlecell("THUR"),
                                          titlecell("FRI"),
                                          titlecell("SAT"),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(color: whitecolor),
                                        children: [
                                          titlecell("1"),
                                          cell(snapshot.data['a0']),
                                          cell(snapshot.data['a1']),
                                          cell(snapshot.data['a2']),
                                          cell(snapshot.data['a3']),
                                          cell(snapshot.data['a4']),
                                          cell(snapshot.data['a5']),

                                        ]
                                    ),
                                    TableRow(
                                        decoration: BoxDecoration(color: whitecolor),
                                        children: [
                                          titlecell("2"),
                                          cell(snapshot.data['a6']),
                                          cell(snapshot.data['a7']),
                                          cell(snapshot.data['a8']),
                                          cell(snapshot.data['a9']),
                                          cell(snapshot.data['a10']),
                                          cell(snapshot.data['a11']),
                                        ]
                                    ),
                                    TableRow(
                                        decoration: BoxDecoration(color: whitecolor),
                                        children: [
                                          titlecell("3"),
                                          cell(snapshot.data['a12']),
                                          cell(snapshot.data['a13']),
                                          cell(snapshot.data['a14']),
                                          cell(snapshot.data['a15']),
                                          cell(snapshot.data['a16']),
                                          cell(snapshot.data['a17']),
                                        ]
                                    ),
                                    TableRow(
                                        decoration: BoxDecoration(color: whitecolor),
                                        children: [
                                          titlecell("4"),
                                          cell(snapshot.data['a18']),
                                          cell(snapshot.data['a19']),
                                          cell(snapshot.data['a20']),
                                          cell(snapshot.data['a21']),
                                          cell(snapshot.data['a22']),
                                          cell(snapshot.data['a23']),
                                        ]
                                    ),
                                    TableRow(
                                        decoration: BoxDecoration(color: whitecolor),
                                        children: [
                                          titlecell("5"),
                                          cell(snapshot.data['a24']),
                                          cell(snapshot.data['a25']),
                                          cell(snapshot.data['a26']),
                                          cell(snapshot.data['a27']),
                                          cell(snapshot.data['a28']),
                                          cell(snapshot.data['a29']),
                                        ]
                                    ),
                                    TableRow(
                                        decoration: BoxDecoration(color: whitecolor),
                                        children: [
                                          titlecell("6"),
                                          cell(snapshot.data['a30']),
                                          cell(snapshot.data['a31']),
                                          cell(snapshot.data['a32']),
                                          cell(snapshot.data['a33']),
                                          cell(snapshot.data['a34']),
                                          cell(snapshot.data['a35']),
                                        ]
                                    ),
                                    TableRow(
                                        decoration: BoxDecoration(color: whitecolor),
                                        children: [
                                          titlecell("7"),
                                          cell(snapshot.data['a36']),
                                          cell(snapshot.data['a37']),
                                          cell(snapshot.data['a38']),
                                          cell(snapshot.data['a39']),
                                          cell(snapshot.data['a40']),
                                          cell(snapshot.data['a41']),
                                        ]
                                    ),
                                    TableRow(
                                        decoration: BoxDecoration(color: whitecolor),
                                        children: [
                                          titlecell("8"),
                                          cell(snapshot.data['a42']),
                                          cell(snapshot.data['a43']),
                                          cell(snapshot.data['a44']),
                                          cell(snapshot.data['a45']),
                                          cell(snapshot.data['a46']),
                                          cell(snapshot.data['a47']),
                                        ]
                                    ),
                                  ],
                                ),
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
        }
    );
  }
}
