import 'package:flutter/material.dart';
import 'dart:async';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../utils/utils.dart';

import '../utils/models.dart';
import '../utils/api.dart';
import '../utils/config.dart';

class InvoicesActivity extends StatefulWidget {
  InvoicesActivity();
  @override
  InvoicesActivityState createState() {
    return new InvoicesActivityState();
  }
}

class InvoicesActivityState extends State<InvoicesActivity> {
  InvoicesActivityState();

  Map<String, String> filter = new Map();

  List<Invoice> invoices = new List();
  bool end = false;
  bool ongoing = false;

  double width = 0;

  String offset = defaultOffset;
  bool loading = true;

  ScrollController _controller;

  @override
  void initState() {
    super.initState();

    filter["status"] = "1";
    filter["admin_id"] = adminID;
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

// HeadingItem(previousDate)
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
        Future<Invoices> data = getInvoices(filter);
        data.then((response) {
          if (response != null) {
            if (response.invoices != null && response.invoices.length > 0) {
              offset = (int.parse(response.pagination.offset) +
                      response.invoices.length)
                  .toString();
              invoices.addAll(response.invoices);
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
          "Subscriptions",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ModalProgressHUD(
        child: invoices.length == 0
            ? new Center(
                child: new Text(loading ? "" : "No subscriptions"),
              )
            : new ListView.builder(
                controller: _controller,
                itemCount: invoices.length,
                itemBuilder: (context, i) {
                  final item = invoices[i];
                  return new ListTile(
                    dense: true,
                    onTap: () {
                      // addPage(
                      //     context,
                      //     new InvoiceActivity(
                      //         invoices[i], null, null, false));
                    },
                    title: new Container(
                      margin: EdgeInsets.only(top: i == 0 ? 10 : 0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                              padding: EdgeInsets.all(7),
                              color: HexColor(COLORS.RED),
                              child: new Icon(
                                Icons.receipt,
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
                                        headingDateFormat.format(DateTime.parse(
                                            item.createdDateTime)),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    new Text(
                                      "₹" + (int.parse(item.amount)/100).toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                item.description.length > 0
                                    ? new Container(
                                        width: width * 0.7,
                                        child: new Text(
                                          item.description,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w100,
                                              color: Colors.grey),
                                        ),
                                      )
                                    : new Container(),
                                new Container(
                                  width: width * 0.7,
                                  child: new Text(
                                    "Invoice ID - " + item.id,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                new Container(
                                  width: width * 0.7,
                                  child: new Text(
                                    "Payment ID - " + item.paymentID,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontSize: 12,
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
                },
              ),
        inAsyncCall: loading,
      ),
    );
  }
}
