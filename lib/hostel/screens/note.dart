import 'package:flutter/material.dart';

import '../utils/api.dart';
import '../utils/config.dart';
import '../utils/models.dart';
import '../utils/utils.dart';

class NoteActivity extends StatefulWidget {
  final Note note;

  NoteActivity(this.note);
  @override
  State<StatefulWidget> createState() {
    return new NoteActivityState(note);
  }
}

class NoteActivityState extends State<NoteActivity> {
  TextEditingController item = new TextEditingController();
  Note note;

  bool loading = false;

  NoteActivityState(this.note);

  @override
  void initState() {
    super.initState();
    if (note != null) {
      item.text = note.note;
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
          "Note",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 4.0,
        actions: <Widget>[
          new MaterialButton(
            textColor: Colors.white,
            child: note != null
                ? new Text(
                    "SAVE",
                    style: TextStyle(color: Colors.black),
                  )
                : new Text(
                    "ADD",
                    style: TextStyle(color: Colors.black),
                  ),
            onPressed: () {
              if (item.text.length == 0) {
                return;
              }
              setState(() {
                loading = true;
              });

              checkInternet().then((internet) {
                if (internet == null || !internet) {
                  oneButtonDialog(context, "No Internet connection", "", true);
                  setState(() {
                    loading = false;
                  });
                } else {
                  Future<bool> load;
                  if (note != null) {
                    load = update(
                      API.NOTE,
                      Map.from({
                        "note": item.text,
                      }),
                      Map.from({'hostel_id': hostelID, 'id': note.id}),
                    );
                  } else {
                    load = add(
                      API.NOTE,
                      Map.from({
                        'hostel_id': hostelID,
                        'note': item.text,
                        'status': "1"
                      }),
                    );
                  }
                  load.then((onValue) {
                    setState(() {
                      loading = false;
                    });
                    if (onValue != null) {
                      if (note != null) {
                        Navigator.pop(context, "");
                      } else {
                        Navigator.pop(context, "");
                      }
                    } else {
                      oneButtonDialog(
                          context, "Network error", "Please try again", true);
                    }
                  });
                }
              });
            },
          ),
        ],
      ),
      body: loading
          ? CircularProgressIndicator()
          : new Container(
              margin: new EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.1,
                  0,
                  MediaQuery.of(context).size.width * 0.1,
                  0),
              child: new ListView(
                children: <Widget>[
                  new Container(
                    height: 200,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Flexible(
                          child: new Container(
                            child: new TextField(
                              controller: item,
                              maxLines: 5,
                              textInputAction: TextInputAction.newline,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                isDense: true,
                                prefixIcon: Icon(Icons.note),
                                border: OutlineInputBorder(),
                                labelText: 'Note',
                              ),
                              onSubmitted: (String value) {},
                            ),
                          ),
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
