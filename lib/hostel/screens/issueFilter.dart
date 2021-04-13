import 'package:flutter/material.dart';

import '../utils/utils.dart';
import '../utils/config.dart';

class IssueFilterActivity extends StatefulWidget {
  final Map<String, String> filter;
  IssueFilterActivity(this.filter);
  @override
  State<StatefulWidget> createState() {
    return new IssueFilterActivityState(this.filter);
  }
}

class IssueFilterActivityState extends State<IssueFilterActivity> {
  int resolve = -1;
  int type = -1;

  TextEditingController resolveText = new TextEditingController();
  TextEditingController typeText = new TextEditingController();

  final Map<String, String> filter;

  IssueFilterActivityState(this.filter);

  @override
  void initState() {
    super.initState();
    if (filter != null) {
      if (filter["resolve"] != null && filter["resolve"].length > 0) {
        resolve = int.parse(filter["resolve"]);
        resolveText.text = filter["resolve"] == "1" ? "Resolved" : "Pending";
      }
      if (filter["type"] != null && filter["type"].length > 0) {
        type = int.parse(filter["type"]);
        typeText.text = getIssueType((filter["type"]));
      }
    }
  }

  Future<String> selectType(BuildContext context) async {
    String returned = "";

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Select Complaint Type"),
          content: new Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: issueTypes.length,
              itemBuilder: (context, i) {
                return new FlatButton(
                  child: new Text(issueTypes[i][0]),
                  onPressed: () {
                    returned = issueTypes[i][1];
                    typeText.text = issueTypes[i][0];
                    type = int.parse(issueTypes[i][1]);
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
          "Complaint",
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
              if (type >= 0) {
                filter["type"] = type.toString();
              }
              if (resolve >= 0) {
                filter["resolve"] = resolve.toString();
              }
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
            new GestureDetector(
              onTap: () {
                selectType(context);
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
                          controller: typeText,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.label),
                            border: OutlineInputBorder(),
                            labelText: 'Complaint Type',
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
                    child: new Text("Status"),
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
                    groupValue: resolve,
                    onChanged: (value) {
                      setState(() {
                        resolve = value;
                      });
                    },
                  ),
                  new GestureDetector(
                    onTap: () {
                      setState(() {
                        resolve = -1;
                      });
                    },
                    child: new Text("All"),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: resolve,
                    onChanged: (value) {
                      setState(() {
                        resolve = value;
                      });
                    },
                  ),
                  new GestureDetector(
                    onTap: () {
                      setState(() {
                        resolve = 1;
                      });
                    },
                    child: new Text("Resolved"),
                  ),
                  new Radio(
                    value: 0,
                    groupValue: resolve,
                    onChanged: (value) {
                      setState(() {
                        resolve = value;
                      });
                    },
                  ),
                  new GestureDetector(
                    onTap: () {
                      setState(() {
                        resolve = 0;
                      });
                    },
                    child: new Text("Pending"),
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
