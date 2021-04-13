import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as rangeslider;

class UserFilterActivity extends StatefulWidget {
  final Map<String, String> filter;

  UserFilterActivity(this.filter);
  @override
  State<StatefulWidget> createState() {
    return new UserFilterActivityState(this.filter);
  }
}

class UserFilterActivityState extends State<UserFilterActivity> {
  int food = -1;
  int type = -1;
  int paymenttype = -1;

  TextEditingController name = new TextEditingController();
  TextEditingController foodC = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();

  double rentLower = 0;
  double rentUpper = 20000;

  final Map<String, String> filter;

  UserFilterActivityState(this.filter);

  @override
  void initState() {
    super.initState();

    if (filter["name"] != null && filter["name"] != "") {
      name.text = filter["name"];
    }
    if (filter["phone"] != null && filter["phone"] != "") {
      phone.text = filter["phone"];
    }
    if (filter["email"] != null && filter["email"] != "") {
      email.text = filter["email"];
    }
    if (filter["food"] != null && filter["food"] != "") {
      food = int.parse(filter["food"]);
    }
    if (filter["rent"] != null && filter["rent"] != "") {
      rentLower = double.parse(filter["rent"].split(",")[0]);
      if (filter["rent"].split(",")[1] != "10000000") {
        rentUpper = double.parse(filter["rent"].split(",")[1]);
      }
    }
  }

  Future<int> selectFood(BuildContext context) async {
    int returned = -1;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Select room"),
          content: new Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: new ListView(
              shrinkWrap: true,
              children: <Widget>[
                new FlatButton(
                  child: new Text("All"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    returned = -1;

                    setState(() {
                      foodC.text = "All";
                      food = -1;
                    });
                  },
                ),
                new FlatButton(
                  child: new Text("Veg"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    returned = 0;

                    setState(() {
                      foodC.text = "Veg";
                      food = 0;
                    });
                  },
                ),
                new FlatButton(
                  child: new Text("Non Veg"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    returned = 1;

                    setState(() {
                      foodC.text = "Non Veg";
                      food = 1;
                    });
                  },
                ),
                new FlatButton(
                  child: new Text("None"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    returned = 2;

                    setState(() {
                      foodC.text = "None";
                      food = 2;
                    });
                  },
                )
              ],
            ),
          ),
        );
      },
    );
    return returned;
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
          "User",
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
              if (name.text != "") {
                filter["name"] = name.text;
              }
              if (phone.text != "") {
                filter["phone"] = phone.text;
              }
              if (type > 0) {
                filter["type"] = type.toString();
              }
              if (paymenttype >= 0) {
                filter["payment_status"] = paymenttype.toString();
              }
              if (email.text != "") {
                filter["email"] = email.text;
              }
              if (food >= 0) {
                filter["food"] = food.toString();
              }
              filter["rent"] = rentLower.round().toString() +
                  "," +
                  (rentUpper.round() == 20000
                      ? "10000000"
                      : rentUpper.round().toString());
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
                  child: new Text("Name"),
                ),
                new Expanded(
                  child: new Container(
                    margin: new EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: new TextField(
                        controller: name,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(hintText: 'Name'),
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
                    child: new Text("Phone"),
                  ),
                  new Expanded(
                    child: new Container(
                      margin: new EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: new TextField(
                          controller: phone,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(hintText: 'Phone'),
                          onSubmitted: (String value) {}),
                    ),
                  ),
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
                    child: new Text("Email"),
                  ),
                  new Expanded(
                    child: new Container(
                      margin: new EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: new TextField(
                          controller: email,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(hintText: 'Email'),
                          onSubmitted: (String value) {}),
                    ),
                  ),
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
              margin: new EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Radio(
                    value: -1,
                    groupValue: paymenttype,
                    onChanged: (value) {
                      setState(() {
                        paymenttype = value;
                      });
                    },
                  ),
                  new GestureDetector(
                    onTap: () {
                      setState(() {
                        paymenttype = -1;
                      });
                    },
                    child: new Text("All"),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: paymenttype,
                    onChanged: (value) {
                      setState(() {
                        paymenttype = value;
                      });
                    },
                  ),
                  new GestureDetector(
                    onTap: () {
                      setState(() {
                        paymenttype = 1;
                      });
                    },
                    child: new Text("Paid"),
                  ),
                  new Radio(
                    value: 0,
                    groupValue: paymenttype,
                    onChanged: (value) {
                      setState(() {
                        paymenttype = value;
                      });
                    },
                  ),
                  new GestureDetector(
                    onTap: () {
                      setState(() {
                        paymenttype = 0;
                      });
                    },
                    child: new Text("Due"),
                  ),
                ],
              ),
            ),
            new Container(
              margin: new EdgeInsets.fromLTRB(0, 20, 0, 0),
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
            new Expanded(
              child: new GridView.count(
                childAspectRatio: 3,
                primary: false,
                crossAxisCount: 2,
                children: <Widget>[
                  new GestureDetector(
                    onTap: () {
                      setState(() {
                        food = -1;
                      });
                    },
                    child: new Row(
                      children: <Widget>[
                        new Radio(
                          value: -1,
                          groupValue: food,
                          onChanged: (value) {
                            setState(() {
                              food = -1;
                            });
                          },
                        ),
                        new Text("All")
                      ],
                    ),
                  ),
                  new GestureDetector(
                    onTap: () {
                      setState(() {
                        food = 0;
                      });
                    },
                    child: new Row(
                      children: <Widget>[
                        new Radio(
                          value: 0,
                          groupValue: food,
                          onChanged: (value) {
                            setState(() {
                              food = 0;
                            });
                          },
                        ),
                        new Text("Veg")
                      ],
                    ),
                  ),
                  new GestureDetector(
                    onTap: () {
                      setState(() {
                        food = 1;
                      });
                    },
                    child: new Row(
                      children: <Widget>[
                        new Radio(
                          value: 1,
                          groupValue: food,
                          onChanged: (value) {
                            setState(() {
                              food = 1;
                            });
                          },
                        ),
                        new Text("Non Veg")
                      ],
                    ),
                  ),
                  new GestureDetector(
                    onTap: () {
                      setState(() {
                        food = 2;
                      });
                    },
                    child: new Row(
                      children: <Widget>[
                        new Radio(
                          value: 2,
                          groupValue: food,
                          onChanged: (value) {
                            setState(() {
                              food = 2;
                            });
                          },
                        ),
                        new Text("None")
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
