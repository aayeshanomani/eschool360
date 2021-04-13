import 'package:eschool360/screens/Information.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/teacherScreens/TeacherDiary.dart';
import 'package:eschool360/teacherScreens/hostClass.dart';
import 'package:eschool360/teacherScreens/uploadStudyMaterial.dart';
import 'package:eschool360/teacherScreens/videos.dart';
import 'package:flutter/material.dart';

class ELearning extends StatefulWidget {
  @override
  _ELearningState createState() => _ELearningState();
}

class _ELearningState extends State<ELearning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bluecolor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 22, horizontal: 36),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: whitecolor,
                      size: 48,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  GestureDetector(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(73),
                      child: Image.asset(
                        "assets/images/baby.jpg",
                        width: 48.0,
                        height: 48,
                        fit: BoxFit.fill,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => Information()));
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
              child: Text(
                "E-Learning Module",
                style: TextStyle(
                    color: whitecolor,
                    fontSize: 28,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(18),
              child: Center(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: <Widget>[
                    SizedBox(
                      width: 160,
                      height: 160,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => HostClass()));
                        },
                        child: Card(
                          color: Color(0xffFFFFFF),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  child: Image.asset(
                                      "assets/images/hostOnlineClass.png",
                                      fit: BoxFit.fill,
                                      width: 64),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Online Class",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160,
                      height: 160,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TeacherDiary()));
                        },
                        child: Card(
                          color: Color(0xffFFFFFF),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                ClipRRect(
                                  child: Image.asset(
                                      "assets/images/uploadAssignment.png",
                                      fit: BoxFit.fill,
                                      width: 64),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  "Assignments",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160,
                      height: 160,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  UploadStudyMaterial()));
                        },
                        child: Card(
                          color: Color(0xffFFFFFF),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 20),
                                ClipRRect(
                                  child: Image.asset(
                                      "assets/images/uploadStudyMaterial.png",
                                      fit: BoxFit.fill,
                                      width: 64),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "Study Material",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160,
                      height: 160,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  UploadVideos()));
                        },
                        child: Card(
                          color: Color(0xffFFFFFF),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 20.0,
                                ),
                                ClipRRect(
                                  child: Image.asset(
                                      "assets/images/uploadVideoLecture.png",
                                      fit: BoxFit.fill,
                                      width: 64),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  "Video Lecture",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
