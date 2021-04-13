import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../utils/api.dart';
import '../utils/config.dart';
import '../utils/models.dart';
import '../utils/utils.dart';
import './photo.dart';
import 'pro.dart';

class BillActivity extends StatefulWidget {
  final Bill bill;
  final User user;
  final Employee employee;
  final bool advance;

  BillActivity(this.bill, this.user, this.employee, this.advance);

  @override
  State<StatefulWidget> createState() {
    return new BillActivityState(bill, user, employee, advance);
  }
}

class BillActivityState extends State<BillActivity> {
  int paid = 1;

  TextEditingController type = new TextEditingController();
  TextEditingController payment = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController transactionID = new TextEditingController();
  TextEditingController billID = new TextEditingController();
  TextEditingController amount = new TextEditingController();
  TextEditingController paidDate = new TextEditingController();
  TextEditingController expiryDate = new TextEditingController();

  String pickedPaidDate = '';
  String pickedExpiryDate = '';

  Bill bill;
  User user;
  Employee employee;
  bool advance;

  bool loading = false;
  List<String> fileNames = new List();
  List<Widget> fileWidgets = new List();

  BillActivityState(this.bill, this.user, this.employee, this.advance);

  bool amountCheck = false;

  String selectedType = "0";
  String selectedPayment = "0";

  @override
  void initState() {
    super.initState();
    expiryDate.text = headingDateFormat
        .format(new DateTime.now().add(new Duration(days: 30)));
    pickedExpiryDate =
        dateFormat.format(new DateTime.now().add(new Duration(days: 30)));
    selectedType = "8";
    selectedPayment = "4";
    type.text = getBillType(selectedType);
    payment.text = getPaymentType(selectedPayment);
    if (user != null) {
      amount.text = user.rent;
      paidDate.text = headingDateFormat.format(new DateTime.now());
      pickedPaidDate = dateFormat.format(new DateTime.now());
      if (bill != null) {
        if (bill.document != null) {
          fileNames = bill.document.split(",");
        }
        if (bill.type != null) {
          selectedType = bill.type;
          type.text = getBillType(bill.type);
        }
        if (bill.payment != null) {
          selectedPayment = bill.payment;
          payment.text = getPaymentType(bill.payment);
        }
        if (bill.transactionID != null) {
          transactionID.text = bill.transactionID;
        }
        if (bill.billID != null) {
          billID.text = bill.billID;
        }
        amount.text = bill.amount;
        paidDate.text =
            headingDateFormat.format(DateTime.parse(bill.paidDateTime));
        pickedPaidDate = dateFormat.format(DateTime.parse(bill.paidDateTime));
      }
    } else if (employee != null) {
      amount.text = employee.salary;
      paidDate.text = headingDateFormat.format(new DateTime.now());
      pickedPaidDate = dateFormat.format(new DateTime.now());
      dateFormat.format(new DateTime.now());
      if (bill != null) {
        if (bill.document != null) {
          fileNames = bill.document.split(",");
        }
        if (bill.type != null) {
          selectedType = bill.type;
          type.text = getBillType(bill.type);
        }
        if (bill.payment != null) {
          selectedPayment = bill.payment;
          payment.text = getPaymentType(bill.payment);
        }
        if (bill.transactionID != null) {
          transactionID.text = bill.transactionID;
        }
        if (bill.billID != null) {
          billID.text = bill.billID;
        }
        amount.text = bill.amount;
        paidDate.text =
            headingDateFormat.format(DateTime.parse(bill.paidDateTime));
        pickedPaidDate = dateFormat.format(DateTime.parse(bill.paidDateTime));
      }
    } else if (bill != null) {
      if (bill.document != null) {
        fileNames = bill.document.split(",");
      }
      if (bill.type != null) {
        selectedType = bill.type;
        type.text = getBillType(bill.type);
      }
      if (bill.payment != null) {
        selectedPayment = bill.payment;
        payment.text = getPaymentType(bill.payment);
      }
      if (bill.transactionID != null) {
        transactionID.text = bill.transactionID;
      }
      if (bill.billID != null) {
        billID.text = bill.billID;
      }
      paidDate.text =
          headingDateFormat.format(DateTime.parse(bill.paidDateTime));
      pickedPaidDate = dateFormat.format(DateTime.parse(bill.paidDateTime));
      description.text = bill.description;
      amount.text = bill.amount;
      paid = int.parse(bill.paid);
    } else {
      paidDate.text = headingDateFormat.format(new DateTime.now());
      pickedPaidDate = dateFormat.format(new DateTime.now());
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

  Future _selectDate(BuildContext context, String type) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().subtract(new Duration(days: 365)),
        lastDate: new DateTime.now().add(new Duration(days: 365)));
    if (picked != null)
      setState(() {
        if (type == '1') {
          paidDate.text = headingDateFormat.format(picked);
          pickedPaidDate = dateFormat.format(picked);
        } else {
          expiryDate.text = headingDateFormat.format(picked);
          pickedExpiryDate = dateFormat.format(picked);
        }
      });
  }

  Future<String> selectTitle(BuildContext context) async {
    String returned = "";

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Select Expense Type"),
          content: new Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: billTypes.length,
              itemBuilder: (context, i) {
                return new FlatButton(
                  child: new Text(billTypes[i][0]),
                  onPressed: () {
                    returned = billTypes[i][1];
                    type.text = billTypes[i][0];
                    selectedType = billTypes[i][1];
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

  Future<String> selectPayment(BuildContext context) async {
    String returned = "";

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Select Payment Mode"),
          content: new Container(
            width: MediaQuery.of(context).size.width,
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: paymentTypes.length,
              itemBuilder: (context, i) {
                return new FlatButton(
                  child: new Text(paymentTypes[i][0]),
                  onPressed: () {
                    returned = paymentTypes[i][1];
                    payment.text = paymentTypes[i][0];
                    selectedPayment = paymentTypes[i][1];
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
          user != null
              ? (advance ? "Advance/Token Amount" : "Rent")
              : (employee != null ? "Salary" : "Bill"),
          style: TextStyle(color: Colors.black),
        ),
        elevation: 4.0,
        actions: <Widget>[
          new MaterialButton(
            textColor: Colors.white,
            child: new Text(
              bill != null
                  ? "SAVE"
                  : (user != null
                      ? "RECEIVE"
                      : (employee != null ? "PAY" : "ADD")),
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
                  if (amount.text.length == 0) {
                    setState(() {
                      amountCheck = true;
                      loading = false;
                    });
                    return;
                  } else {
                    setState(() {
                      amountCheck = false;
                    });
                  }

                  Future<bool> load;
                  if (user != null) {
                    if (advance) {
                      load = add(
                        API.BILL,
                        Map.from({
                          'hostel_id': hostelID,
                          'title': "Advance/Token Amount",
                          'paid_date_time': pickedPaidDate,
                          'description':
                              user.name + ' paid advance/token amount',
                          'amount': amount.text,
                          'document': fileNames.join(","),
                          'type': selectedType,
                          'user_id': user.id,
                          'paid': '0',
                          'payment': selectedPayment,
                          'transaction_id': transactionID.text,
                          'billid': billID.text,
                        }),
                      );
                    } else {
                      load = add(
                        API.RENT,
                        Map.from({
                          'paid_date_time': pickedPaidDate,
                          'expiry_date_time': pickedExpiryDate,
                          'amount': amount.text,
                          'title': 'Rent',
                          'name': user.name,
                          'description': user.name + ' paid rent',
                          'hostel_id': hostelID,
                          'document': fileNames.join(","),
                          'type': selectedType,
                          'user_id': user.id,
                          'bill_id': bill != null ? bill.id : "",
                          'paid': '0',
                          'joining': user.joining,
                          'room_id': user.roomID,
                          'payment': selectedPayment,
                          'transaction_id': transactionID.text,
                          'billid': billID.text,
                        }),
                      );
                    }
                  } else if (employee != null) {
                    load = add(
                      API.SALARY,
                      Map.from({
                        'paid_date_time': pickedPaidDate,
                        'expiry_date_time': pickedExpiryDate,
                        'amount': amount.text,
                        'title': 'Salary',
                        'name': employee.name,
                        'description': employee.name + ' salary paid',
                        'hostel_id': hostelID,
                        'document': fileNames.join(","),
                        'type': selectedType,
                        'employee_id': employee.id,
                        'bill_id': bill != null ? bill.id : "",
                        'paid': '1',
                        'payment': selectedPayment,
                        'transaction_id': transactionID.text,
                        'billid': billID.text,
                      }),
                    );
                  } else if (bill != null) {
                    load = update(
                      API.BILL,
                      Map.from({
                        'paid_date_time': pickedPaidDate,
                        "title": (bill.userID == "" && bill.employeeID == "")
                            ? type.text
                            : bill.title,
                        "description":
                            (bill.userID == "" && bill.employeeID == "")
                                ? description.text
                                : bill.description,
                        "amount": amount.text,
                        'document': fileNames.join(","),
                        'type': (bill.userID == "" && bill.employeeID == "")
                            ? selectedType
                            : bill.type,
                        'payment': selectedPayment,
                        "paid": paid.toString(),
                        'transaction_id': transactionID.text,
                        'billid': billID.text,
                      }),
                      Map.from({'hostel_id': hostelID, 'id': bill.id}),
                    );
                  } else {
                    load = add(
                      API.BILL,
                      Map.from({
                        'hostel_id': hostelID,
                        'title': type.text,
                        'paid_date_time': pickedPaidDate,
                        'description': description.text,
                        'amount': amount.text,
                        'document': fileNames.join(","),
                        'type': selectedType,
                        'payment': selectedPayment,
                        'paid': paid.toString(),
                        'transaction_id': transactionID.text,
                        'billid': billID.text,
                      }),
                    );
                  }
                  load.then((onValue) {
                    setState(() {
                      loading = false;
                    });
                    if (onValue != null) {
                      if (bill != null) {
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
              (bill == null
                      ? (user == null && employee == null)
                      : (bill.userID == "" && bill.employeeID == ""))
                  ? new GestureDetector(
                      onTap: () {
                        selectTitle(context);
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
                                  controller: type,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    prefixIcon: Icon(Icons.label),
                                    border: OutlineInputBorder(),
                                    labelText: 'Expense Type',
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
              (bill == null
                      ? (user == null && employee == null)
                      : (bill.userID == "" && bill.employeeID == ""))
                  ? new Container(
                      height: 50,
                      margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Flexible(
                            child: new Container(
                              child: new TextField(
                                controller: description,
                                maxLines: 5,
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
                    )
                  : new Container(),
              new Container(
                height: amountCheck ? null : 50,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new Container(
                        child: new TextField(
                          controller: amount,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffixIcon: amountCheck
                                ? IconButton(
                                    icon: Icon(Icons.error, color: Colors.red),
                                    onPressed: () {},
                                  )
                                : null,
                            errorText: amountCheck ? "Amount required" : null,
                            isDense: true,
                            prefixIcon: Icon(Icons.attach_money),
                            border: OutlineInputBorder(),
                            labelText: 'Amount',
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
                    new Flexible(
                      child: new Container(
                        child: new TextField(
                          controller: billID,
                          maxLines: 5,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.receipt),
                            border: OutlineInputBorder(),
                            labelText: 'Bill ID',
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
                  selectPayment(context);
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
                            controller: payment,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              isDense: true,
                              prefixIcon: Icon(Icons.label),
                              border: OutlineInputBorder(),
                              labelText: 'Payment Mode',
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Flexible(
                      child: new Container(
                        child: new TextField(
                          controller: transactionID,
                          maxLines: 5,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.receipt),
                            border: OutlineInputBorder(),
                            labelText: 'Transaction ID',
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
                  _selectDate(context, '1');
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
                            controller: paidDate,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              isDense: true,
                              prefixIcon: Icon(Icons.calendar_today),
                              border: OutlineInputBorder(),
                              labelText: 'Payment Date',
                            ),
                            onSubmitted: (String value) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              (bill == null && (user != null || employee != null))
                  ? new GestureDetector(
                      onTap: () {
                        _selectDate(context, '2');
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
                                  controller: expiryDate,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    prefixIcon: Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(),
                                    labelText: 'Next Payment Date',
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
              (bill == null
                      ? (user == null && employee == null)
                      : (bill.userID == "" && bill.employeeID == ""))
                  ? new Container(
                      margin: new EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio(
                            value: 1,
                            groupValue: paid,
                            onChanged: (value) {
                              setState(() {
                                paid = value;
                              });
                            },
                          ),
                          new GestureDetector(
                            onTap: () {
                              setState(() {
                                paid = 1;
                              });
                            },
                            child: new Text("Paid"),
                          ),
                          new Radio(
                            value: 0,
                            groupValue: paid,
                            onChanged: (value) {
                              setState(() {
                                paid = value;
                              });
                            },
                          ),
                          new GestureDetector(
                            onTap: () {
                              setState(() {
                                paid = 0;
                              });
                            },
                            child: new Text("Received"),
                          ),
                        ],
                      ),
                    )
                  : new Container(),
              new Container(
                margin: new EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new FlatButton(
                      child: new Text(
                        (bill == null) ? "" : "DELETE",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Future<bool> dialog = twoButtonDialog(
                            context, "Do you want to delete the bill?", "");
                        dialog.then((onValue) {
                          if (onValue) {
                            setState(() {
                              loading = true;
                            });
                            Future<bool> delete = update(
                                API.BILL,
                                Map.from({'status': '0'}),
                                Map.from({
                                  'hostel_id': hostelID,
                                  'id': bill.id,
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
