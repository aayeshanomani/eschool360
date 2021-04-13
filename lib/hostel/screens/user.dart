import 'package:eschool360/hostel/screens/pro.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../utils/utils.dart';
import '../utils/api.dart';
import '../utils/config.dart';
import '../utils/models.dart';
import './photo.dart';

class UserActivity extends StatefulWidget {
  final User user;
  final Room room;

  UserActivity(this.user, this.room);

  @override
  State<StatefulWidget> createState() {
    return new UserActivityState(user, room);
  }
}

class UserActivityState extends State<UserActivity> {
  int eating = 0;

  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController emergencyName = new TextEditingController();
  TextEditingController emergencyPhone = new TextEditingController();
  TextEditingController rent = new TextEditingController();
  TextEditingController advance = new TextEditingController();
  TextEditingController joiningDate = new TextEditingController();
  TextEditingController roomNo = new TextEditingController();

  String pickedJoiningDate = '';

  User user;
  Room room;

  String roomID;

  bool loading = false;
  List<String> fileNames = new List();
  List<Widget> fileWidgets = new List();
  List<Room> rooms = new List();

  UserActivityState(this.user, this.room);

  bool nameCheck = false;

  @override
  void initState() {
    super.initState();
    joiningDate.text =
        headingDateFormat.format(new DateTime.now().add(new Duration(days: 5)));
    pickedJoiningDate =
        dateFormat.format(new DateTime.now().add(new Duration(days: 5)));
    if (user != null) {
      name.text = user.name;
      phone.text = user.phone;
      email.text = user.email;
      address.text = user.address;
      emergencyName.text = user.emerContact;
      emergencyPhone.text = user.emerPhone;
      rent.text = user.rent;
      eating = int.parse(user.food);
      joiningDate.text =
          headingDateFormat.format(DateTime.parse(user.joiningDateTime));
      pickedJoiningDate =
          dateFormat.format(DateTime.parse(user.joiningDateTime));
      if (user.document != null) {
        fileNames = user.document.split(",");
      }
      roomID = user.roomID;
    } else if (room != null) {
      roomID = room.id;
      roomNo.text = room.roomno;
      rent.text = room.rent;
    } else {
      roomID = "";
      roomNo.text = "";
      rent.text = "";
    }
    loadDocuments();
    getRoomsIDs();
  }

  void getRoomsIDs() {
    checkInternet().then((internet) {
      if (internet == null || !internet) {
        oneButtonDialog(context, "No Internet connection", "", true);
        setState(() {
          loading = false;
        });
      } else {
        setState(() {
          loading = true;
        });
        Map<String, String> filter = new Map();
        filter["limit"] = "10000";
        filter["hostel_id"] = hostelID;
        filter["status"] = "1";
        filter["resp"] = "roomno,id,rent";
        Future<Rooms> data = getRooms(filter);
        data.then((response) {
          if (response != null) {
            if (response.rooms != null) {
              rooms.addAll(response.rooms);
            }
            rooms.forEach((room) {
              if (room.id == roomID) {
                roomNo.text = room.roomno;
              }
            });
            if (response.meta == null) {
              oneButtonDialog(context, "", "No Internet connection", true);
            } else if (response.meta != null &&
                response.meta.messageType == "1") {
              oneButtonDialog(context, "", response.meta.message,
                  !(response.meta.status == STATUS_403));
            }
            setState(() {
              loading = false;
            });
          } else {
            new Timer(Duration(milliseconds: random.nextInt(5) * 1000), () {
              setState(() {
                getRoomsIDs();
              });
            });
          }
        });
      }
    });
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

  Future _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now().add(new Duration(days: 5)),
        firstDate: new DateTime.now().subtract(new Duration(days: 365)),
        lastDate: new DateTime.now().add(new Duration(days: 365)));
    if (picked != null)
      setState(() {
        if (headingDateFormat.format(new DateTime.now()) ==
            headingDateFormat.format(picked)) {
          joiningDate.text = "Joining Today";
        } else {
          joiningDate.text = headingDateFormat.format(picked);
        }
        pickedJoiningDate = dateFormat.format(picked);
      });
  }

  Future<String> selectRoom(BuildContext context, List<Room> rooms) async {
    String returned = "";

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Select room"),
          content: new Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: rooms.length,
              itemBuilder: (context, i) {
                return new FlatButton(
                  child: new Text(rooms[i].roomno),
                  onPressed: () {
                    Navigator.of(context).pop();
                    returned = rooms[i].id;

                    roomID = rooms[i].id;
                    roomNo.text = rooms[i].roomno;

                    setState(() {
                      rent.text = rooms[i].rent;
                    });
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
        title: room != null
            ? new Text(
                room.roomno,
                style: TextStyle(color: Colors.black),
              )
            : new Text(
                "User",
                style: TextStyle(color: Colors.black),
              ),
        elevation: 4.0,
        actions: <Widget>[
          new MaterialButton(
            textColor: Colors.white,
            child: user != null
                ? new Text(
                    "SAVE",
                    style: TextStyle(color: Colors.black),
                  )
                : new Text(
                    "ADD",
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
                  if (name.text.length == 0) {
                    setState(() {
                      nameCheck = true;
                      loading = false;
                    });
                    return;
                  } else {
                    setState(() {
                      nameCheck = false;
                    });
                  }

                  Future<bool> load;
                  if (user != null) {
                    load = update(
                      API.USER,
                      Map.from({
                        'name': name.text,
                        'phone': phone.text,
                        'email': email.text,
                        'address': address.text,
                        'emer_contact': emergencyName.text,
                        'emer_phone': emergencyPhone.text,
                        'food': eating.toString(),
                        'rent': rent.text,
                        'document': fileNames.join(","),
                        'room_id': roomID,
                        'prev_room_id': user.roomID,
                        'joining_date_time': pickedJoiningDate,
                      }),
                      Map.from({'hostel_id': hostelID, 'id': user.id}),
                    );
                  } else {
                    Map<String, String> data = {
                      'hostel_id': hostelID,
                      'name': name.text,
                      'phone': phone.text,
                      'email': email.text,
                      'address': address.text,
                      'emer_contact': emergencyName.text,
                      'emer_phone': emergencyPhone.text,
                      'food': eating.toString(),
                      'room_id': roomID,
                      'rent': rent.text,
                      'document': fileNames.join(","),
                      'joining_date_time': pickedJoiningDate,
                      'expiry_date_time': dateFormat.format(
                          new DateTime.now().add(new Duration(days: 30))),
                    };
                    if (DateTime.parse(pickedJoiningDate)
                            .difference(DateTime.now())
                            .inDays >
                        0) {
                      data["joining"] = "1";
                    }
                    load = add(
                      API.USER,
                      Map.from(data),
                    );
                  }
                  load.then((onValue) {
                    setState(() {
                      loading = false;
                    });
                    if (onValue != null) {
                      if (user != null) {
                        Navigator.pop(context, "");
                      } else {
                        new Timer(const Duration(milliseconds: 1000), () {
                          Future<Users> data = getUsers({
                            'hostel_id': hostelID,
                            'name': name.text,
                            'phone': phone.text,
                            'email': email.text,
                            'food': eating.toString(),
                            'room_id': roomID,
                          });
                          data.then((response) {
                            if (response.users != null &&
                                response.users.length > 0) {
                              if (DateTime.parse(pickedJoiningDate)
                                      .difference(DateTime.now())
                                      .inDays >
                                  0) {
                                update(
                                  API.USERBOOK,
                                  Map.from({
                                    "joining_date_time": pickedJoiningDate,
                                  }),
                                  Map.from({
                                    'hostel_id': hostelID,
                                    'id': response.users[0].id,
                                    'room_id': response.users[0].roomID
                                  }),
                                );
                              }

                              if (advance.text.length > 0) {
                                add(
                                  API.BILL,
                                  Map.from({
                                    'hostel_id': hostelID,
                                    'title': "Advance/Token Amount",
                                    'paid_date_time':
                                        dateFormat.format(new DateTime.now()),
                                    'description': response.users[0].name +
                                        ' paid advance/token amount',
                                    'amount': advance.text,
                                    'document': '',
                                    'type': '8', // others
                                    'user_id': response.users[0].id,
                                    'paid': '0'
                                  }),
                                );
                              }
                            }
                          });

                          Navigator.pop(context, "");
                        });
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
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Container(
                      height: nameCheck ? null : 50,
                      child: new TextField(
                          controller: name,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            suffixIcon: nameCheck
                                ? IconButton(
                                    icon: Icon(Icons.error, color: Colors.red),
                                    onPressed: () {},
                                  )
                                : null,
                            errorText: nameCheck ? "Name required" : null,
                            isDense: true,
                            prefixIcon: Icon(Icons.account_circle),
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                          ),
                          onSubmitted: (String value) {}),
                    ),
                  ),
                ],
              ),
              new GestureDetector(
                onTap: () {
                  selectRoom(context, rooms);
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
                            controller: roomNo,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              isDense: true,
                              prefixIcon: Icon(Icons.room),
                              border: OutlineInputBorder(),
                              labelText: 'Room No.',
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
                height: 50,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        child: new TextField(
                          controller: rent,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.attach_money),
                            border: OutlineInputBorder(),
                            labelText: 'Rent',
                          ),
                          onSubmitted: (String value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              user == null
                  ? new Container(
                      height: 50,
                      margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Expanded(
                            child: new Container(
                              child: new TextField(
                                controller: advance,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  isDense: true,
                                  prefixIcon: Icon(Icons.attach_money),
                                  border: OutlineInputBorder(),
                                  labelText: 'Advance/Token Amount',
                                ),
                                onSubmitted: (String value) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : new Container(),
              (user == null || user.joining == "1")
                  ? new GestureDetector(
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
                                  controller: joiningDate,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    prefixIcon: Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(),
                                    labelText: 'Joining Date',
                                  ),
                                  onSubmitted: (String value) {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : new Container(),
              new Container(
                height: 50,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        child: new TextField(
                          controller: phone,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                            labelText: 'Phone',
                          ),
                          onSubmitted: (String value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                height: 50,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        child: new TextField(
                          controller: email,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                          onSubmitted: (String value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                // height: 50,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        child: new TextField(
                          controller: address,
                          maxLines: 5,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.location_on),
                            border: OutlineInputBorder(),
                            labelText: 'Address',
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
                    new Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: new Text("Document"),
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
                height: 50,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        child: new TextField(
                          controller: emergencyName,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.account_circle),
                            border: OutlineInputBorder(),
                            labelText: 'Emergency Contact Name',
                          ),
                          onSubmitted: (String value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                height: 50,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        child: new TextField(
                          controller: emergencyPhone,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.contact_phone),
                            border: OutlineInputBorder(),
                            labelText: 'Emergency Contact Number',
                          ),
                          onSubmitted: (String value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Radio(
                      value: 0,
                      groupValue: eating,
                      onChanged: (value) {
                        setState(() {
                          eating = value;
                        });
                      },
                    ),
                    new GestureDetector(
                      onTap: () {
                        setState(() {
                          eating = 0;
                        });
                      },
                      child: new Text("Veg"),
                    ),
                    new Radio(
                      value: 1,
                      groupValue: eating,
                      onChanged: (value) {
                        setState(() {
                          eating = value;
                        });
                      },
                    ),
                    new GestureDetector(
                      onTap: () {
                        setState(() {
                          eating = 1;
                        });
                      },
                      child: new Text("Non Veg"),
                    ),
                    new Radio(
                      value: 2,
                      groupValue: eating,
                      onChanged: (value) {
                        setState(() {
                          eating = value;
                        });
                      },
                    ),
                    new GestureDetector(
                      onTap: () {
                        setState(() {
                          eating = 2;
                        });
                      },
                      child: new Text("None"),
                    ),
                  ],
                ),
              ),
              user != null
                  ? new Container(
                      margin: new EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new FlatButton(
                            child: new Text(
                              "REMOVE",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              Future<bool> dialog = twoButtonDialog(
                                  context,
                                  "Do you want to remove the user from hostel?",
                                  "");
                              dialog.then((onValue) {
                                if (onValue) {
                                  setState(() {
                                    loading = true;
                                  });
                                  Future<bool> deleteResquest = delete(
                                      API.USER,
                                      Map.from({
                                        'hostel_id': hostelID,
                                        'id': user.id,
                                        'room_id': user.roomID,
                                        'vacating': user.vacating,
                                        'joining': user.joining,
                                      }));
                                  deleteResquest.then((response) {
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
                    )
                  : new Container(),
            ],
          ),
        ),
        inAsyncCall: loading,
      ),
    );
  }
}
