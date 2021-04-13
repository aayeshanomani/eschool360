import 'package:eschool360/hostel/screens/pro.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import './hostel.dart';
import '../utils/models.dart';
import '../utils/api.dart';
import '../utils/config.dart';
import '../utils/utils.dart';

class HostelsActivity extends StatefulWidget {
  HostelsActivity();

  @override
  HostelsActivityState createState() {
    return new HostelsActivityState();
  }
}

class HostelsActivityState extends State<HostelsActivity> {
  List<Hostel> hostels = new List();

  double width = 0;
  String hostelIDs;

  bool loading = true;

  HostelsActivityState();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() {
    checkInternet().then((internet) {
      if (internet == null || !internet) {
        oneButtonDialog(context, "No Internet connection", "", true);
        return;
      } else {
        setState(() {
          loading = true;
        });
        Future<Admins> adminResponse = getAdmins(Map.from({
          'username': adminName,
          'email': adminEmailID,
        }));
        adminResponse.then((response) {
          if (response == null ||
              response.meta == null ||
              response.meta.status != "200") {
            setState(() {
              loading = false;
            });
          } else {
            if (response.admins.length == 0) {
              setState(() {
                loading = false;
              });
            } else {
              prefs.setString('hostelIDs', response.admins[0].hostels);
              hostelIDs = prefs.getString('hostelIDs');
              print(hostelIDs);
              fillData();
            }
          }
        });
      }
    });
  }

  void fillData() {
    checkInternet().then((internet) {
      if (internet == null || !internet) {
        oneButtonDialog(context, "No Internet connection", "", true);
        setState(() {
          loading = false;
        });
      } else {
        Future<Hostels> data =
            getHostels(Map.from({'id': hostelIDs, 'status': '1'}));
        data.then((response) {
          if (response != null) {
            if (response.hostels != null && response.hostels.length > 0) {
              hostels.addAll(response.hostels);
            }
            if (response.meta != null && response.meta.messageType == "1") {
              oneButtonDialog(context, "", response.meta.message,
                  !(response.meta.status == STATUS_403));
            }
            setState(() {
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
      hostels.clear();
      getUserData();
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
          "Hostels",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          prefs.getString("admin") == "1"
              ? new IconButton(
                  onPressed: () {
                    Future<Admins> statusResponse =
                        getStatus({"hostel_id": hostelID});
                    statusResponse.then((response) {
                      if (response != null) {
                        if (response.meta.status != STATUS_403) {
                          addPage(
                              context,
                              new HostelActivity(
                                  null, false, hostels.length <= 1));
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
                  icon: new Icon(Icons.add),
                )
              : new Container()
        ],
      ),
      body: ModalProgressHUD(
        child: hostels.length == 0
            ? new Center(
                child: new Text(loading ? "" : "No hostels"),
              )
            : new ListView.separated(
                itemCount: hostels.length,
                separatorBuilder: (context, i) {
                  return new Divider();
                },
                itemBuilder: (itemContext, i) {
                  return new GestureDetector(
                    onTap: () {
                      addPage(
                          context,
                          new HostelActivity(
                              hostels[i], false, hostels.length <= 1));
                    },
                    child: new Container(
                      color: Colors.transparent,
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
                                      color: hostels[i].expiryDateTime == "" ||
                                              hostels[i]
                                                  .expiryDateTime
                                                  .contains("0000") ||
                                              DateTime.parse(hostels[i]
                                                          .expiryDateTime)
                                                      .difference(
                                                          DateTime.now())
                                                      .inDays >
                                                  0
                                          ? HexColor(COLORS.GREEN)
                                          : HexColor(COLORS.RED),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: new Text(
                                      hostels[i].name[0].toUpperCase(),
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
                                                hostels[i]
                                                        .name[0]
                                                        .toUpperCase() +
                                                    hostels[i]
                                                        .name
                                                        .substring(1),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                        new Container(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            new Container(
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[],
                                        ),
                                        new SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: new Row(
                                            children: getAmenitiesWidgets(
                                                hostels[i].amenities),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
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
