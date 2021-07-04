import 'package:eschool360/screens/Information.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';

class VisitorLog extends StatefulWidget {
  const VisitorLog({Key key}) : super(key: key);

  @override
  _VisitorLogState createState() => _VisitorLogState();
}

class _VisitorLogState extends State<VisitorLog> {
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
        title: Text("Log Visitor"),
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
                  "Name of Visitor",
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
                  hintText: "Name of the Vistor",
                  hintStyle: bigbluetext,
                  alignLabelWithHint: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                child: Text(
                  "Date of Visit",
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
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  thickness: 8,
                  color: Color(0xff878787),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                child: Text(
                  "Reason for Visit",
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
                  hintText: "Reason for Visit",
                  hintStyle: bigbluetext,
                  alignLabelWithHint: true,
                ),
              ),
              
              Padding(
                padding: EdgeInsets.all(37),
                child: RaisedButton(
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    child: Text(
                      'Log Visitor in',
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
