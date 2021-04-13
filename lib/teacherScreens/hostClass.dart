import 'dart:io';

import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';

class HostClass extends StatefulWidget {
  @override
  _HostClassState createState() => _HostClassState();
}

class _HostClassState extends State<HostClass> {
  final serverText = TextEditingController();
  final roomText = TextEditingController();
  final subjectText = TextEditingController();
  final topicText = TextEditingController();
  final nameText = TextEditingController();
  final iosAppBarRGBAColor =
      TextEditingController(text: "#0080FF80"); //transparent blue
  var isAudioOnly = false;
  var isAudioMuted = false;
  var isVideoMuted = false;

  String link;
  String sysClass = "";

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bluecolor,
        title: const Text('Online Class'),
      ),
      body: Container(
        color: whitecolor,
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: SingleChildScrollView(
          child: Theme(
            data: ThemeData(
                primaryColor: bluecolor, toggleableActiveColor: bluecolor),
            child: Column(
              children: <Widget>[
                SizedBox(height: 24.0),
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: serverText,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Server URL",
                        hintText: "Hint: Leave empty for us"),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  color: Colors.white,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        link = 'https://meet.jit.si/' + roomText.text;
                        print(link);
                      });
                    },
                    controller: roomText,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: "Room",
                      suffixIcon: IconButton(
                        onPressed: () {
                          Clipboard.setData(
                              new ClipboardData(text: roomText.text));
                          Scaffold.of(context).showSnackBar(
                              new SnackBar(content: Text("Room id Copied")));
                        },
                        //()=>
                        //Clipboard.setData(new ClipboardData(text: roomText.text)),
                        icon: Icon(
                          Icons.content_copy,
                          color: bluecolor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: subjectText,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: "Subject",
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: topicText,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: "Topic",
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: nameText,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: "Display Name",
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: screenWidth(context, dividedBy: 1.1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: bluecolor,
                        ),
                        items: [
                          DropdownMenuItem(
                            child: Text(" L"),
                            value: "L",
                          ),
                          DropdownMenuItem(
                            child: Text(" U"),
                            value: "U",
                          ),
                          DropdownMenuItem(
                            child: Text(" 1"),
                            value: "1",
                          ),
                          DropdownMenuItem(
                            child: Text("2"),
                            value: "2",
                          ),
                          DropdownMenuItem(
                            child: Text("3"),
                            value: "3",
                          ),
                          DropdownMenuItem(
                            child: Text("4"),
                            value: "4",
                          ),
                          DropdownMenuItem(
                            child: Text(" 5"),
                            value: "5",
                          ),
                          DropdownMenuItem(
                            child: Text(" 6"),
                            value: "6",
                          ),
                          DropdownMenuItem(
                            child: Text(" 7"),
                            value: "7",
                          ),
                          DropdownMenuItem(
                            child: Text(" 8"),
                            value: "8",
                          ),
                          DropdownMenuItem(
                            child: Text(" 9"),
                            value: "9",
                          ),
                          DropdownMenuItem(
                            child: Text(" 10"),
                            value: "10",
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            sysClass = value;
                          });
                        },
                        hint: sysClass == ""
                            ? Text(
                                "  Select Class",
                                style: TextStyle(color: bluecolor),
                              )
                            : Text(
                                "  $sysClass",
                                style: TextStyle(color: bluecolor),
                              )),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
//                TextField(
//                  controller: iosAppBarRGBAColor,
//                  decoration: InputDecoration(
//                      border: OutlineInputBorder(),
//                      labelText: "AppBar Color(IOS only)",
//                      hintText: "Hint: This HAS to be in HEX RGBA format"),
//                ),
                SizedBox(
                  height: 16.0,
                ),
                CheckboxListTile(
                  title: Text(
                    "Audio Only",
                    style: bluebold,
                  ),
                  //checkColor: bluecolor,
                  value: isAudioOnly,
                  onChanged: _onAudioOnlyChanged,
                ),
                SizedBox(
                  height: 16.0,
                ),
                CheckboxListTile(
                  title: Text(
                    "Audio Muted",
                    style: bluebold,
                  ),
                  value: isAudioMuted,
                  onChanged: _onAudioMutedChanged,
                ),
                SizedBox(
                  height: 16.0,
                ),
                CheckboxListTile(
                  title: Text(
                    "Video Muted",
                    style: bluebold,
                  ),
                  value: isVideoMuted,
                  onChanged: _onVideoMutedChanged,
                ),
                Divider(
                  height: 48.0,
                  thickness: 2.0,
                  color: bluecolor,
                ),
                Container(
                  color: bluecolor,
                  height: 64.0,
                  width: double.maxFinite,
                  child: RaisedButton(
                    onPressed: () {
                      _joinMeeting();
                    },
                    child: Text(
                      "Join Class",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: bluecolor,
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onAudioOnlyChanged(bool value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    String serverUrl =
        serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;

    Database().saveLink(
        roomText.text, subjectText.text, sysClass, topicText.text);

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
        ..room = roomText.text
        ..serverURL = serverUrl
        ..subject = subjectText.text
        ..userDisplayName = nameText.text
        //..userEmail = emailText.text
        //..iosAppBarRGBAColor = iosAppBarRGBAColor.text
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
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

  static final Map<RoomNameConstraintType, RoomNameConstraint>
      customContraints = {
    RoomNameConstraintType.MAX_LENGTH: new RoomNameConstraint((value) {
      return value.trim().length <= 50;
    }, "Maximum room name length should be 30."),
    RoomNameConstraintType.FORBIDDEN_CHARS: new RoomNameConstraint((value) {
      return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false)
              .hasMatch(value) ==
          false;
    }, "Currencies characters aren't allowed in room names."),
  };

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    //Scaffold.of(context).showSnackBar(new SnackBar(
    //  content: Text("Joined conference $message")));
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    Database().delLink(subjectText.text, sysClass);
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }

  onCopy(String text) {
    Clipboard.setData(new ClipboardData(text: text));
    Scaffold.of(context)
        .showSnackBar(new SnackBar(content: Text("Room id Copied")));
  }
}
