import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:intl/intl.dart';
import "dart:math";

DateFormat dateFormat = new DateFormat('yyyy-MM-dd');
DateFormat headingDateFormat = new DateFormat("EEE, MMM d, ''yy");
DateFormat timeFormat = new DateFormat("h:mm a");

List<String> colors = [
  "#D7BDE2",
  "#F5CBA7",
  "#F9E79F",
  "#A2D9CE",
  "#AED6F1",
  "#F5B7B1",
  "#ABB2B9"
];

final random = new Random();

SharedPreferences prefs;
Future<bool> initSharedPreference() async {
  prefs = await SharedPreferences.getInstance();
  if (prefs != null) {
    return true;
  }
  return false;
}

void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  }
}

void makePhone(String phone) async {
  var url = 'tel:' + phone;
  if (await canLaunch(url)) {
    await launch(url);
  }
}

void sendMail(String mail, String subject, String body) async {
  var url = 'mailto:' +
      mail +
      "?subject=" +
      subject +
      "&body=" +
      Uri.encodeComponent(body);
  print(url);
  if (await canLaunch(url)) {
    await launch(url);
  }
}

Future<bool> checkInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
}

Widget showProgress(String title) {
  return AlertDialog(
    title: new Container(
      padding: EdgeInsets.all(10),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Text(
              title,
            ),
          ),
          new Container(
            padding: new EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: new CircularProgressIndicator(),
          )
        ],
      ),
    ),
  );
}

Widget popDialog(BuildContext context, String title, bool pop) {
  return AlertDialog(
    title: new Text(title),
    actions: <Widget>[
      new FlatButton(
        child: new Text("ok"),
        onPressed: () {
          if (pop) {
            Navigator.of(context).pop();
          }
        },
      ),
    ],
  );
}

Icon getAmenityIcon(String id) {
  IconData iconData;
  Color color = Colors.black;
  switch (id) {
    case "1": // wifi
      iconData = Icons.wifi;
      break;
    case "2": // bathroom
      iconData = Icons.hot_tub;
      break;
    case "3": // tv
      iconData = Icons.tv;
      break;
    case "4": // ac
      iconData = Icons.ac_unit;
      break;
    case "5": // power backup
      iconData = Icons.power;
      break;
    case "6": // washing mahcine
      iconData = Icons.local_laundry_service;
      break;
    case "7": // geyser
      color = Colors.red;
      iconData = Icons.whatshot;
      break;
    case "8": // laundry
      iconData = Icons.local_laundry_service;
      break;
    default:
      iconData = Icons.plus_one;
  }

  return new Icon(
    iconData,
    color: color,
    size: 15,
  );
}

String getAmenityName(String id) {
  switch (id) {
    case "1": // wifi
      return "Wifi";
      break;
    case "2": // bathroom
      return "Bathroom";
      break;
    case "3": // tv
      return "TV";
      break;
    case "4": // ac
      return "AC";
      break;
    case "5": // power backup
      return "Power\nBackup";
      break;
    case "6": // washing mahcine
      return "Washing\nMachine";
      break;
    case "7": // geyser
      return "Geyser";
      break;
    case "8": // laundry
      return "Laundry";
      break;
    default:
      return "";
  }
}

List<Widget> getAmenitiesWidgets(String amenities) {
  List<Widget> widgets = new List();
  amenities.split(",").forEach((amenity) {
    String name = getAmenityName(amenity);
    if (name.length > 0) {
      widgets.add(new Column(
        children: <Widget>[
          getAmenityIcon(amenity),
          new Text(
            name,
            style: TextStyle(fontSize: 10),
          )
        ],
      ));
      widgets.add(new Container(
        width: 15,
      ));
    }
  });

  return widgets;
}

Future<bool> twoButtonDialog(
    BuildContext context, String title, String content) async {
  bool returned = false;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(title),
        content: new Text(content),
        actions: <Widget>[
          new FlatButton(
            child: new Text("No"),
            onPressed: () {
              Navigator.of(context).pop();
              returned = false;
            },
          ),
          new FlatButton(
            child: new Text(
              "Yes",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              returned = true;
            },
          ),
        ],
      );
    },
  );
  return returned;
}

void oneButtonDialog(
    BuildContext context, String title, String content, bool dismiss) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(title),
        content: content != "" ? new Text(content) : null,
        actions: <Widget>[
          new FlatButton(
            child: new Text("ok"),
            onPressed: () {
              if (dismiss) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

String getBillType(String id) {
  // if you add here, add in config too
  switch (id) {
    case "1":
      return "Cable Bill";
      break;
    case "2":
      return "Water Bill";
      break;
    case "3":
      return "Electricity Bill";
      break;
    case "4":
      return "Food Expense";
      break;
    case "5":
      return "Internet Bill";
      break;
    case "6":
      return "Maintainance";
      break;
    case "7":
      return "Property Rent/Tax";
      break;
    case "8":
      return "Others";
      break;
    default:
      return "Others";
  }
  // if you add here, add in config too
}

IconData getBillIcon(String id) {
  // if you add here, add in config too
  switch (id) {
    case "1":
      return Icons.tv;
      break;
    case "2":
      return Icons.hot_tub;
      break;
    case "3":
      return Icons.flash_on;
      break;
    case "4":
      return Icons.local_dining;
      break;
    case "5":
      return Icons.wifi;
      break;
    case "6":
      return Icons.adjust;
      break;
    case "7":
      return Icons.local_parking;
      break;
    case "8":
      return Icons.receipt;
      break;
    default:
      return Icons.receipt;
  }
  // if you add here, add in config too
}

String getPaymentType(String id) {
  // if you add here, add in config too
  // if you change here, chnage in api too
  switch (id) {
    case "1":
      return "Credit Card";
      break;
    case "2":
      return "Debit Card";
      break;
    case "3":
      return "Net Banking";
      break;
    case "4":
      return "Google Pay";
      break;
    case "5":
      return "PhonePe";
      break;
    case "6":
      return "PayTM";
      break;
    case "7":
      return "Cash";
      break;
    case "8":
      return "Others";
      break;
    default:
      return "Others";
  }
  // if you add here, add in config too
  // if you change here, chnage in api too
}

String getIssueType(String id) {
  // if you add here, you have to change in tenant app too
  switch (id) {
    case "1":
      return "Internet";
      break;
    case "2":
      return "Food";
      break;
    case "3":
      return "Electrical";
      break;
    case "4":
      return "Plumbing";
      break;
    case "5":
      return "Pests";
      break;
    case "6":
      return "Cleaning";
      break;
    case "7":
      return "Bed";
      break;
    case "8":
      return "Room";
      break;

    case "9":
      return "Security";
      break;
    case "10":
      return "Theft";
      break;
    case "11":
      return "Parking";
      break;
    case "12":
      return "TV";
      break;
    case "13":
      return "Appliances";
      break;
    case "14":
      return "Others";
      break;
    default:
      return "Others";
  }
  // if you add here, you have to change in tenant app too
}

IconData getIssueIcon(String id) {
  // if you add here, you have to change in tenant app too
  switch (id) {
    case "1":
      return Icons.wifi;
      break;
    case "2":
      return Icons.local_dining;
      break;
    case "3":
      return Icons.flash_on;
      break;
    case "4":
      return Icons.build;
      break;
    case "5":
      return Icons.bug_report;
      break;
    case "6":
      return Icons.blur_on;
      break;
    case "7":
      return Icons.local_hotel;
      break;
    case "8":
      return Icons.home;
      break;

    case "9":
      return Icons.remove_red_eye;
      break;
    case "10":
      return Icons.remove_circle_outline;
      break;
    case "11":
      return Icons.local_parking;
      break;
    case "12":
      return Icons.tv;
      break;
    case "13":
      return Icons.category;
      break;
    case "14":
      return Icons.report_problem;
      break;
    default:
      return Icons.report_problem;
  }
  // if you add here, you have to change in tenant app too
}
