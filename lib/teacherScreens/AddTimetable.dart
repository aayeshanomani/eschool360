import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool360/loading.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/styles/widgets.dart';
import 'package:flutter/material.dart';
class AddTimetable extends StatefulWidget {
  @override
  _AddTimetableState createState() => _AddTimetableState();
}

class _AddTimetableState extends State<AddTimetable> {
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
  List<TextEditingController> c =
  List.generate(74, (i) => TextEditingController());
  Database database = Database();
  var A = List();
  Widget titlecell(String text) =>  Center(
    child: Container(
      child: Text(text),
    ),
  );
  Widget cell(TextEditingController text, String hinttext)=>Container(
    height: 40,
    child: Center(
      child: TextField(
        decoration: InputDecoration(hintText:hinttext,hintStyle: TextStyle(color: Colors.black) ),
        controller: text,
      ),
    ),
  );
  String _value = "1";
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
      stream: database.getTimetable(_value),
      builder: (context, snapshot) {
       if(!snapshot.hasData)
         return Loading();
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
                          if(_value !="")
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
                                    cell(c[0],snapshot.data['a0']),
                                    cell(c[1],snapshot.data['a1']),
                                    cell(c[2],snapshot.data['a2']),
                                    cell(c[3],snapshot.data['a3']),
                                    cell(c[4],snapshot.data['a4']),
                                    cell(c[5],snapshot.data['a5']),

                                  ]
                                ),
                                TableRow(
                                    decoration: BoxDecoration(color: whitecolor),
                                    children: [
                                      titlecell("2"),
                                      cell(c[6],snapshot.data['a6']),
                                    cell(c[7],snapshot.data['a7']),
                                    cell(c[8],snapshot.data['a8']),
                                    cell(c[9],snapshot.data['a9']),
                                    cell(c[10],snapshot.data['a10']),
                                    cell(c[11],snapshot.data['a11']),
                                    ]
                                ),
                                TableRow(
                                    decoration: BoxDecoration(color: whitecolor),
                                    children: [
                                      titlecell("3"),
                                      cell(c[12],snapshot.data['a12']),
                                    cell(c[13],snapshot.data['a13']),
                                    cell(c[14],snapshot.data['a14']),
                                    cell(c[15],snapshot.data['a15']),
                                    cell(c[16],snapshot.data['a16']),
                                    cell(c[17],snapshot.data['a17']),
                                    ]
                                ),
                                TableRow(
                                    decoration: BoxDecoration(color: whitecolor),
                                    children: [
                                      titlecell("4"),
                                      cell(c[18],snapshot.data['a18']),
                                    cell(c[19],snapshot.data['a19']),
                                    cell(c[20],snapshot.data['a20']),
                                    cell(c[21],snapshot.data['a21']),
                                    cell(c[22],snapshot.data['a22']),
                                    cell(c[23],snapshot.data['a23']),
                                    ]
                                ),
                                TableRow(
                                    decoration: BoxDecoration(color: whitecolor),
                                    children: [
                                      titlecell("5"),
                                      cell(c[24],snapshot.data['a24']),
                                      cell(c[25],snapshot.data['a25']),
                                      cell(c[26],snapshot.data['a26']),
                                      cell(c[27],snapshot.data['a27']),
                                      cell(c[28],snapshot.data['a28']),
                                      cell(c[29],snapshot.data['a29']),
                                    ]
                                ),
                                TableRow(
                                    decoration: BoxDecoration(color: whitecolor),
                                    children: [
                                      titlecell("6"),
                                      cell(c[30],snapshot.data['a30']),
                                      cell(c[31],snapshot.data['a31']),
                                      cell(c[32],snapshot.data['a32']),
                                      cell(c[33],snapshot.data['a33']),
                                      cell(c[34],snapshot.data['a34']),
                                      cell(c[35],snapshot.data['a35']),
                                    ]
                                ),
                                TableRow(
                                    decoration: BoxDecoration(color: whitecolor),
                                    children: [
                                      titlecell("7"),
                                      cell(c[36],snapshot.data['a36']),
                                      cell(c[37],snapshot.data['a37']),
                                      cell(c[38],snapshot.data['a38']),
                                      cell(c[39],snapshot.data['a39']),
                                      cell(c[40],snapshot.data['a40']),
                                      cell(c[41],snapshot.data['a41']),
                                    ]
                                ),
                                TableRow(
                                    decoration: BoxDecoration(color: whitecolor),
                                    children: [
                                      titlecell("8"),
                                      cell(c[42],snapshot.data['a42']),
                                      cell(c[43],snapshot.data['a43']),
                                      cell(c[44],snapshot.data['a44']),
                                      cell(c[45],snapshot.data['a45']),
                                      cell(c[46],snapshot.data['a46']),
                                      cell(c[47],snapshot.data['a47']),
                                    ]
                                ),
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
                                  for(var v=0;v<48;v++)
                                    A.add('a'+v.toString());
                                  print(A);
                                  for(var j = 0;j<48;j++)
                                 database.addTimetable(A[j], c[j].text!=""?c[j].text:snapshot.data[A[j]],_value);
                                  showAlertDialog(context, "TimeTable Updated successfully");
                                },
                                child: Text(
                                  "Update Timetable",
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
      }
    );
  }
}
