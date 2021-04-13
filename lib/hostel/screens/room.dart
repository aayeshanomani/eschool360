import 'package:flutter/material.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../utils/api.dart';
import '../utils/config.dart';
import '../utils/models.dart';
import '../utils/utils.dart';

class RoomActivity extends StatefulWidget {
  final Room room;

  RoomActivity(this.room);
  @override
  State<StatefulWidget> createState() {
    return new RoomActivityState(room);
  }
}

class RoomActivityState extends State<RoomActivity> {
  TextEditingController roomno = new TextEditingController();
  TextEditingController rent = new TextEditingController();
  TextEditingController capacity = new TextEditingController();

  Room room;

  Map<String, bool> avaiableAmenities = new Map<String, bool>();

  bool loading = false;

  RoomActivityState(this.room);

  bool roomnoCheck = false;
  bool rentCheck = false;
  bool capacityCheck = false;

  @override
  void initState() {
    super.initState();
    print(amenities);
    amenities.forEach((amenity) =>
        amenity.length > 0 ? avaiableAmenities[amenity] = false : null);
    if (room != null) {
      roomno.text = room.roomno;
      rent.text = room.rent;
      capacity.text = room.capacity;
      if (room.amenities != null) {
        room.amenities.split(",").forEach((amenity) =>
            amenity.length > 0 ? avaiableAmenities[amenity] = true : null);
      }
    }
    print(avaiableAmenities);
  }

  List<Widget> amenitiesWidget() {
    List<Widget> widgets = new List();
    avaiableAmenities.forEach((k, v) => widgets.add(new GestureDetector(
          onTap: () {
            setState(() {
              avaiableAmenities[k] = !avaiableAmenities[k];
            });
          },
          child: new Row(
            children: <Widget>[
              new Checkbox(
                value: v,
                onChanged: (bool value) {
                  setState(() {
                    avaiableAmenities[k] = value;
                  });
                },
              ),
              new Text(getAmenityName(k))
            ],
          ),
        )));
    return widgets;
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
          "Room",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 4.0,
        actions: <Widget>[
          new MaterialButton(
            textColor: Colors.white,
            child: room != null
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
                  if (roomno.text.length == 0) {
                    setState(() {
                      roomnoCheck = true;
                      loading = false;
                    });
                    return;
                  } else {
                    setState(() {
                      roomnoCheck = false;
                    });
                  }

                  if (capacity.text.length == 0) {
                    setState(() {
                      capacityCheck = true;
                      loading = false;
                    });
                    return;
                  } else {
                    setState(() {
                      capacityCheck = false;
                    });
                  }

                  if (rent.text.length == 0) {
                    setState(() {
                      rentCheck = true;
                      loading = false;
                    });
                    return;
                  } else {
                    setState(() {
                      rentCheck = false;
                    });
                  }

                  List<String> savedAmenities = new List();
                  avaiableAmenities.forEach((k, v) {
                    if (v) {
                      savedAmenities.add(k);
                    }
                  });
                  Future<bool> load;
                  if (room != null) {
                    load = update(
                      API.ROOM,
                      Map.from({
                        'roomno': roomno.text,
                        "rent": rent.text,
                        "capacity": capacity.text,
                        "amenities": savedAmenities.length > 0
                            ? "," + savedAmenities.join(",") + ","
                            : ""
                      }),
                      Map.from({'hostel_id': hostelID, 'id': room.id}),
                    );
                  } else {
                    load = add(
                      API.ROOM,
                      Map.from({
                        'hostel_id': hostelID,
                        'roomno': roomno.text,
                        'rent': rent.text,
                        'capacity': capacity.text,
                        'filled': "0",
                        "amenities": savedAmenities.length > 0
                            ? "," + savedAmenities.join(",") + ","
                            : ""
                      }),
                    );
                  }
                  load.then((onValue) {
                    setState(() {
                      loading = false;
                    });
                    if (onValue != null) {
                      if (room != null) {
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
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Container(
                      height: roomnoCheck ? null : 50,
                      child: new TextField(
                        controller: roomno,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: roomnoCheck
                              ? IconButton(
                                  icon: Icon(Icons.error, color: Colors.red),
                                  onPressed: () {},
                                )
                              : null,
                          errorText: roomnoCheck ? "Room No. required" : null,
                          isDense: true,
                          prefixIcon: Icon(Icons.hotel),
                          border: OutlineInputBorder(),
                          labelText: 'Room No.',
                        ),
                        onSubmitted: (String value) {},
                      ),
                    ),
                  ),
                ],
              ),
              new Container(
                height: capacityCheck ? null : 50,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Flexible(
                      child: new Container(
                        child: new TextField(
                          controller: capacity,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffixIcon: capacityCheck
                                ? IconButton(
                                    icon: Icon(Icons.error, color: Colors.red),
                                    onPressed: () {},
                                  )
                                : null,
                            errorText:
                                capacityCheck ? "Capacity required" : null,
                            isDense: true,
                            prefixIcon: Icon(Icons.group),
                            border: OutlineInputBorder(),
                            labelText: 'Capacity',
                          ),
                          onSubmitted: (String value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                height: rentCheck ? null : 50,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new Container(
                        child: new TextField(
                          controller: rent,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffixIcon: rentCheck
                                ? IconButton(
                                    icon: Icon(Icons.error, color: Colors.red),
                                    onPressed: () {},
                                  )
                                : null,
                            errorText: rentCheck ? "Rent required" : null,
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
              new Container(
                margin: new EdgeInsets.fromLTRB(0, 10, 0, 0),
              ),
              new Expanded(
                child: new GridView.count(
                    childAspectRatio: 3,
                    primary: false,
                    crossAxisCount: 2,
                    children: amenitiesWidget()),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new FlatButton(
                      child: new Text(
                        (room == null || room.filled != "0") ? "" : "DELETE",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Future<bool> dialog = twoButtonDialog(
                            context, "Do you want to delete the room?", "");
                        dialog.then((onValue) {
                          if (onValue) {
                            setState(() {
                              loading = true;
                            });
                            Future<bool> delete = update(
                                API.ROOM,
                                Map.from({'status': '0'}),
                                Map.from({
                                  'hostel_id': hostelID,
                                  'id': room.id,
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
