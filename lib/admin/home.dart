import 'package:eschool360/Principal/NoticeBoard.dart';
import 'package:eschool360/admin/schoolProgress.dart';
import 'package:eschool360/screens/Attendance.dart';
import 'package:eschool360/screens/CommonNotice.dart';
import 'package:eschool360/screens/HomeScreen.dart';
import 'package:eschool360/screens/Information.dart';
import 'package:eschool360/screens/chatbot.dart';
import 'package:eschool360/screens/counselling.dart';
import 'package:eschool360/screens/getVideos.dart';
import 'package:eschool360/screens/library.dart';
import 'package:eschool360/screens/myProgress.dart';
import 'package:eschool360/screens/onlineClass.dart';
import 'package:eschool360/screens/settings.dart';
import 'package:eschool360/screens/studyFromAlumni.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/services/helper.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/styles/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../wrapper.dart';
import 'libStats.dart';



class AdminHome extends StatefulWidget {
  const AdminHome({Key key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  PageController pageController;

  
  List<String> image = [
  'https://ed.stanford.edu/sites/default/files/news_images/lisegagne.jpg',
  'https://geniuszone.biz/wp-content/uploads/2017/12/schooleducation-2.jpg',
  'https://t3y4b2m7.rocketcdn.me/wp-content/uploads/2016/01/education-school-apple-learn-ss-1920-800x450.jpg',
  'https://images.theconversation.com/files/116721/original/image-20160330-28476-o8slfq.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=926&fit=clip'  
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
                                    text: 'Admin!',
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
                      height: screenHeight(context) * 2,
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
                                      
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
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
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          SchoolProgress()));
                                        },
                                        elevation: 6.0,
                                        fillColor: Colors.white,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Center(
                                                  child: Text('School Progress',
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NoticeBoard()));
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
                                    height: 50,
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Text(
                                                'Chat Box',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                FontAwesomeIcons.sms,
                                                color: Colors.indigo[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatBot()));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(38),
                                            child: Image.asset(
                                              "assets/images/chatbot.png",
                                              fit: BoxFit.fill,
                                              width: screenWidth(context) / 1.1,
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
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Text(
                                                'Library',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                FontAwesomeIcons.bookDead,
                                                color: Colors.indigo[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LibStats()));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(38),
                                            child: Image.asset(
                                              "assets/images/library.jpg",
                                              fit: BoxFit.fill,
                                              width: screenWidth(context) / 1.1,
                                              height: 200,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 39,
                                  ),
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
                    MaterialPageRoute(builder: (context) => AdminHome()));
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
            
            
            SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
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
