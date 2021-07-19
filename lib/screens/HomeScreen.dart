import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool360/screens/Attendance.dart';
import 'package:eschool360/screens/Information.dart';
import 'package:eschool360/screens/Syllabus.dart';
import 'package:eschool360/screens/getVideos.dart';
import 'package:eschool360/screens/onlineClass.dart';
import 'package:eschool360/screens/settings.dart';
import 'package:eschool360/screens/studyFromAlumni.dart';
import 'package:eschool360/screens/wholeDiary.dart';
import 'package:eschool360/services/auth.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/services/helper.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/styles/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../loading.dart';
import '../wrapper.dart';
import 'CommonNotice.dart';
import 'Marks.dart';
import 'StudentTimetable.dart';
import 'chatbot.dart';
import 'counselling.dart';
import 'library.dart';
import 'myProgress.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController;

  List<String> image = [
    'https://ichef.bbci.co.uk/news/410/cpsprodpb/9694/production/_112984583_9e98b657-8e44-461d-a339-b800b14efde9.jpg',
    'https://3.files.edl.io/393b/19/07/31/193856-ab751341-d40f-473d-b826-f1d3420e27cc.jpg',
    'https://resources.finalsite.net/images/f_auto,q_auto,t_image_size_4/v1579477940/shanghaiamerican/anrqkhwz0snqjmp8kegp/facilities_overview.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/5/5f/Larkmead_School%2C_Abingdon%2C_Oxfordshire.png'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bluecolor,
        elevation: 0.0,
      ),
      body: StreamBuilder(
          stream: Database().getDocument(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Loading();
            classname = snapshot.data.documents[0]['class'].toString();
            return SingleChildScrollView(
                child: Center(
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: screenHeight(context) * 3,
                      width: double.infinity,
                    ),
                    Container(
                      color: bluecolor,
                      padding: EdgeInsets.only(top: 10, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                              children: <TextSpan>[
                                TextSpan(text: 'Hello, Welcome '),
                                TextSpan(
                                    text: 'Parent!',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      width: double.infinity,
                      height: screenHeight(context)*2,
                    ),
                    nameContainer(),
                    dpContainer(),
                    name(),
                    about(),
                    Positioned(
                      top: screenHeight(context, dividedBy: 3.7),
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[50],
                            borderRadius: borderRadius,
                          ),
                          height: screenHeight(context) * 3,
                          width: screenWidth(context),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      homeIcons('assets/images/info.png',
                                          'Information', 1, context),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      homeIcons('assets/images/diary.png',
                                          'Diary', 2, context),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      homeIcons('assets/images/syllabus.png',
                                          'Syllabus', 3, context),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      homeIcons('assets/images/attendance.png',
                                          'Attendance', 4, context),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      homeIcons('assets/images/marks.png',
                                          'Marks', 5, context),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      homeIcons('assets/images/timetable.jpg',
                                          'Timetable', 6, context),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          'Insights',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          FontAwesomeIcons.calendarAlt,
                                          color: Colors.indigo[600],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      RawMaterialButton(
                                        onPressed: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MyProgress()));
                                        },
                                        elevation: 6.0,
                                        fillColor: Colors.white,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Center(
                                                  child: Text('My Progress',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ))),
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              width: screenWidth(context,
                                                  dividedBy: 2.3),
                                              height: 90,
                                            ),
                                          ],
                                        ),
                                        //padding: EdgeInsets.all(20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          //side: BorderSide(
                                          //color: Colors.indigo[600])
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      RawMaterialButton(
                                        onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CommonNotice()));
                                        },
                                        elevation: 6.0,
                                        fillColor: Colors.white,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Center(
                                                  child: Text('Notice Board',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ))),
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              width: screenWidth(context,
                                                  dividedBy: 2.2),
                                              height: 90,
                                            ),
                                          ],
                                        ),
                                        //padding: EdgeInsets.all(20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RawMaterialButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoLectures()));
                                        },
                                        elevation: 6.0,
                                        fillColor: Colors.white,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Center(
                                                  child: Text('E-Learning',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ))),
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              width: screenWidth(context,
                                                  dividedBy: 2.3),
                                              height: 90,
                                            ),
                                          ],
                                        ),
                                        //padding: EdgeInsets.all(20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      RawMaterialButton(
                                        onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Counselling()));
                                        },
                                        elevation: 6.0,
                                        fillColor: Colors.white,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Center(
                                                  child: Text('Counselling',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ))),
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              width: screenWidth(context,
                                                  dividedBy: 2.2),
                                              height: 90,
                                            ),
                                          ],
                                        ),
                                        //padding: EdgeInsets.all(20.0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                                'Chat Box',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Icon(
                                                FontAwesomeIcons.sms,
                                                color: Colors.indigo[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatBot()));
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(38),
                                            child: Image.asset
                                            (
                                              "assets/images/chatbot.png",
                                              fit: BoxFit.fill,
                                              width: screenWidth(context)/1.1,
                                              height: 200,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                                'Study from alumni',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Icon(
                                                FontAwesomeIcons.bookMedical,
                                                color: Colors.indigo[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StudyFromAlumni()));
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(38),
                                            child: Image.asset
                                            (
                                              "assets/images/alumni.jpg",
                                              fit: BoxFit.fill,
                                              width: screenWidth(context)/1.1,
                                              height: 200,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                                'Library',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Icon(
                                                FontAwesomeIcons.bookDead,
                                                color: Colors.indigo[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Library()));
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(38),
                                            child: Image.asset
                                            (
                                              "assets/images/library.jpg",
                                              fit: BoxFit.fill,
                                              width: screenWidth(context)/1.1,
                                              height: 200,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 39,),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          'Gallery',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          FontAwesomeIcons.arrowRight,
                                          color: Colors.indigo[600],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                      height: 200,
                                      width: 300,
                                      child: PageView.builder(
                                          controller: pageController,
                                          itemCount: 4,
                                          itemBuilder: (context, position) {
                                            return imageSlider(position);
                                          }))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          }),
      drawer: Drawer(
        child: Center(
            child: ListView(
          children: <Widget>[
            Container(
              height: 150,
              width: 10,
            ),
            ListTile(
              dense: true,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              title: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.dashboard,
                    color: bluecolor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Dashboard",
                    style: bluetext,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              dense: true,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Information()));
              },
              title: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.info,
                    color: bluecolor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Information",
                    style: bluetext,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              dense: true,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Attendance()));
              },
              title: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    FontAwesomeIcons.checkCircle,
                    color: bluecolor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Attendance",
                    style: bluetext,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              dense: true,
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => VideoLectures()));
              },
              title: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    FontAwesomeIcons.bookOpen,
                    color: bluecolor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Video Lectures",
                    style: bluetext,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              dense: true,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OnlineClass()));
              },
              title: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    FontAwesomeIcons.book,
                    color: bluecolor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Ongoing Classes",
                    style: bluetext,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              onTap:()  {
                print(encrytion('Hello'));
                print(decryt(encrytion("Hii How are you")));
                },
              dense: true,
              title: Text("About us"),
            ),
            ListTile(
              dense: true,
              title: Text("Help Centre"),
            ),
            ListTile(
              dense: true,
              title: Text("Terms of Service"),
            ),
            ListTile(
              dense: true,
              title: Text("Contact us"),
            ),
            FlatButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Settings()));
                  });
                },
                child: Container(
                  decoration: containerdecoration,
                  child: Text(
                    "Settings",
                    style: bluetext,
                  ),
                )),
                FlatButton(
                onPressed: () {
                  setState(() {
                    HelperFunc.saveUserloggedIn(false);
                    isLoggedIn = false;
                    print('logout');
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Wrapper()));
                  });
                },
                child: Container(
                  decoration: containerdecoration,
                  child: Text(
                    "SignOut",
                    style: bluetext,
                  ),
                ))
          ],
        )),
      ),
    );
  }

  imageSlider(int index) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page - index;
          value = (1 - value.abs() * 0.3).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 200,
            width: Curves.easeInOut.transform(value) * 300,
            child: widget,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Image.network(
          image[index],
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
