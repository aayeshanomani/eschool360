import 'package:eschool360/hostel/screens/pro.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../utils/api.dart';
import '../utils/config.dart';
import '../utils/models.dart';
import '../utils/utils.dart';
import './photo.dart';

class NoticeActivity extends StatefulWidget {
  final Notice notice;
  NoticeActivity(this.notice);

  @override
  State<StatefulWidget> createState() {
    return new NoticeActivityState(notice);
  }
}

class NoticeActivityState extends State<NoticeActivity> {
  int paid = 1;

  TextEditingController title = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController noticeDate = new TextEditingController();

  String pickedNoticeDate = '';

  Notice notice;

  bool loading = false;
  List<String> fileNames = new List();
  List<Widget> fileWidgets = new List();

  NoticeActivityState(this.notice);

  bool titleCheck = false;

  String selectedType = "0";
  String selectedPayment = "0";

  @override
  void initState() {
    super.initState();
    if (notice != null) {
      print(notice.title);
      print(notice.description);
      print(notice.img);
      title.text = notice.title;
      description.text = notice.description;
      List<String> arr = notice.img.split(",");
      arr.forEach((f) {
        if (f.length > 0) {
          fileNames.add(f);
        }
      });
      noticeDate.text = headingDateFormat.format(DateTime.parse(notice.date));
      pickedNoticeDate = dateFormat.format(DateTime.parse(notice.date));
    } else {
      noticeDate.text = headingDateFormat.format(new DateTime.now());
      pickedNoticeDate = dateFormat.format(new DateTime.now());
    }
    loadDocuments();
  }

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);

    if (image != null) {
      setState(() {
        loading = true;
      });
      Future<String> uploadResponse = upload(image);
      uploadResponse.then((fileName) {
        if (fileName.isNotEmpty) {
          setState(() {
            fileNames.add(fileName);
            loadDocuments();
          });
        }
        setState(() {
          loading = false;
        });
      });
    }
  }

  void loadDocuments() {
    fileWidgets.clear();
    fileNames.forEach((file) {
      if (file.length > 0) {
        fileWidgets.add(new Row(
          children: <Widget>[
            new IconButton(
              icon: FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholderimage.png',
                image: mediaURL + file,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new PhotoActivity(mediaURL + file)),
                );
              },
            ),
            new Expanded(
              child: new IconButton(
                onPressed: () {
                  setState(() {
                    fileNames.remove(file);
                    loadDocuments();
                  });
                },
                icon: new Icon(Icons.delete),
              ),
            )
          ],
        ));
      }
    });
    if (fileNames.length == 0) {
      fileWidgets.add(new Row(
        children: <Widget>[
          new Expanded(
            child: new FlatButton(
              onPressed: () {
                Future<Admins> statusResponse =
                    getStatus({"hostel_id": hostelID});
                statusResponse.then((response) {
                  if (response != null) {
                    if (response.meta.status != STATUS_403) {
                      selectPhoto(context);
                    } else {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new ProActivity()),
                      );
                    }
                  }
                });
              },
              child: new Text("Add Document"),
            ),
          )
        ],
      ));
    }
  }

  Future _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().subtract(new Duration(days: 365)),
        lastDate: new DateTime.now().add(new Duration(days: 365)));
    if (picked != null)
      setState(() {
        noticeDate.text = headingDateFormat.format(picked);
        pickedNoticeDate = dateFormat.format(picked);
      });
  }

  Future<String> selectPhoto(BuildContext context) async {
    String returned = "";

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Container(
            width: MediaQuery.of(context).size.width,
            child: new ListView(
              shrinkWrap: true,
              children: <Widget>[
                new FlatButton(
                  child: new Text("Camera"),
                  onPressed: () {
                    getImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("Gallery"),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                    Navigator.of(context).pop();
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
          "Notice",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 4.0,
        actions: <Widget>[
          new MaterialButton(
            textColor: Colors.white,
            child: new Text(
              notice != null ? "SAVE" : "ADD",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
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
                  if (title.text.length == 0) {
                    setState(() {
                      titleCheck = true;
                      loading = false;
                    });
                    return;
                  } else {
                    setState(() {
                      titleCheck = false;
                    });
                  }

                  Future<bool> load;
                  if (notice != null) {
                    load = update(
                      API.NOTICE,
                      Map.from({
                        'title': title.text,
                        'description': description.text,
                        'date': pickedNoticeDate,
                        'img': fileNames.join(","),
                      }),
                      Map.from({'hostel_id': hostelID, 'id': notice.id}),
                    );
                  } else {
                    load = add(
                      API.NOTICE,
                      Map.from({
                        'hostel_id': hostelID,
                        'title': title.text,
                        'description': description.text,
                        'date': pickedNoticeDate,
                        'img': fileNames.join(","),
                      }),
                    );
                  }
                  load.then((onValue) {
                    setState(() {
                      loading = false;
                    });
                    if (onValue) {
                      if (notice != null) {
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
      body: ModalProgressHUD(
        child: new Container(
          margin: new EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.1,
              25,
              MediaQuery.of(context).size.width * 0.1,
              0),
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              new Container(
                height: titleCheck ? null : 50,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new Container(
                        child: new TextField(
                          controller: title,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            suffixIcon: titleCheck
                                ? IconButton(
                                    icon: Icon(Icons.error, color: Colors.red),
                                    onPressed: () {},
                                  )
                                : null,
                            errorText: titleCheck ? "Title required" : null,
                            isDense: true,
                            prefixIcon: Icon(Icons.attach_money),
                            border: OutlineInputBorder(),
                            labelText: 'Title',
                          ),
                          onSubmitted: (String value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new Container(
                        child: new TextField(
                          controller: description,
                          maxLines: 3,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.description),
                            border: OutlineInputBorder(),
                            labelText: 'Description',
                          ),
                          onSubmitted: (String value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new GestureDetector(
                onTap: () {
                  _selectDate(context);
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
                            controller: noticeDate,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              isDense: true,
                              prefixIcon: Icon(Icons.calendar_today),
                              border: OutlineInputBorder(),
                              labelText: 'Notice Date',
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: new Text("Notice Image"),
                    ),
                    new Expanded(
                      child: new Container(
                          margin: new EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: new Column(
                            children: fileWidgets,
                          )),
                    ),
                  ],
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new FlatButton(
                      child: new Text(
                        (notice == null) ? "" : "DELETE",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Future<bool> dialog = twoButtonDialog(
                            context, "Do you want to delete the notice?", "");
                        dialog.then((onValue) {
                          if (onValue) {
                            setState(() {
                              loading = true;
                            });
                            Future<bool> delete = update(
                                API.NOTICE,
                                Map.from({'status': '0'}),
                                Map.from({
                                  'hostel_id': hostelID,
                                  'id': notice.id,
                                }));
                            delete.then((response) {
                              setState(() {
                                loading = false;
                              });
                              Navigator.pop(context, "");
                            });
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        inAsyncCall: loading,
      ),
    );
  }
}
