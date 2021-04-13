import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/config.dart';
import '../utils/utils.dart';
import '../utils/api.dart';

class ProActivity extends StatefulWidget {
  ProActivity();

  @override
  State<StatefulWidget> createState() {
    return new ProActivityState();
  }
}

class ProActivityState extends State<ProActivity> {
  bool loading = false;

  ProActivityState();

  var _razorpay = Razorpay();

  var amount = 0;

  @override
  void initState() {
    super.initState();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      loading = true;
    });
    Future<bool> load = add(
      API.PAYMENT,
      Map.from({
        'admin_id': adminID,
        'payment_id': response.paymentId,
        'order_id': response.paymentId,
        'amount': amount.toString(),
      }),
    );
    load.then((onValue) {
      setState(() {
        loading = false;
      });
      if (onValue != null) {
        Navigator.pop(context);
      } else {
        oneButtonDialog(context, "Network error", "Please contact us", true);
      }
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "Payment Failed. Try Again.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      textColor: Colors.white,
      fontSize: 15.0,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
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
          "Cloud PG PRO",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 4.0,
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
              new SizedBox(
                width: 100,
                height: 100,
                child: new Image.asset('assets/images/hotels.png'),
              ),
              new Container(
                color: Colors.transparent,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Expanded(
                      child: new Text(
                        "Reach further with Eschool360 Hostel PRO",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              new Container(
                color: Colors.transparent,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Expanded(
                      child: new Text(
                        "",
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              new Container(
                height: 20,
              ),
              new Container(
                color: Colors.transparent,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Expanded(
                      child: new Text(
                        "1. Store Bills, Expenses and other documents\n\n2. Filter Bills, Users, Rooms\n\n3. Charts and graphs\n\n4. Manage multiple hostels\n\n5. Multiuser\n\n6. A totally ad-free experience\n\n7. Plus more goodies to come!",
                      ),
                    )
                  ],
                ),
              ),
              new Container(
                height: 40,
              ),
              prefs.getString("admin") == "1"
                  ? new Container(
                      color: Colors.transparent,
                      margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Expanded(
                            child: new Container(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: new Column(
                                children: <Widget>[
                                  new Text(
                                    "1 Month",
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  new Container(
                                    height: 7,
                                  ),
                                  new Text(
                                    "₹ 99.00",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  new Container(
                                    height: 57,
                                  ),
                                  new FlatButton(
                                    color: Colors.blue,
                                    onPressed: () {
                                      amount = 9900;
                                      var options = {
                                        "key": RAZORPAY.KEY,
                                        "amount": 9900,
                                        "name": "Cloud PG PRO",
                                        "description": "1 Month Subscription",
                                        "payment_capture": "1",
                                        "prefill": {
                                          "email": adminEmailID,
                                        }
                                      };
                                      _razorpay.open(options);
                                    },
                                    child: new Text(
                                      "Go PRO",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new Container(width: 30),
                          new Expanded(
                            child: new Container(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: new Column(
                                children: <Widget>[
                                  new Text(
                                    "6 Months",
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  new Container(
                                    height: 7,
                                  ),
                                  new Text(
                                    "₹ 499.00",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  new Container(
                                    height: 10,
                                  ),
                                  new Text(
                                    "20% OFF",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.red,
                                    ),
                                  ),
                                  new Container(
                                    height: 30,
                                  ),
                                  new FlatButton(
                                    color: Colors.blue,
                                    onPressed: () {
                                      amount = 49900;
                                      var options = {
                                        "key": RAZORPAY.KEY,
                                        "amount": 49900,
                                        "name": "Cloud PG PRO",
                                        "description": "6 Month Subscription",
                                        "payment_capture": "1",
                                        "prefill": {
                                          "email": adminEmailID,
                                        }
                                      };
                                      _razorpay.open(options);
                                    },
                                    child: new Text(
                                      "Go PRO",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
