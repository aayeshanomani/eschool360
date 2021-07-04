import 'package:eschool360/screens/Information.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';

class ManageTransport extends StatefulWidget {
  const ManageTransport({Key key}) : super(key: key);

  @override
  _ManageTransportState createState() => _ManageTransportState();
}

class _ManageTransportState extends State<ManageTransport> {
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
        title: Text("Manage Transportation"),
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
                  "Bus Number",
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
                  hintText: "Bus no.",
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
                  "Route",
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
                  hintText: "Route for transportation",
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
                      'Update Routes',
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
