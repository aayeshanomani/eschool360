import 'package:flutter/material.dart';
import 'dart:async';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import './note.dart';
import '../utils/models.dart';
import '../utils/api.dart';
import '../utils/config.dart';
import '../utils/utils.dart';

class NotesActivity extends StatefulWidget {
  @override
  NotesActivityState createState() {
    return new NotesActivityState();
  }
}

class NotesActivityState extends State<NotesActivity> {
  bool checked = false;
  Map<String, String> filter = new Map();

  List<ListItem> notes = new List();
  bool end = false;
  bool ongoing = false;

  String offset = defaultOffset;
  bool loading = true;

  String createdDateTime = "";

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
        Future<Notes> data = getNotes(filter);
        data.then((response) {
          if (response != null) {
            if (response.notes != null && response.notes.length > 0) {
              offset = (int.parse(response.pagination.offset) +
                      response.notes.length)
                  .toString();
              response.notes.forEach((note) {
                if (note is Note) {
                  print(note.createdDateTime);
                  if (createdDateTime
                          .compareTo(note.createdDateTime.split(" ")[0]) !=
                      0) {
                    createdDateTime = note.createdDateTime.split(" ")[0];
                    notes.add(HeadingItem(createdDateTime));
                  }
                }
                notes.add(note);
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
      filter["orderby"] = "created_date_time";
      filter["sortby"] = "desc";
      offset = defaultOffset;

      notes.clear();
      fillData();
    }
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
          "Tasks",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          new Checkbox(
            value: checked,
            onChanged: (bool value) {
              filter["status"] = checked ? "1" : "0";
              filter["hostel_id"] = hostelID;
              filter["limit"] = defaultLimit;
              offset = defaultOffset;
              filter["offset"] = defaultOffset;
              filter["orderby"] = "created_date_time";
              filter["sortby"] = "desc";
              setState(() {
                checked = value;
                notes.clear();
                setState(() {
                  loading = true;
                });
                fillData();
              });
            },
          ),
          new IconButton(
            onPressed: () {
              addPage(context, new NoteActivity(null));
            },
            icon: new Icon(Icons.add),
          ),
        ],
      ),
      body: ModalProgressHUD(
        child: notes.length == 0
            ? new Center(
                child: new Text(loading ? "" : "No tasks"),
              )
            : new ListView.separated(
                controller: _controller,
                itemCount: notes.length,
                separatorBuilder: (context, index) {
                  return Container();
                },
                itemBuilder: (context, i) {
                  final item = notes[i];
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
                  } else if (item is Note) {
                    return new ListTile(
                      onTap: () {
                        setState(() {
                          (notes[i] as Note).status =
                              (notes[i] as Note).status == "1" ? "0" : "1";
                          update(
                            API.NOTE,
                            Map.from({
                              "status": (notes[i] as Note).status,
                            }),
                            Map.from({
                              'hostel_id': hostelID,
                              'id': (notes[i] as Note).id
                            }),
                          );
                        });
                      },
                      title: new Container(
                        margin: new EdgeInsets.all(0),
                        child: new Row(
                          children: <Widget>[
                            new Container(
                              margin: EdgeInsets.only(right: 10),
                              child: new Checkbox(
                                value: (notes[i] as Note).status == "0",
                                onChanged: (bool value) {
                                  setState(() {
                                    (notes[i] as Note).status =
                                        (notes[i] as Note).status == "1"
                                            ? "0"
                                            : "1";
                                    update(
                                      API.NOTE,
                                      Map.from({
                                        "status": (notes[i] as Note).status,
                                      }),
                                      Map.from({
                                        'hostel_id': hostelID,
                                        'id': (notes[i] as Note).id
                                      }),
                                    );
                                  });
                                },
                              ),
                            ),
                            new Flexible(
                              child: new Text(
                                (notes[i] as Note).note,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w100,
                                    color: (notes[i] as Note).status == "0"
                                        ? Colors.grey
                                        : Colors.black,
                                    decoration: (notes[i] as Note).status == "0"
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none),
                              ),
                            )
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
