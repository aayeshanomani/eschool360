import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import './employee.dart';
import './bills.dart';
import '../utils/models.dart';
import '../utils/api.dart';
import '../utils/config.dart';
import '../utils/utils.dart';

class EmployeesActivity extends StatefulWidget {
  @override
  EmployeesActivityState createState() {
    return new EmployeesActivityState();
  }
}

class EmployeesActivityState extends State<EmployeesActivity> {
  Map<String, String> filter = new Map();

  List<Employee> employees = new List();
  bool end = false;
  bool ongoing = false;

  double width = 0;

  String offset = defaultOffset;
  bool loading = true;

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    filter["status"] = "1";
    filter["hostel_id"] = hostelID;
    filter["limit"] = defaultLimit;
    filter["offset"] = offset;

    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    fillData();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if (!end && !ongoing) {
        setState(() {
          loading = true;
        });
        fillData();
      }
    }
  }

  void fillData() {
    checkInternet().then((internet) {
      if (internet == null || !internet) {
        oneButtonDialog(context, "No Internet connection", "", true);
        setState(() {
          ongoing = false;
          loading = false;
        });
      } else {
        ongoing = true;
        filter["offset"] = offset;
        Future<Employees> data = getEmployees(filter);
        data.then((response) {
          if (response != null) {
            if (response.employees != null && response.employees.length > 0) {
              offset = (int.parse(response.pagination.offset) +
                      response.employees.length)
                  .toString();
              employees.addAll(response.employees);
            } else {
              end = true;
            }
            if (response.meta != null && response.meta.messageType == "1") {
              oneButtonDialog(context, "", response.meta.message,
                  !(response.meta.status == STATUS_403));
            }
            setState(() {
              ongoing = false;
              loading = false;
            });
          } else {
            new Timer(Duration(milliseconds: random.nextInt(5) * 1000), () {
              setState(() {
                fillData();
              });
            });
          }
        });
      }
    });
  }

  addPage(BuildContext context, Widget page) async {
    final data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    ) as String;

    if (data != null) {
      filter["status"] = "1";
      filter["hostel_id"] = hostelID;
      filter["limit"] = defaultLimit;
      filter["offset"] = offset;
      offset = defaultOffset;

      employees.clear();
      fillData();
    }
  }

  billsPage(BuildContext context, Widget page) async {
    final data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    ) as String;

    if (data != null) {
      filter["status"] = "1";
      filter["hostel_id"] = hostelID;
      filter["limit"] = defaultLimit;
      filter["offset"] = offset;
      offset = defaultOffset;

      employees.clear();
      fillData();
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return new Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: new Text(
          "Employees",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          // new IconButton(
          //   onPressed: () {
          //     Map<String, String> mailFilter = filter;
          //     mailFilter["offset"] = "0";
          //     mailFilter["shouldMail"] = "true";
          //     mailFilter["shouldMailID"] = adminEmailID;
          //     getEmployees(mailFilter);
          //     oneButtonDialog(context,
          //         "Employees data is sent to your registered mail", "", true);
          //   },
          //   icon: new Icon(Icons.mail),
          // ),
          new IconButton(
            onPressed: () {
              addPage(context, new EmployeeActivity(null));
            },
            icon: new Icon(Icons.add),
          ),
        ],
      ),
      body: ModalProgressHUD(
        child: employees.length == 0
            ? new Center(
                child: new Text(loading ? "" : "No employees"),
              )
            : new ListView.separated(
                controller: _controller,
                itemCount: employees.length,
                separatorBuilder: (context, i) {
                  return new Divider();
                },
                itemBuilder: (itemContext, i) {
                  return new GestureDetector(
                    onTap: () {
                      billsPage(context, new BillsActivity(null, employees[i]));
                    },
                    child: new Container(
                      padding: EdgeInsets.fromLTRB(10, i == 0 ? 10 : 0, 10, 0),
                      child: new Slidable(
                        actionPane: new SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    margin: EdgeInsets.fromLTRB(0, 3, 10, 10),
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    decoration: new BoxDecoration(
                                      color: HexColor(COLORS.GREEN),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: new Text(
                                      employees[i].name[0].toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  new Expanded(
                                      child: new Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: new Column(
                                      children: <Widget>[
                                        new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new Text(
                                                employees[i]
                                                        .name[0]
                                                        .toUpperCase() +
                                                    employees[i]
                                                        .name
                                                        .substring(1),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            new Text(
                                              "₹" + employees[i].salary,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.green),
                                            )
                                          ],
                                        ),
                                        new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            new Text(
                                              employees[i].designation,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        new Container(
                                          height: 10,
                                        ),
                                        new Row(
                                          children: <Widget>[
                                            employees[i].phone != ""
                                                ? new GestureDetector(
                                                    onTap: () {
                                                      makePhone(
                                                          employees[i].phone);
                                                    },
                                                    child: new Container(
                                                      child: new Row(
                                                        children: <Widget>[
                                                          new Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            child: new Icon(
                                                                Icons.phone,
                                                                size: 15,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          new Text(
                                                            employees[i].phone,
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .black),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : new Container(),
                                            employees[i].phone != ""
                                                ? new Container(
                                                    height: 0,
                                                    width: 10,
                                                  )
                                                : new Container(),
                                            employees[i].email != ""
                                                ? new GestureDetector(
                                                    onTap: () {
                                                      sendMail(
                                                          employees[i].email,
                                                          "",
                                                          "");
                                                    },
                                                    child: new Container(
                                                      child: new Row(
                                                        children: <Widget>[
                                                          new Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            child: new Icon(
                                                                Icons.email,
                                                                size: 15,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          new Text(
                                                            employees[i].email,
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .black),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : new Container(),
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ],
                        ),
                        secondaryActions: <Widget>[
                          new IconSlideAction(
                            caption: 'EDIT',
                            icon: Icons.edit,
                            color: Colors.blue,
                            onTap: () {
                              addPage(
                                  context, new EmployeeActivity(employees[i]));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
        inAsyncCall: loading,
      ),
    );
  }
}
