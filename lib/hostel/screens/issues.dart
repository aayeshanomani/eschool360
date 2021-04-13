import 'package:flutter/material.dart';
import 'dart:async';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../utils/utils.dart';

import '../utils/models.dart';
import '../utils/api.dart';
import '../utils/config.dart';
import 'issueFilter.dart';

class IssuesActivity extends StatefulWidget {
  IssuesActivity();
  @override
  IssuesActivityState createState() {
    return new IssuesActivityState();
  }
}

class IssuesActivityState extends State<IssuesActivity> {
  IssuesActivityState();

  Map<String, String> filter = new Map();

  Map<String, String> filterby = new Map();

  List<ListItem> issues = new List();
  bool end = false;
  bool ongoing = false;

  String offset = defaultOffset;
  bool loading = true;

  String previousDate = "";
  double width = 0;

  ScrollController _controller;

  @override
  void initState() {
    super.initState();

    filter["status"] = "1";
    filter["hostel_id"] = hostelID;
    filter["limit"] = defaultLimit;
    filter["offset"] = offset;
    filter["orderby"] = "created_date_time";
    filter["sortby"] = "desc";

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
        Future<Issues> data = getIssues(filter);
        data.then((response) {
          if (response != null) {
            if (response.issues != null && response.issues.length > 0) {
              offset = (int.parse(response.pagination.offset) +
                      response.issues.length)
                  .toString();
              response.issues.forEach((issue) {
                if (issue is Issue) {
                  if (previousDate
                          .compareTo(issue.createdDateTime.split(" ")[0]) !=
                      0) {
                    previousDate = issue.createdDateTime.split(" ")[0];
                    issues.add(HeadingItem(previousDate));
                  }
                }
                issues.add(issue);
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

  filterPage(BuildContext context, Widget page) async {
    final data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    ) as Map<String, String>;

    if (data != null) {
      filterby = data;
      data["status"] = "1";
      data["hostel_id"] = hostelID;
      data["limit"] = defaultLimit;
      data["offset"] = defaultOffset;
      data["orderby"] = "created_date_time";
      data["sortby"] = "desc";
      offset = defaultOffset;
      setState(() {
        filter = data;
        issues.clear();
        fillData();
      });
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
          "Complaints",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          new IconButton(
            onPressed: () {
              filterPage(context, new IssueFilterActivity(filterby));
            },
            icon: new Icon(Icons.filter_list),
          )
        ],
      ),
      body: ModalProgressHUD(
        child: issues.length == 0
            ? new Center(
                child: new Text(loading ? "" : "No complaints"),
              )
            : new ListView.builder(
                controller: _controller,
                itemCount: issues.length,
                itemBuilder: (context, i) {
                  final item = issues[i];
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
                  } else if (item is Issue) {
                    return new ListTile(
                      dense: true,
                      onTap: () {
                        if (item.resolve == "0") {
                          Future<bool> dialog = twoButtonDialog(
                              context, "Is the issue resolved?", "");
                          dialog.then((onValue) {
                            if (onValue) {
                              setState(() {
                                loading = true;
                              });
                              Future<bool> load = update(
                                API.ISSUE,
                                Map.from({
                                  'resolve': "1",
                                }),
                                Map.from(
                                    {'hostel_id': hostelID, 'id': item.id}),
                              );
                              load.then((onValue) {
                                setState(() {
                                  loading = false;
                                });
                                filter["status"] = "1";
                                filter["hostel_id"] = hostelID;
                                filter["limit"] = defaultLimit;
                                filter["offset"] = defaultOffset;
                                filter["orderby"] = "created_date_time";
                                filter["sortby"] = "desc";
                                offset = defaultOffset;
                                issues.clear();
                                fillData();
                              });
                            }
                          });
                        }
                      },
                      title: new Container(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                                padding: EdgeInsets.all(7),
                                color: item.resolve == "1"
                                    ? HexColor(COLORS.GREEN)
                                    : HexColor(COLORS.RED),
                                child: new Icon(
                                  getIssueIcon(item.type),
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
                                    children: <Widget>[
                                      new Flexible(
                                        child: new Text(
                                          getIssueType(item.type),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      new Text(
                                        item.resolve == "0"
                                            ? "Pending"
                                            : "Resolved",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: item.resolve == "0"
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                  new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Container(
                                        width: width * 0.6,
                                        child: new Text(
                                          item.username + "\n" + item.title,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              fontSize: 15,
                                              // fontWeight: FontWeight.w100,
                                              color: Colors.black),
                                        ),
                                      ),
                                      new Text(
                                        "Room No:" + item.roomno,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
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
