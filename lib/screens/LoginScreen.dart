import 'package:eschool360/services/auth.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/services/helper.dart';
import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../wrapper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool show = false;
  String password = "";
  Auth auth = Auth();
  bool loggedIn = false;
  TextEditingController textEditingController,
      usernameController,
      passwordController;
  Database database = Database();
  Widget schoolId() => Container(
        height: 50,
        width: 350,
        decoration: BoxDecoration(color: Colors.white),
        child: TextField(
          onChanged: (value) {
            schoolID = value;
            HelperFunc.saveSchoolId(schoolID);
          },
          controller: textEditingController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'School ID',
              prefixIcon: Icon(
                Icons.school,
                color: Colors.blue[900],
              )),
          keyboardType: TextInputType.text,
        ),
      );
  Widget userpass() => Column(
        children: <Widget>[
          Container(
            height: 50,
            width: 350,
            decoration: BoxDecoration(color: Colors.white),
            child: TextField(
              controller: usernameController,
              onChanged: (value) {
                setState(() {
                  username = value;
                  HelperFunc.saveUsername(username);
                });
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'User Name',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.blue[900],
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 350,
            decoration: BoxDecoration(color: Colors.white),
            child: TextField(
              controller: passwordController,
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Password',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.blue[900],
                  )),
              obscureText: true,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          button("LOGIN")
        ],
      );
  Widget button(String word) => Container(
        height: 50,
        width: 350,
        decoration: BoxDecoration(borderRadius: buttonRadius),
        child: FlatButton(
          color: Colors.orange[900],
          textColor: Colors.white,
          disabledColor: Colors.orange,
          disabledTextColor: Colors.orangeAccent,
          padding: EdgeInsets.all(8.0),
          splashColor: Colors.deepOrange,
          onPressed: () async {
            setState(() {
              if (schoolID != "") show = true;
            });
            if (word == 'LOGIN') {
              loggedIn = !loggedIn;
              if (!await database.checkSchool(schoolID)) {
                //textEditingController.text = "";
                print("login");
                print(username);
                print(!await database.checkUsername(username));
                if (!await database.checkPassword(username, password)) {
                  HelperFunc.saveUserloggedIn(true);
                  isLoggedIn = true;
                  HelperFunc.saveSchoolId(schoolID);
                  HelperFunc.saveUsername(username);
                  if (!await database.checkStudent(username, 'student')) {
                    type = 'student';
                    HelperFunc.saveType('student');
                    //classname = database.getClass();
                  } else if (!await database.checkStudent(
                      username, 'teacher')) {
                    type = 'teacher';
                    HelperFunc.saveType('teacher');
                  } else if (!await database.checkStudent(
                      username, 'counsellor')) {
                    type = 'counsellor';
                    HelperFunc.saveType('counsellor');
                  } else if (!await database.checkStudent(
                      username, 'librarian')) {
                    type = 'librarian';
                    HelperFunc.saveType('librarian');
                  } else if (!await database.checkStudent(
                      username, 'alumni')) {
                    type = 'alumni';
                    HelperFunc.saveType('alumni');
                  } else if (!await database.checkStudent(
                      username, 'hostelManager')) {
                    type = 'hostelManager';
                    HelperFunc.saveType('hostelManager');
                  } else if (!await database.checkStudent(
                      username, 'admin')) {
                    type = 'admin';
                    HelperFunc.saveType('admin');
                  } else {
                    type = 'principal';
                    HelperFunc.saveType('principal');
                  }
                }
                if (isLoggedIn == null || !isLoggedIn) {
                  showAlertDialog(context);
                }
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Wrapper()));
              }
              loggedIn = !loggedIn;
            }
            if (word == 'CONTINUE') {
              print(await database.checkSchool(schoolID));
              if (await database.checkSchool(schoolID)) {
                showAlertDialog(context);
                setState(() {
                  show = false;
                });
              } else {
                setState(() {
                  show = true;
                });
              }
            }
            //TODO
          },
          child: Text(
            word,
            style: TextStyle(fontSize: 15.0),
          ),
        ),
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: loggedIn,
        child: SingleChildScrollView(
          child: Center(
            child: Stack(
              children: <Widget>[
                Container(
                  height: screenHeight(context),
                  width: double.infinity,
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: 100,),
                    Center(
                      child: Container(
                        //color: Colors.white,
                        child: Image.asset(
                          "assets/images/logo.jpg",
                          fit: BoxFit.cover,
                          //width: double.infinity,
                          height: 200,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: screenHeight(context, dividedBy: 2.1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: bluecolor,
                      borderRadius: borderRadius,
                    ),
                    height: screenHeight(context, dividedBy: 1.3),
                    width: screenWidth(context),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Login to your Account!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25, color: whitecolor),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          schoolId(),
                          SizedBox(
                            height: 20,
                          ),
                          if (!show) button("CONTINUE") else userpass(),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("No such credentials"),
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
