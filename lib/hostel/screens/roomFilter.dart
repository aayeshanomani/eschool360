import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as rangeslider;

import '../utils/utils.dart';
import '../utils/config.dart';

class RoomFilterActivity extends StatefulWidget {
  final Map<String, String> filter;

  RoomFilterActivity(this.filter);
  @override
  State<StatefulWidget> createState() {
    return new RoomFilterActivityState(this.filter);
  }
}

class RoomFilterActivityState extends State<RoomFilterActivity> {
  bool filled = false;
  int type = -1;

  TextEditingController roomno = new TextEditingController();
  TextEditingController rent = new TextEditingController();
  TextEditingController capacity = new TextEditingController();

  Map<String, bool> avaiableAmenities = new Map<String, bool>();

  bool loading = false;

  double rentLower = 0;
  double rentUpper = 20000;

  double capacityLower = 1;
  double capacityUpper = 10;

  final Map<String, String> filter;

  RoomFilterActivityState(this.filter);

  @override
  void initState() {
    super.initState();

    if (filter["roomno"] != null && filter["roomno"] != "") {
      roomno.text = filter["roomno"];
    }
    if (filter["vacant"] != null && filter["vacant"] != "") {
      filled = filter["vacant"] == "1";
    }
    if (filter["rent"] != null && filter["rent"] != "") {
      rentLower = double.parse(filter["rent"].split(",")[0]);
      if (filter["rent"].split(",")[1] != "10000000") {
        rentUpper = double.parse(filter["rent"].split(",")[1]);
      }
    }
    if (filter["capacity"] != null && filter["capacity"] != "") {
      capacityLower = double.parse(filter["capacity"].split(",")[0]);
      if (filter["capacity"].split(",")[1] != "1000") {
        capacityUpper = double.parse(filter["capacity"].split(",")[1]);
      }
    }

    amenities.forEach((amenity) =>
        amenity.length > 0 ? avaiableAmenities[amenity] = false : null);
    if (filter["amenities"] != null) {
      filter["amenities"].split(",").forEach((amenity) =>
          amenity.length > 0 ? avaiableAmenities[amenity] = true : null);
    }
  }

  List<Widget> amenitiesWidget() {
    List<Widget> widgets = new List();
    avaiableAmenities.forEach((k, v) => widgets.add(new GestureDetector(
          onTap: () {
            setState(() {
              avaiableAmenities[k] = !avaiableAmenities[k];
            });
          },
          child: new Row(
            children: <Widget>[
              new Checkbox(
                value: v,
                onChanged: (bool value) {
                  setState(() {
                    avaiableAmenities[k] = value;
                  });
                },
              ),
              new Text(getAmenityName(k))
            ],
          ),
        )));
    return widgets;
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
          "Room",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 4.0,
        actions: <Widget>[
          new MaterialButton(
            textColor: Colors.white,
            child: new Text(
              "FILTER",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Map<String, String> filter = new Map();
              if (roomno.text != "") {
                filter["roomno"] = roomno.text;
              }
              if (filled) {
                filter["vacant"] = "1";
              }
              if (type > 0) {
                filter["type"] = type.toString();
              }
              List<String> savedAmenities = new List();
              avaiableAmenities.forEach((k, v) {
                if (v) {
                  savedAmenities.add(k);
                }
              });
              if (savedAmenities.length > 0) {
                filter["amenities"] = savedAmenities.join(",");
              }
              filter["rent"] = rentLower.round().toString() +
                  "," +
                  (rentUpper.round() == 20000
                      ? "10000000"
                      : rentUpper.round().toString());
              filter["capacity"] = capacityLower.round().toString() +
                  "," +
                  (capacityUpper.round() == 10
                      ? "1000"
                      : capacityUpper.round().toString());
              Navigator.pop(context, filter);
            },
          ),
        ],
      ),
      body: new Container(
        margin: new EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1,
            25, MediaQuery.of(context).size.width * 0.1, 0),
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: new Text("Room No."),
                ),
                new Expanded(
                  child: new Container(
                    margin: new EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: new TextField(
                        controller: roomno,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: 'Room No.'),
                        onSubmitted: (String value) {}),
                  ),
                ),
              ],
            ),
            new Container(
              margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: new Text("Rent"),
                  ),
                  new Flexible(
                    child: new Container(
                      margin: new EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: new rangeslider.RangeSlider(
                        min: 0,
                        max: 20000,
                        lowerValue: rentLower,
                        upperValue: rentUpper,
                        divisions: 40,
                        showValueIndicator: true,
                        valueIndicatorMaxDecimals: 0,
                        onChanged:
                            (double newLowerValue, double newUpperValue) {
                          setState(() {
                            rentLower = newLowerValue;
                            rentUpper = newUpperValue;
                          });
                        },
                      ),
                    ),
                  ),
                  new Container(
                    child: new Text(
                      "+",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
            new Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Text(rentLower.round().toString() +
                      " - " +
                      (rentUpper.round() == 20000
                          ? rentUpper.round().toString() + "+"
                          : rentUpper.round().toString())),
                ],
              ),
            ),
            new Container(
              margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: new Text("Capacity"),
                  ),
                  new Flexible(
                    child: new Container(
                      margin: new EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: new rangeslider.RangeSlider(
                        min: 0,
                        max: 10,
                        lowerValue: capacityLower,
                        upperValue: capacityUpper,
                        showValueIndicator: true,
                        divisions: 10,
                        valueIndicatorMaxDecimals: 0,
                        onChanged:
                            (double newLowerValue, double newUpperValue) {
                          setState(() {
                            capacityLower = newLowerValue;
                            capacityUpper = newUpperValue;
                          });
                        },
                      ),
                    ),
                  ),
                  new Container(
                    child: new Text(
                      "+",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
            new Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Text(capacityLower.round().toString() +
                      " - " +
                      (capacityUpper.round() == 10
                          ? capacityUpper.round().toString() + "+"
                          : capacityUpper.round().toString())),
                ],
              ),
            ),
            new Container(
              margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: new Text("Available"),
                  ),
                  new Flexible(
                    child: new Container(
                      margin: new EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: new Checkbox(
                        value: filled,
                        onChanged: (bool value) {
                          setState(() {
                            filled = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              margin: new EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Radio(
                    value: -1,
                    groupValue: type,
                    onChanged: (value) {
                      setState(() {
                        type = value;
                      });
                    },
                  ),
                  new GestureDetector(
                    onTap: () {
                      setState(() {
                        type = -1;
                      });
                    },
                    child: new Text("All"),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: type,
                    onChanged: (value) {
                      setState(() {
                        type = value;
                      });
                    },
                  ),
                  new GestureDetector(
                    onTap: () {
                      setState(() {
                        type = 1;
                      });
                    },
                    child: new Text("Booked"),
                  ),
                  new Radio(
                    value: 2,
                    groupValue: type,
                    onChanged: (value) {
                      setState(() {
                        type = value;
                      });
                    },
                  ),
                  new GestureDetector(
                    onTap: () {
                      setState(() {
                        type = 2;
                      });
                    },
                    child: new Text("Vacating"),
                  ),
                ],
              ),
            ),
            new Container(
              margin: new EdgeInsets.fromLTRB(0, 30, 0, 0),
            ),
            new Container(
              margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: new Text("Amenities"),
                  ),
                ],
              ),
            ),
            new Expanded(
              child: new GridView.count(
                  childAspectRatio: 3,
                  primary: false,
                  crossAxisCount: 2,
                  children: amenitiesWidget()),
            ),
          ],
        ),
      ),
    );
  }
}
