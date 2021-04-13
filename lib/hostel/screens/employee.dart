import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../utils/utils.dart';
import '../utils/api.dart';
import '../utils/config.dart';
import '../utils/models.dart';
import './photo.dart';
import 'pro.dart';

class EmployeeActivity extends StatefulWidget {
  final Employee employee;

  EmployeeActivity(this.employee);

  @override
  State<StatefulWidget> createState() {
    return new EmployeeActivityState(employee);
  }
}

class EmployeeActivityState extends State<EmployeeActivity> {
  TextEditingController name = new TextEditingController();
  TextEditingController designation = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController salary = new TextEditingController();
  TextEditingController joiningDate = new TextEditingController();

  Employee employee;

  bool loading = false;
  List<String> fileNames = new List();
  List<Widget> fileWidgets = new List();

  EmployeeActivityState(this.employee);

  bool nameCheck = false;

  @override
  void initState() {
    super.initState();
    if (employee != null) {
      name.text = employee.name;
      designation.text = employee.designation;
      phone.text = employee.phone;
      email.text = employee.email;
      address.text = employee.address;
      salary.text = employee.salary;
      if (employee.document != null) {
        fileNames = employee.document.split(",");
      }
    } else {
      joiningDate.text = dateFormat.format(new DateTime.now());
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
    print(fileNames);
    fileWidgets.clear();
    fileNames.forEach((file) {
      if (file.length > 0) {
        fileWidgets.add(new Row(
          children: <Widget>[
            new IconButton(
              icon: new Image.network(mediaURL + file),
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
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().subtract(new Duration(days: 365)),
        lastDate: new DateTime.now().add(new Duration(days: 365)));
    if (picked != null)
      setState(() => joiningDate.text = dateFormat.format(picked));
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
          "Employee",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 4.0,
        actions: <Widget>[
          new MaterialButton(
            textColor: Colors.white,
            child: employee != null
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
                  if (employee != null) {
                    load = update(
                      API.EMPLOYEE,
                      Map.from({
                        'name': name.text,
                        'designation': designation.text,
                        'phone': phone.text,
                        'email': email.text,
                        'address': address.text,
                        'salary': salary.text,
                        'document': fileNames.join(","),
                      }),
                      Map.from({'hostel_id': hostelID, 'id': employee.id}),
                    );
                  } else {
                    load = add(
                      API.EMPLOYEE,
                      Map.from({
                        'hostel_id': hostelID,
                        'name': name.text,
                        'designation': designation.text,
                        'phone': phone.text,
                        'email': email.text,
                        'address': address.text,
                        'salary': salary.text,
                        'joining_date_time': joiningDate.text,
                        'document': fileNames.join(","),
                      }),
                    );
                  }
                  load.then((onValue) {
                    setState(() {
                      loading = false;
                    });
                    if (onValue != null) {
                      if (employee != null) {
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
              new Container(
                height: 50,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        child: new TextField(
                          controller: designation,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.assignment_ind),
                            border: OutlineInputBorder(),
                            labelText: 'Designation',
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        child: new TextField(
                          controller: salary,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.money_off),
                            border: OutlineInputBorder(),
                            labelText: 'Salary',
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
              employee != null
                  ? new Container()
                  : new GestureDetector(
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
                    ),
              new Container(
                margin: new EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new FlatButton(
                      child: new Text(
                        (employee == null) ? "" : "DELETE",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        Future<bool> dialog = twoButtonDialog(
                            context, "Do you want to delete the employee?", "");
                        dialog.then((onValue) {
                          if (onValue) {
                            setState(() {
                              loading = true;
                            });
                            Future<bool> delete = update(
                                API.EMPLOYEE,
                                Map.from({'status': '0'}),
                                Map.from({
                                  'hostel_id': hostelID,
                                  'id': employee.id,
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
