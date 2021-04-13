import 'package:flutter/material.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../utils/utils.dart';
import '../utils/api.dart';
import '../utils/config.dart';

class SignupActivity extends StatefulWidget {
  SignupActivity();

  @override
  State<StatefulWidget> createState() {
    return new SignupActivityState();
  }
}

class SignupActivityState extends State<SignupActivity> {
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController email = new TextEditingController();

  bool loading = false;
  SignupActivityState();

  String erroText = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Sign Up",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 4.0,
      ),
      body: ModalProgressHUD(
        child: new Container(
          margin: new EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.1,
              25,
              MediaQuery.of(context).size.width * 0.1,
              0),
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new TextField(
                  controller: username,
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.account_circle),
                  ),
                  onSubmitted: (s) {
                    // login();
                  },
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new TextField(
                  controller: password,
                  obscureText: true,
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  onSubmitted: (s) {
                    // login();
                  },
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new TextField(
                  controller: email,
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  onSubmitted: (s) {
                    // login();
                  },
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: new MaterialButton(
                  color: Colors.blue,
                  height: 40,
                  child: new Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (username.text.length == 0) {
                      setState(() {
                        erroText = "Username Required";
                        loading = false;
                      });
                      return;
                    } else {
                      setState(() {
                        erroText = "";
                      });
                    }
                    if (password.text.length == 0) {
                      setState(() {
                        erroText = "Password Required";
                        loading = false;
                      });
                      return;
                    } else {
                      setState(() {
                        erroText = "";
                      });
                    }
                    if (email.text.length == 0) {
                      setState(() {
                        erroText = "Email Required";
                        loading = false;
                      });
                      return;
                    } else {
                      setState(() {
                        erroText = "";
                      });
                    }
                    setState(() {
                      loading = true;
                    });
                    Future<bool> load = add(
                      API.ADMIN,
                      Map.from({
                        'username': username.text,
                        'password': password.text,
                        'email': email.text,
                      }),
                    );
                    load.then((onValue) {
                      setState(() {
                        loading = false;
                      });
                      if (onValue != null) {
                        Navigator.pop(context, "");
                      } else {
                        oneButtonDialog(
                            context, "Network error", "Please try again", true);
                      }
                    });
                  },
                ),
              ),
              new Container(
                  margin: new EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: new Center(
                    child: new Text(
                      erroText.length > 0 ? erroText : "",
                      style: new TextStyle(color: Colors.red),
                    ),
                  )),
            ],
          ),
        ),
        inAsyncCall: loading,
      ),
    );
  }
}
