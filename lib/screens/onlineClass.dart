import 'dart:io';

import 'package:eschool360/loading.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';

class OnlineClass extends StatefulWidget {
  @override
  _OnlineClassState createState() => _OnlineClassState();
}

class _OnlineClassState extends State<OnlineClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongoing Classes'),
        backgroundColor: bluecolor,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: Database().getLink(),
            builder: (context, snapshot) {
              //print(snapshot.data.documents[0]['subject']);
              if (!snapshot.hasData)
                return Loading();
              else if (snapshot.data.documents.length < 1)
                return Container(
                  height: screenHeight(context) / 2,
                  child: Center(child: Text('No ongoing classes right now!')),
                );
              else
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < snapshot.data.documents.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: 180,
                          width: screenWidth(context, dividedBy: 1.1),
                          decoration: containerdecoration,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Subject : " +
                                      snapshot.data.documents[i]['subject'],
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "Topic : ",
                                      style: blacktext,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: snapshot.data.documents[i]
                                                ['topic'],
                                            style: bluetext)
                                      ]),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                RawMaterialButton(
                                  onPressed: () {
                                    //launchClass(snapshot
                                    //  .data.documents[i]['link']
                                    //.toString());
                                    _joinMeeting(snapshot.data.documents[i]['room'], snapshot.data.documents[i]['subject'],snapshot.data.documents[i]['topic']);
                                  },
                                  elevation: 6.0,
                                  fillColor: bluecolor,
                                  padding: EdgeInsets.all(4.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    width: screenWidth(context) * 0.9,
                                    decoration: BoxDecoration(
                                      borderRadius: buttonRadius,
                                      color: bluecolor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Join Now',
                                        style: TextStyle(color: whitecolor),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                );
            }),
      ),
    );
  }

  _joinMeeting(String room, String sub, String topic) async {
    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
        FeatureFlagEnum.LIVE_STREAMING_ENABLED: false,
      };

      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      // Define meetings options here
      var options = JitsiMeetingOptions()
        ..room = room
        ..serverURL = null
        ..subject = sub
        ..userDisplayName = username
        //..userEmail = emailText.text
        //..iosAppBarRGBAColor = iosAppBarRGBAColor.text
        ..audioOnly = false
        ..audioMuted = true
        ..videoMuted = true
        ..featureFlags.addAll(featureFlags);

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          debugPrint("${options.room} terminated with message: $message");
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        //roomNameConstraints: customConstraints, // to use your own constraint(s)
      );
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
