import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

showAlertDialog(BuildContext context, String message) {
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

class _SettingsState extends State<Settings> {
  bool changePassword = false;
  String oldP = "", newP = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        backgroundColor: bluecolor,
        title: Text('Settings'),
      ),
      body: Container(
        padding: EdgeInsets.all(37),
        child: Column(
          children: [
            Divider(
              thickness: 2,
            ),
            FlatButton(
                onPressed: () {
                  setState(() {
                    changePassword = !changePassword;
                  });
                },
                child: Text('Change Password')),
            Divider(
              thickness: 2,
            ),
            changePassword
                ? Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            oldP = value;
                          });
                        },
                        decoration: InputDecoration(hintText: 'Old Password'),
                        obscureText: true,
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            newP = value;
                          });
                        },
                        decoration: InputDecoration(hintText: 'New Password',),
                        obscureText: true,
                      ),
                      Container(
                        constraints:
                            BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                        margin: EdgeInsets.all(10),
                        child: RaisedButton(
                          onPressed: () async {
                            if (oldP != "" && newP != "") {
                              bool wrongPassword = await Database()
                                  .checkPassword(username, oldP);
                              if (!wrongPassword) {
                                Database().updatePassword(username, newP);
                                showAlertDialog(context, "Password changed successfully.");
                              } else {
                                showAlertDialog(context, "Could not change password.\nKindly check the old password you entered.");
                              }
                            }
                          },
                          color: bluecolor,
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Update Password',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
