import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

// import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

import './dashboard.dart';
import '../utils/models.dart';
import '../utils/api.dart';
import '../utils/config.dart';
import '../utils/utils.dart';
import 'hostel.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginState();
  }
}

class LoginState extends State<Login> {
  FocusNode textSecondFocusNode = new FocusNode();

  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  bool loggedIn = true;
  bool wrongCreds = false;

  String onesignalUserId = "";

  @override
  void initState() {
    super.initState();

    // OneSignal.shared.getPermissionSubscriptionState().then((status) {
    //   if (status.subscriptionStatus.subscribed) {
    //     onesignalUserId = status.subscriptionStatus.userId;
    //   }
    // });

    if (Platform.isAndroid) {
      headers["appversion"] = APPVERSION.ANDROID;
      if (kReleaseMode) {
        headers["apikey"] = APIKEY.ANDROID_LIVE;
      } else {
        headers["apikey"] = APIKEY.ANDROID_TEST;
      }
    } else {
      headers["appversion"] = APPVERSION.IOS;
      if (kReleaseMode) {
        headers["apikey"] = APIKEY.IOS_LIVE;
      } else {
        headers["apikey"] = APIKEY.IOS_TEST;
      }
    }
    Future<bool> prefInit = initSharedPreference();
    prefInit.then((onValue) {
      if (onValue) {
        if (prefs.getString("username") != null &&
            prefs.getString("username").length > 0) {
          adminName = prefs.getString("username");
          adminEmailID = prefs.getString("email");
          hostelID = prefs.getString("hostelID");
          admin = prefs.getString("admin");
          adminID = prefs.getString("adminID");
          hostelName = prefs.getString("hostelName");
          amenities = prefs.getString("amenities").split(",");
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) => new DashBoardActivity()));
        } else {
          setState(() {
            loggedIn = false;
          });
        }
      } else {
        setState(() {
          loggedIn = false;
        });
      }
    });
  }

  void login() {
    checkInternet().then((internet) {
      if (internet == null || !internet) {
        oneButtonDialog(context, "No Internet connection", "", true);
        setState(() {
          loggedIn = false;
        });
      } else {
        setState(() {
          loggedIn = true;
        });
        Future<Admins> adminResponse = getAdmins(Map.from({
          'username': username.text,
          'password': password.text,
          'oneSignalID': onesignalUserId,
        }));
        adminResponse.then((response) {
          if (response == null ||
              response.meta == null ||
              response.meta.status != "200") {
            setState(() {
              loggedIn = false;
            });
          } else {
            if (response.admins.length == 0) {
              setState(() {
                loggedIn = false;
                wrongCreds = true;
              });
            } else {
              prefs.setString('username', response.admins[0].username);
              prefs.setString('email', response.admins[0].email);
              prefs.setString('hostelIDs', response.admins[0].hostels);
              prefs.setString('admin', response.admins[0].admin);
              prefs.setString('adminID', response.admins[0].id);
              adminName = response.admins[0].username;
              adminEmailID = response.admins[0].email;
              admin = response.admins[0].admin;
              adminID = response.admins[0].id;
              Future<Hostels> hostelResponse = getHostels(
                  Map.from({'id': response.admins[0].hostels, 'status': '1'}));
              hostelResponse.then((response) {
                setState(() {
                  if (response.hostels.length > 0) {
                    prefs.setString('hostelID', response.hostels[0].id);
                    prefs.setString('hostelName', response.hostels[0].name);
                    prefs.setString('amenities', response.hostels[0].amenities);
                    hostelID = response.hostels[0].id;
                    hostelName = response.hostels[0].name;
                    amenities = response.hostels[0].amenities.split(",");

                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new DashBoardActivity()));
                  } else {
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new HostelActivity(null, true, true)));
                  }
                });
              });
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ModalProgressHUD(
        child: new Container(
          margin: new EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.1,
              100,
              MediaQuery.of(context).size.width * 0.1,
              0),
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              new SizedBox(
                width: 100,
                height: 100,
                child: new Image.asset('assets/images/hotels.jpg'),
              ),
              new Center(
                child: new Container(
                  margin: EdgeInsets.only(top: 10),
                  child: new Text("Eschool360 Hostel"),
                ),
              ),
              new Container(
                height: 50,
              ),
              new TextField(
                controller: username,
                autocorrect: false,
                autofocus: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Username',
                  prefixIcon: Icon(Icons.account_circle),
                ),
                onSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(textSecondFocusNode);
                },
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new TextField(
                  controller: password,
                  focusNode: textSecondFocusNode,
                  obscureText: true,
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  onSubmitted: (s) {
                    login();
                  },
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: new MaterialButton(
                  color: Colors.blue,
                  height: 40,
                  child: new Text(
                    "Log In",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    login();
                  },
                ),
              ),
              new Container(
                child: new MaterialButton(
                  height: 40,
                  child: new Text(
                    "Don't have an account yet?\nSign Up.",
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new SignupActivity()));
                  },
                ),
              ),
              new Container(
                  margin: new EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: new Center(
                    child: new Text(
                      wrongCreds ? "Incorrect Username/Password" : "",
                      style: new TextStyle(color: Colors.red),
                    ),
                  )),
            ],
          ),
        ),
        inAsyncCall: loggedIn,
      ),
    );
  }
}
