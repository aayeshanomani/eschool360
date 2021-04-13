import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool360/Principal/Notice.dart';
import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoticeBoard extends StatefulWidget {
  @override
  _NoticeBoardState createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[putnotice(), Notice()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        backgroundColor: bluecolor,
        elevation: 5,
        title: Text(
          'Notice Board',
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar( //to show two screens and navigate throught the bottom bar
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.penNib),
            title: Text('Notice'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.chalkboard),
            title: Text('Board'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: bluecolor,
        onTap: _onItemTapped,
      ),
    );
  }
}

class putnotice extends StatefulWidget {
  @override
  _putnoticeState createState() => _putnoticeState();
}

class _putnoticeState extends State<putnotice> {
  TextEditingController notice = TextEditingController();
  TextEditingController subject = TextEditingController();

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
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
    return Container(
      height: screenHeight(context),
      width: screenWidth(context),
      color: whitecolor,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            width: screenWidth(context, dividedBy: 1.1),
            height: 50,
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: subject,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Subject"),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            width: screenWidth(context, dividedBy: 1.1),
            height: 200,
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: notice,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Write your Notice here"),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: screenWidth(context, dividedBy: 2),
            decoration:
                BoxDecoration(color: bluecolor, borderRadius: containerRadius),
            child: FlatButton(
                onPressed: () {
                  Firestore.instance
                      .collection(schoolID)
                      .document('notice')
                      .collection('notice')
                      .document(subject.text)
                      .setData(
                          {"subject": subject.text, "notice": notice.text}); //setting data in the notice collection
                  showAlertDialog(
                      context, "Notice successfully pined in NoticeBoard");
                  subject.text = "";
                  notice.text = "";
                },
                child: Text(
                  "Send",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
