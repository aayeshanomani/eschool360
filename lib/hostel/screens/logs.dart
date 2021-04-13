import 'package:flutter/material.dart';
import 'dart:async';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../utils/utils.dart';

import '../utils/models.dart';
import '../utils/api.dart';
import '../utils/config.dart';

class LogsActivity extends StatefulWidget {
  LogsActivity();
  @override
  LogsActivityState createState() {
    return new LogsActivityState();
  }
}

class LogsActivityState extends State<LogsActivity> {
  Map<String, String> filter = new Map();

  List<ListItem> logs = new List();
  bool end = false;
  bool ongoing = false;

  double width = 0;

  String offset = defaultOffset;
  bool loading = true;

  ScrollController _controller;

  String previousDate = "";

  @override
  void initState() {
    super.initState();

    filter["status"] = "1";
    filter["hostel_id"] = hostelID;

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
        Future<Logs> data = getLogs(filter);
        data.then((response) {
          if (response != null) {
            if (response.logs != null && response.logs.length > 0) {
              offset =
                  (int.parse(response.pagination.offset) + response.logs.length)
                      .toString();
              response.logs.forEach((log) {
                if (log is Log) {
                  if (previousDate
                          .compareTo(log.createdDateTime.split(" ")[0]) !=
                      0) {
                    previousDate = log.createdDateTime.split(" ")[0];
                    logs.add(HeadingItem(previousDate));
                  }
                }
                if (log.type == "2") {
                  // bill
                  log.color = "#67CCB7";
                  log.icon = Icons.attach_money;
                  log.title = "Bill";
                } else if (log.type == "3") {
                  // employee
                  log.color = "#539ECE";
                  log.icon = Icons.account_box;
                  log.title = "Employee";
                } else if (log.type == "5") {
                  // note
                  log.color = "#D8B868";
                  log.icon = Icons.format_list_numbered;
                  log.title = "Task";
                } else if (log.type == "6") {
                  // room
                  log.color = "#DF7B8D";
                  log.icon = Icons.local_hotel;
                  log.title = "Room";
                } else if (log.type == "7") {
                  // rent
                  log.color = "#67CCB7";
                  log.icon = Icons.attach_money;
                  log.title = "Rent";
                } else if (log.type == "8") {
                  // salary
                  log.color = "#67CCB7";
                  log.icon = Icons.attach_money;
                  log.title = "Salary";
                } else if (log.type == "9") {
                  // user
                  log.color = "#A179E0";
                  log.icon = Icons.supervisor_account;
                  log.title = "User";
                } else if (log.type == "10") {
                  // user
                  log.color = "#E1A1AD";
                  log.icon = Icons.report_problem;
                  log.title = "Complaint";
                } else if (log.type == "11") {
                  // user
                  log.color = "#82b832";
                  log.icon = Icons.local_dining;
                  log.title = "Food";
                } else if (log.type == "12") {
                  // user
                  log.color = "#D3D3D3";
                  log.icon = Icons.list;
                  log.title = "Food";
                } else {
                  log.color = "#C36BB4";
                  log.icon = Icons.track_changes;
                  log.title = "";
                }
                logs.add(log);
              });
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
          "Activity",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ModalProgressHUD(
        child: logs.length == 0
            ? new Center(
                child: new Text(loading ? "" : "No activity"),
              )
            : new ListView.builder(
                controller: _controller,
                itemCount: logs.length,
                itemBuilder: (context, i) {
                  final item = logs[i];
                  if (item is HeadingItem) {
                    return new Container(
                      decoration: i != 0
                          ? new BoxDecoration(
                              border: new Border(
                              top: BorderSide(
                                color: HexColor("#dedfe0"),
                              ),
                            ))
                          : null,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(0, i != 0 ? 10 : 0, 0, 0),
                      child: new Text(
                        headingDateFormat.format(DateTime.parse(item.heading)),
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    );
                  } else if (item is Log) {
                    return new ListTile(
                      dense: true,
                      title: new Container(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                                padding: EdgeInsets.all(7),
                                color: HexColor(item.color),
                                child: new Icon(
                                  item.icon,
                                  color: Colors.white,
                                )),
                            new Expanded(
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new Text(
                                          item.title + " ",
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      new Text(
                                        timeFormat.format(
                                            DateTime.parse(item.createdDateTime)
                                                .add(new Duration(
                                                    hours: 5, minutes: 30))),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w100,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  new Text(
                                    item.by + " " + item.log,
                                    // maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
        inAsyncCall: loading,
      ),
    );
  }
}
