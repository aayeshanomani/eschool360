import 'package:eschool360/screens/Information.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key key}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  DateTime pickedDate;
  TimeOfDay time;

  @override
  void initState() {
    // TODO: implement initState
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
    super.initState();
  }

  String name = "";
  String c = "";
  String section = "";
  String rollno = "";
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F8DE),
      appBar: AppBar(
        title: Text("Add Student"),
        backgroundColor: Color(0xff51355A),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                child: Text(
                  "Name of Student",
                  style: TextStyle(
                      color: bluecolor,
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0),
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Name of the Student",
                  hintStyle: bigbluetext,
                  alignLabelWithHint: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                child: Text(
                  "Date of Admission",
                  style: TextStyle(
                      color: bluecolor,
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0),
                ),
              ),
              Container(
                color: Color(0xffFFffff),
                child: ListTile(
                  title: Text(
                      'Date: ${pickedDate.year} - ${pickedDate.month} - ${pickedDate.day}'),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: _pickDate,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                child: Text(
                  "Class",
                  style: TextStyle(
                      color: bluecolor,
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0),
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    c = value;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Class of the Student",
                  hintStyle: bigbluetext,
                  alignLabelWithHint: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                child: Text(
                  "Section",
                  style: TextStyle(
                      color: bluecolor,
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0),
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    section = value;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Section of the Student",
                  hintStyle: bigbluetext,
                  alignLabelWithHint: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                child: Text(
                  "Roll No.",
                  style: TextStyle(
                      color: bluecolor,
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0),
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    rollno = value;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Roll no. of the Student",
                  hintStyle: bigbluetext,
                  alignLabelWithHint: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  thickness: 8,
                  color: Color(0xff878787),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                child: Text(
                  "Set Username",
                  style: TextStyle(
                      color: bluecolor,
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0),
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Username of the Student",
                  hintStyle: bigbluetext,
                  alignLabelWithHint: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                child: Text(
                  "Set Password",
                  style: TextStyle(
                      color: bluecolor,
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0),
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Password for the Student",
                  hintStyle: bigbluetext,
                  alignLabelWithHint: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(37),
                child: RaisedButton(
                    onPressed: () {
                      Map<String, dynamic> data = {
                        "type": "student",
                        "name": name,
                        "rollno": rollno,
                        "class": c,
                        "section": section,
                        "username": username,
                        "password": password
                      };
                      Database().addStudent(username, data);
                      showAlertDialog(context);
                    },
                    child: Text(
                      'Add the student',
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
    );
  }

  void _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDate: pickedDate,
    );
    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    }
  }

  void _pickTime() async {
    TimeOfDay pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null) {
      setState(() {
        time = pickedTime;
      });
    }
  }
}
