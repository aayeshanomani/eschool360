import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../loading.dart';

class Notice extends StatefulWidget {
  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  Widget card(String subject,String notice)=>Padding( //a card to show all the notices.
    padding: const EdgeInsets.all(8.0),
    child: SingleChildScrollView(
      child: GestureDetector(
        onDoubleTap: (){
           Firestore.instance.collection(schoolID).document('notice').collection('notice')
             .document(subject).delete(); //to delete the notice given 
        },
          child: Container(
            //color: Colors.white,
            decoration: containerdecoration,
            width: screenWidth(context,dividedBy: 1.1),
            //height:  ,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Text(subject,style: bluebold,),
                  SizedBox(height: 20,),
                  Text(notice,style: bigblacktext,),
                  SizedBox(height: 20,),
                ],
              ),
            ),
        ),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: StreamBuilder(
        stream: Firestore.instance.collection(schoolID).document('notice')
          .collection('notice').snapshots(), //to get all the notices
        builder: (context, snapshot) {
          return !snapshot.hasData?Loading():Container(
            //height: screenHeight(context),
            width: screenWidth(context),
            color: whitecolor,
            child: Column(
              children: <Widget>[
                for(var i = 0;i<snapshot.data.documents.length;i++) //this gets all the documents in the notice collection
                card(snapshot.data.documents[i]["subject"],snapshot.data.documents[i]["notice"] )
              ],
            ),
          );
        }
      ),
    );
  }
}
