import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool360/loading.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/styles/widgets.dart';
import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

Map<String, dynamic> info = {
  'middlename': '',
  'lastname': '',
  'mothername': '',
  'fathername': '',
  'fathermobile': "",
  'mothermobile': "",
  'mobile': "",
  'dob': "",
  'gender': "",
  'height': "",
  'weight': "",
  'adress': ""
};

showAlertDialog(BuildContext context) {
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
    content: Text("Information Updated Successfully"),
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

class _InformationState extends State<Information> {
  Database database = Database();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bluecolor,
        elevation: 0.0,
        title: Text("Information"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: database.getDocument(),
          builder: (context, snapshot) {
            Widget textfield(String lable, String hinttext, String field) =>
                TextField(
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      info[field] = value.toString();
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: hinttext==null?"-":hinttext.toString(),
                    hintStyle: bigbluetext,
                    alignLabelWithHint: true,
                  ),
                );

            //var snapshots = snapshot.data['information'];
            if (!snapshot.hasData) {
              return Loading();
            }
            return Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: screenHeight(context) * 2.6,
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
                    height: screenHeight(context) * 2.1,
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: whitecolor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Container(
                        height: 200,
                        width: screenWidth(context, dividedBy: 1.5),
                        decoration: BoxDecoration(
                            borderRadius: containerRadius, color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 30, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "First Name",
                                    style: blacktext,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    snapshot.data.documents[0]['name'],
                                    style: bigbluetext,
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Last Name",
                                    style: blacktext,
                                  ),
                                  textfield(
                                      'Last Name',
                                      snapshot.data.documents[0]['lastname'],
                                      'lastname'),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "Middle Name",
                                    style: blacktext,
                                  ),
                                  textfield(
                                      'Middle Name',
                                      snapshot.data.documents[0]['middlename'],
                                      'middlename'),
                                  Divider(thickness: 2,),

                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "Father's Name",
                                    style: blacktext,
                                  ),
                                  textfield(
                                      '',
                                      snapshot.data.documents[0]['fathername'],
                                      'fathername'),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "Mother's Name",
                                    style: blacktext,
                                  ),
                                  textfield(
                                      '',
                                      snapshot.data.documents[0]['mothername'],
                                      'mothername'),
                                  Divider(thickness: 2,),

                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "Father's Mobile No.",
                                    style: blacktext,
                                  ),
                                  textfield(
                                      '',
                                      snapshot.data.documents[0]
                                          ['fathermobile'],
                                      'fathermobile'),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "Mother's Mobile No.",
                                    style: blacktext,
                                  ),
                                  textfield(
                                      '',
                                      snapshot.data.documents[0]
                                          ['mothermobile'],
                                      'mothermobile'),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "Your Mobile No.",
                                    style: blacktext,
                                  ),
                                  textfield(
                                      '',
                                      snapshot.data.documents[0]['mobile'].toString(),
                                      'mobile'),
                                  Divider(thickness: 2,),

                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "Date of Birth",
                                    style: blacktext,
                                  ),
                                  textfield('',
                                      snapshot.data.documents[0]['dob'], 'dob'),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "Gender",
                                    style: blacktext,
                                  ),
                                  textfield(
                                      '',
                                      snapshot.data.documents[0]['gender'],
                                      'gender'),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "Height (cm)",
                                    style: blacktext,
                                  ),
                                  textfield(
                                      '',
                                      snapshot.data.documents[0]['height'],
                                      'height'),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "Weight (kg)",
                                    style: blacktext,
                                  ),
                                  textfield(
                                      '',
                                      snapshot.data.documents[0]['weight'],
                                      'weight'),
                                  Divider(thickness: 2,),

                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "Address",
                                    style: blacktext,
                                  ),
                                  textfield(
                                      '',
                                      snapshot.data.documents[0]['adress'],
                                      'adress'),
                                  SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                              Center(
                                child: RaisedButton(
                                    onPressed: () {
                                      Map<String, dynamic> info2 = {
                                        'middlename': info['middlename'] == ""
                                            ? snapshot.data.documents[0]
                                                ['middlename']
                                            : info['middlename'],
                                        'lastname': info['lastname'] == ""
                                            ? snapshot.data.documents[0]
                                                ['lastname']
                                            : info['lastname'],
                                        'fathername': info['fathername'] == ""
                                            ? snapshot.data.documents[0]
                                                ['fathername']
                                            : info['fathername'],
                                        'mothername': info['mothername'] == ""
                                            ? snapshot.data.documents[0]
                                                ['mothername']
                                            : info['mothername'],
                                        'fathermobile':
                                            info['fathermobile'] == ""
                                                ? snapshot.data.documents[0]
                                                    ['fathermobile']
                                                : info['fathermobile'],
                                        'mothermobile':
                                            info['mothermobile'] == ""
                                                ? snapshot.data.documents[0]
                                                    ['mothermobile']
                                                : info['mothermobile'],
                                        'mobile': info['mobile'] == ""
                                            ? snapshot.data.documents[0]
                                                ['mobile']
                                            : info['mobile'],
                                        'dob': info['dob'] == ""
                                            ? snapshot.data.documents[0]['dob']
                                            : info['dob'],
                                        'gender': info['gender'] == ""
                                            ? snapshot.data.documents[0]
                                                ['gender']
                                            : info['gender'],
                                        'height': info['height'] == ""
                                            ? snapshot.data.documents[0]
                                                ['height']
                                            : info['height'],
                                        'weight': info['weight'] == ""
                                            ? snapshot.data.documents[0]
                                                ['weight']
                                            : info['weight'],
                                        'adress': info['adress'] == ""
                                            ? snapshot.data.documents[0]
                                                ['adress']
                                            : info['adress'],
                                      };
                                      Database().putInformation(info2);
                                      showAlertDialog(context);
                                    },
                                    child: Text(
                                      'Save Information',
                                      style: TextStyle(color: whitecolor),
                                    ),
                                    color: bluecolor,
                                    elevation: 3.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
