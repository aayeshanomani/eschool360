import 'package:eschool360/hostel/screens/hostel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

import './screens/login.dart';
import './utils/config.dart';
import './utils/utils.dart';
import './screens/dashboard.dart';

void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  WidgetsFlutterBinding.ensureInitialized();
  // TestWidgetsFlutterBinding.ensureInitialized();
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "CloudPG",
    home: new MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hostel Eschool 360',
      home: MyHomePage(title: 'Hostel Eschool 360'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

// Map<OSiOSSettings, dynamic>(OSiOSSettings.autoPrompt: true, OSiOSSettings.inAppLaunchUrl: true)
    // OneSignal.shared.init(ONESIGNAL_APP_ID);
    // OneSignal.shared
    //     .setInFocusDisplayType(OSNotificationDisplayType.notification);

    // OneSignal.shared.promptUserForPushNotificationPermission();
    // OneSignal.shared
    //     .promptUserForPushNotificationPermission(fallbackToSettings: true);

    Future.delayed(Duration(seconds: 3), () {
      loginCheck();
    });
  }

  void loginCheck() {
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
          amenities = prefs.getString("amenities") != null
              ? prefs.getString("amenities").split(",")
              : new List();
          if (prefs.getString("hostelIDs") != null &&
              prefs.getString("hostelIDs").length > 0) {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) => new DashBoardActivity()));
          } else {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new HostelActivity(null, true, true)));
          }
        } else {
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) => new Login()));
        }
      } else {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => new Login()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Container(
        color: HexColor("#5099CF"),
        child: new Center(
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              new SizedBox(
                width: 200,
                height: 200,
                child: new Image.asset('assets/images/hotels.jpg'),
              ),
              // new Container(
              //   height: 10,
              // ),
              // new Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     new Text(
              //       "Cloud PG",
              //       style: new TextStyle(
              //         fontSize: 20,
              //         color: Colors.white,
              //         fontWeight: FontWeight.normal,
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
