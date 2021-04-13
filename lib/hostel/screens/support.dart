import 'package:flutter/material.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../utils/utils.dart';
import '../utils/api.dart';
import '../utils/config.dart';

class SupportActivity extends StatefulWidget {
  final bool support;

  SupportActivity(this.support);

  @override
  State<StatefulWidget> createState() {
    return new SupportActivityState(support);
  }
}

class SupportActivityState extends State<SupportActivity> {
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController message = new TextEditingController();

  bool support;
  bool loading = false;

  SupportActivityState(this.support);

  bool nameCheck = false;
  bool phoneCheck = false;
  bool emailCheck = false;
  bool messageCheck = false;

  @override
  void initState() {
    super.initState();
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
          support ? "Feedback & Support" : "Sign Up",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 4.0,
        actions: <Widget>[
          new MaterialButton(
            textColor: Colors.white,
            child: new Text(
              "SUBMIT",
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

                  if (phone.text.length == 0) {
                    setState(() {
                      phoneCheck = true;
                      loading = false;
                    });
                    return;
                  } else {
                    setState(() {
                      phoneCheck = false;
                    });
                  }

                  if (email.text.length == 0) {
                    setState(() {
                      emailCheck = true;
                      loading = false;
                    });
                    return;
                  } else {
                    setState(() {
                      emailCheck = false;
                    });
                  }

                  if (support) {
                    if (message.text.length == 0) {
                      setState(() {
                        messageCheck = true;
                        loading = false;
                      });
                      return;
                    } else {
                      setState(() {
                        messageCheck = false;
                      });
                    }
                  }

                  Future<bool> load;
                  load = add(
                    support ? API.SUPPORT : API.SIGNUP,
                    Map.from({
                      'name': name.text,
                      'phone': phone.text,
                      'email': email.text,
                      'message': message.text,
                    }),
                  );
                  load.then((onValue) {
                    setState(() {
                      loading = false;
                    });
                    if (onValue != null) {
                      Navigator.pop(context, "");
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
                      margin: new EdgeInsets.fromLTRB(0, 0, 0, 15),
                      child: new Text(
                        support
                            ? "Have some feeback? Got any questions? We are happy to help. Fill up the below form. We will contact you."
                            : "Interested in Cloud PG? Sign up the below form. We will contact you.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                height: phoneCheck ? null : 50,
                margin: new EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        child: new TextField(
                          controller: phone,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffixIcon: phoneCheck
                                ? IconButton(
                                    icon: Icon(Icons.error, color: Colors.red),
                                    onPressed: () {},
                                  )
                                : null,
                            errorText: phoneCheck ? "Phone required" : null,
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
                height: emailCheck ? null : 50,
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
                            suffixIcon: emailCheck
                                ? IconButton(
                                    icon: Icon(Icons.error, color: Colors.red),
                                    onPressed: () {},
                                  )
                                : null,
                            errorText: emailCheck ? "Email required" : null,
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
                          controller: message,
                          maxLines: 5,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            suffixIcon: messageCheck
                                ? IconButton(
                                    icon: Icon(Icons.error, color: Colors.red),
                                    onPressed: () {},
                                  )
                                : null,
                            errorText: messageCheck ? "Message required" : null,
                            isDense: true,
                            prefixIcon: Icon(Icons.featured_play_list),
                            border: OutlineInputBorder(),
                            labelText: 'Message',
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
        inAsyncCall: loading,
      ),
    );
  }
}
