import 'package:flutter/material.dart';
import 'dart:async';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../utils/models.dart';
import '../utils/api.dart';
import '../utils/config.dart';
import '../utils/utils.dart';
import 'notice.dart';

class NoticesActivity extends StatefulWidget {
  NoticesActivity();

  @override
  NoticesActivityState createState() {
    return new NoticesActivityState();
  }
}

class NoticesActivityState extends State<NoticesActivity> {
  Map<String, String> filter = new Map();

  List<Notice> notices = new List();
  bool end = false;
  bool ongoing = false;

  double width = 0;

  String offset = defaultOffset;
  bool loading = true;

  ScrollController _controller;

  NoticesActivityState();

  @override
  void initState() {
    super.initState();

    filter["status"] = "1";
    filter["hostel_id"] = hostelID;
    filter["limit"] = defaultLimit;
    filter["offset"] = defaultOffset;
    filter["orderby"] = "date";
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
        Future<Notices> data = getNotices(filter);
        data.then((response) {
          if (response != null) {
            if (response.notices != null && response.notices.length > 0) {
              offset = (int.parse(response.pagination.offset) +
                      response.notices.length)
                  .toString();
              notices.addAll(response.notices);
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
      filter["offset"] = defaultOffset;
      filter["orderby"] = "date";
      filter["sortby"] = "desc";
      offset = defaultOffset;

      notices.clear();
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
          "Notices",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          new IconButton(
            onPressed: () {
              addPage(context, new NoticeActivity(null));
            },
            icon: new Icon(Icons.add),
          )
        ],
      ),
      body: ModalProgressHUD(
        child: notices.length == 0
            ? new Center(
                child: new Text(loading ? "" : "No notices"),
              )
            : new ListView.separated(
                controller: _controller,
                itemCount: notices.length,
                separatorBuilder: (context, i) {
                  return new Container();
                },
                itemBuilder: (itemContext, i) {
                  return new GestureDetector(
                    onTap: () {
                      addPage(context, new NoticeActivity(notices[i]));
                    },
                    child: new Card(
                      child: new Container(
                        padding: EdgeInsets.all(10),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            notices[i].img == ""
                                ? new Container()
                                : new Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: new Image.network(
                                      mediaURL + notices[i].img,
                                      fit: BoxFit.fitWidth,
                                      width: width,
                                    ),
                                  ),
                            new Text(
                              notices[i].title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            new Divider(),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                notices[i].description.length > 0
                                    ? new Container(
                                        width: width * 0.6,
                                        child: new Text(
                                          notices[i].description,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                      )
                                    : new Container(),
                                new Text(
                                  headingDateFormat
                                      .format(DateTime.parse(notices[i].date)),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            )
                          ],
                        ),
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
