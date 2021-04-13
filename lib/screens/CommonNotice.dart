import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool360/loading.dart';
import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';

class CommonNotice extends StatefulWidget {
  @override
  _CommonNoticeState createState() => _CommonNoticeState();
}

class _CommonNoticeState extends State<CommonNotice> {
  Widget card(String subject, String notice) => Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Container(
          //color: Colors.white,
          decoration: containerdecoration,
          width: screenWidth(context, dividedBy: 1.1),
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Spacer(),
                Text(
                  subject,
                  style: bluebold,
                ),
                Spacer(),
                Text(
                  notice,
                  style: bigblacktext,
                ),
                Spacer()
              ],
            ),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection(schoolID)
            .document('notice')
            .collection('notice')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Scaffold(body: Loading());
          return Scaffold(
            backgroundColor: whitecolor,
            appBar: AppBar(
              backgroundColor: bluecolor,
              title: Text("Notice Board"),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  color: whitecolor,
                  child: Column(
                    children: <Widget>[
                      for (var i = 0; i < snapshot.data.documents.length; i++)
                        card(snapshot.data.documents[i]["subject"],
                            snapshot.data.documents[i]["notice"])
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
