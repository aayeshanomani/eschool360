import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschool360/screens/Attendance.dart';
import 'package:eschool360/screens/Information.dart';
import 'package:eschool360/screens/Syllabus.dart';
import 'package:eschool360/screens/getVideos.dart';
import 'package:eschool360/screens/onlineClass.dart';
import 'package:eschool360/screens/settings.dart';
import 'package:eschool360/screens/wholeDiary.dart';
import 'package:eschool360/services/auth.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/services/helper.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/styles/widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../loading.dart';
import '../wrapper.dart';
import 'CommonNotice.dart';
import 'Marks.dart';
import 'StudentTimetable.dart';
import 'chatbot.dart';
import 'counselling.dart';
import 'myProgress.dart';
import 'settings.dart';

class CounsellorHome extends StatefulWidget {
  @override
  _CounsellorHomeState createState() => _CounsellorHomeState();
}

class _CounsellorHomeState extends State<CounsellorHome> {
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
                      color: bluecolor,
                      height: screenHeight(context) * 1.5,
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
                                    text: 'Counsellor!',
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
                      height: screenHeight(context),
                    ),
                    nameContainer(),
                    dpContainer(),
                    name(),
                    about(),
                    Positioned(
                      top: screenHeight(context, dividedBy: 3.7),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Appointments',
                                    style: TextStyle(
                                        color: whitecolor,
                                        fontSize: 22,
                                        letterSpacing: 2)),
                                SizedBox(
                                  height: 27,
                                ),
                                Container(
                                  height: 150,
                                  width: screenWidth(context) / 1.1,
                                  decoration: BoxDecoration(
                                      color: whitecolor,
                                      borderRadius: containerRadius),
                                  child: Center(
                                    child: Text('No current appointments'),
                                  ),
                                ),
                                SizedBox(
                                  height: 38,
                                ),
                                Text('Previous Appointments',
                                    style: TextStyle(
                                        color: whitecolor,
                                        fontSize: 22,
                                        letterSpacing: 2)),
                                SizedBox(
                                  height: 27,
                                ),
                                Container(
                                    height: 150,
                                    width: screenWidth(context) / 1.1,
                                    decoration: BoxDecoration(
                                        color: whitecolor,
                                        borderRadius: containerRadius),
                                    child: LineChartWidget3()),
                                SizedBox(
                                  height: 38,
                                ),
                                Text('Chat Box',
                                    style: TextStyle(
                                        color: whitecolor,
                                        fontSize: 22,
                                        letterSpacing: 2)),
                                SizedBox(
                                  height: 27,
                                ),
                                Container(
                                  height: 200,
                                  width: screenWidth(context) / 1.1,
                                  decoration: BoxDecoration(
                                      color: whitecolor,
                                      borderRadius: containerRadius),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChatBot()));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(38),
                                      child: Image.asset(
                                        "assets/images/chatbot.png",
                                        fit: BoxFit.fill,
                                        width: screenWidth(context) / 1.1,
                                        height: 200,
                                      ),
                                    ),
                                  ),
                                )
                              ],
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
                    MaterialPageRoute(builder: (context) => CounsellorHome()));
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

class LineChartWidget3 extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xffF28F3B),
    const Color(0xffC8553D)
  ];
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: 10,
          titlesData: LineTitles.getTitlesData(),
          gridData: FlGridData(
            show: false,
            getDrawingHorizontalLine: (value) {
              return FlLine(color: Color(0xffDFB2F4), strokeWidth: 1);
            },
            drawVerticalLine: true,
            getDrawingVerticalLine: (value) =>
                FlLine(color: Color(0xffDFB2F4), strokeWidth: 1),
          ),
          borderData: FlBorderData(
              show: true,
              border: Border.all(color: Color(0xffACBDBA), width: 1)),
          lineBarsData: [
            LineChartBarData(
                spots: [
                  FlSpot(0, 0.6),
                  FlSpot(1, 0.9),
                  FlSpot(2, 0.9),
                  FlSpot(3, 0.5),
                  FlSpot(4, 0.5),
                  FlSpot(5, 2.7),
                  FlSpot(6, 1.99),
                  FlSpot(7, 9.3),
                  FlSpot(8, 5.4),
                  FlSpot(9, 7.4),
                  FlSpot(10, 3.2),
                ],
                isCurved: false,
                colors: gradientColors,
                barWidth: 2,
                belowBarData: BarAreaData(
                  show: false,
                  colors:
                      gradientColors.map((e) => e.withOpacity(0.3)).toList(),
                )),
          ]),
    );
  }
}
