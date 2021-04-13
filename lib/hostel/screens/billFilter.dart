import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as rangeslider;
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

import '../utils/utils.dart';
import '../utils/config.dart';

class BillFilterActivity extends StatefulWidget {
  final Map<String, String> filter;
  BillFilterActivity(this.filter);
  @override
  State<StatefulWidget> createState() {
    return new BillFilterActivityState(this.filter);
  }
}

class BillFilterActivityState extends State<BillFilterActivity> {
  int paid = -1;
  int type = -1;

  TextEditingController billID = new TextEditingController();
  TextEditingController expenseType = new TextEditingController();
  TextEditingController paymentType = new TextEditingController();
  TextEditingController title = new TextEditingController();
  TextEditingController amount = new TextEditingController();

  double amountLower = 0;
  double amountUpper = 20000;

  final Map<String, String> filter;

  BillFilterActivityState(this.filter);

  List<DateTime> billDates = new List();

  String billDatesRange = "Pick date range";

  String selectedType = "";
  String selectedPaymentType = "";

  List<List<String>> billFilterTypes = [];

  @override
  void initState() {
    super.initState();
    billTypes.forEach((billType) {
      billFilterTypes.add(billType);
    });
    billFilterTypes.add(["Rents", "10"]);
    billFilterTypes.add(["Salary", "11"]);

    if (filter["type"] != null && filter["type"] != "") {
      selectedType = filter["type"];
      billFilterTypes.forEach((types) {
        if (filter["type"] == types[1]) {
          expenseType.text = types[0];
        }
      });
    }

    if (filter["payment"] != null && filter["payment"] != "") {
      selectedPaymentType = filter["payment"];
      paymentTypes.forEach((types) {
        if (filter["payment"] == types[1]) {
          paymentType.text = types[0];
        }
      });
    }

    if (filter["billid"] != null && filter["billid"] != "") {
      billID.text = filter["billid"];
    }

    if (filter["paid"] != null && filter["paid"] != "") {
      paid = int.parse(filter["paid"]);
    }
    if (filter["amount"] != null && filter["amount"] != "") {
      amountLower = double.parse(filter["amount"].split(",")[0]);
      if (filter["amount"].split(",")[1] != "10000000") {
        amountUpper = double.parse(filter["amount"].split(",")[1]);
      }
    }
    if (filter["paid_date_time"] != null && filter["paid_date_time"] != "") {
      print(filter["paid_date_time"]);
      billDates.add(DateTime.parse(filter["paid_date_time"].split(",")[0]));
      billDates.add(DateTime.parse(filter["paid_date_time"].split(",")[1]));

      billDatesRange = headingDateFormat.format(billDates[0]) +
          " to " +
          headingDateFormat.format(billDates[1]);
    }
  }

  Future<String> selectTitle(BuildContext context) async {
    String returned = "";

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Select Expense Type"),
          content: new Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: billFilterTypes.length,
              itemBuilder: (context, i) {
                return new FlatButton(
                  child: new Text(billFilterTypes[i][0]),
                  onPressed: () {
                    returned = billFilterTypes[i][1];
                    expenseType.text = billFilterTypes[i][0];
                    selectedType = billFilterTypes[i][1];
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
    return returned;
  }

  Future<String> selectMode(BuildContext context) async {
    String returned = "";

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Select Payment Mode"),
          content: new Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: paymentTypes.length,
              itemBuilder: (context, i) {
                return new FlatButton(
                  child: new Text(paymentTypes[i][0]),
                  onPressed: () {
                    returned = paymentTypes[i][1];
                    paymentType.text = paymentTypes[i][0];
                    selectedPaymentType = paymentTypes[i][1];
                    Navigator.of(context).pop();
                  },
                );
              },
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
          "Bill",
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
              if (billDates.length > 0) {
                filter["paid_date_time"] = dateFormat.format(billDates[0]) +
                    "," +
                    dateFormat.format(billDates[1]);
              }
              if (paid >= 0) {
                filter["paid"] = paid.toString();
              }
              if (billID.text != "") {
                filter["billid"] = billID.text;
              }
              if (selectedType.length > 0) {
                filter["type"] = selectedType;
              }
              if (selectedPaymentType.length > 0) {
                filter["payment"] = selectedPaymentType;
              }
              filter["amount"] = amountLower.round().toString() +
                  "," +
                  (amountUpper.round() == 20000
                      ? "10000000"
                      : amountUpper.round().toString());
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
            new Container(
              margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: new Row(
                children: <Widget>[
                  new Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: new Text("Bill ID"),
                  ),
                  new Expanded(
                    child: new Container(
                      margin: new EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: new TextField(
                          controller: billID,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(hintText: 'Bill ID'),
                          onSubmitted: (String value) {}),
                    ),
                  ),
                ],
              ),
            ),
            new GestureDetector(
              onTap: () {
                selectTitle(context);
              },
              child: new Container(
                color: Colors.transparent,
                height: 50,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        child: new TextField(
                          enabled: false,
                          controller: expenseType,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.label),
                            border: OutlineInputBorder(),
                            labelText: 'Expense Type',
                          ),
                          onSubmitted: (String value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new GestureDetector(
              onTap: () {
                selectMode(context);
              },
              child: new Container(
                color: Colors.transparent,
                height: 50,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        child: new TextField(
                          enabled: false,
                          controller: paymentType,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.label),
                            border: OutlineInputBorder(),
                            labelText: 'Payment Mode',
                          ),
                          onSubmitted: (String value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new Container(
              margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: new Text("Amount"),
                  ),
                  new Flexible(
                    child: new Container(
                      margin: new EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: new rangeslider.RangeSlider(
                        min: 0,
                        max: 20000,
                        lowerValue: amountLower,
                        upperValue: amountUpper,
                        divisions: 40,
                        showValueIndicator: true,
                        valueIndicatorMaxDecimals: 0,
                        onChanged:
                            (double newLowerValue, double newUpperValue) {
                          setState(() {
                            amountLower = newLowerValue;
                            amountUpper = newUpperValue;
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
                  new Text(amountLower.round().toString() +
                      " - " +
                      (amountUpper.round() == 20000
                          ? amountUpper.round().toString() + "+"
                          : amountUpper.round().toString())),
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
                    child: new Text("Bill Date"),
                  ),
                  new Flexible(
                    child: new Container(
                      margin: new EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: new FlatButton(
                          onPressed: () async {
                            final List<DateTime> picked =
                                await DateRagePicker.showDatePicker(
                                    context: context,
                                    initialFirstDate: new DateTime.now(),
                                    initialLastDate: (new DateTime.now())
                                        .add(new Duration(days: 7)),
                                    firstDate: new DateTime.now()
                                        .subtract(new Duration(days: 10 * 365)),
                                    lastDate: new DateTime.now()
                                        .add(new Duration(days: 10 * 365)));
                            if (picked != null && picked.length == 2) {
                              billDates = picked;
                              setState(() {
                                billDatesRange =
                                    headingDateFormat.format(billDates[0]) +
                                        " to " +
                                        headingDateFormat.format(billDates[1]);
                              });
                            }
                          },
                          child: new Text(billDatesRange)),
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
                    child: new Text("Show"),
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
                    groupValue: paid,
                    onChanged: (value) {
                      setState(() {
                        paid = value;
                      });
                    },
                  ),
                  new GestureDetector(
                    onTap: () {
                      setState(() {
                        paid = -1;
                      });
                    },
                    child: new Text("All"),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: paid,
                    onChanged: (value) {
                      setState(() {
                        paid = value;
                      });
                    },
                  ),
                  new GestureDetector(
                    onTap: () {
                      setState(() {
                        paid = 1;
                      });
                    },
                    child: new Text("Paid"),
                  ),
                  new Radio(
                    value: 0,
                    groupValue: paid,
                    onChanged: (value) {
                      setState(() {
                        paid = value;
                      });
                    },
                  ),
                  new GestureDetector(
                    onTap: () {
                      setState(() {
                        paid = 0;
                      });
                    },
                    child: new Text("Received"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
