import 'package:eschool360/screens/Information.dart';
import 'package:eschool360/screens/chatbot.dart';
import 'package:eschool360/screens/settings.dart';
import 'package:eschool360/services/database.dart';
import 'package:eschool360/services/helper.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/styles/widgets.dart';
import 'package:eschool360/wrapper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AlumniHome extends StatefulWidget {
  @override
  _AlumniHomeState createState() => _AlumniHomeState();
}

class _AlumniHomeState extends State<AlumniHome> {
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
                                    text: 'Alumni!',
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
                                Text('Current requests to teach',
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
                                    child: Text('No current requests'),
                                  ),
                                ),
                                SizedBox(
                                  height: 38,
                                ),
                                Text('Previous Requests',
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
                                    child: LineChartSample4()),
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
                    MaterialPageRoute(builder: (context) => AlumniHome()));
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
}

class LineChartSample4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const cutOffYValue = 5.0;
    const dateTextStyle =
        TextStyle(fontSize: 10, color: Color(0xffDB5461), fontWeight: FontWeight.bold);

    return SizedBox(
      width: 300,
      height: 140,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 4),
                FlSpot(1, 3.5),
                FlSpot(2, 4.5),
                FlSpot(3, 1),
                FlSpot(4, 4),
                FlSpot(5, 6),
                FlSpot(6, 6.5),
                FlSpot(7, 6),
                FlSpot(8, 4),
                FlSpot(9, 6),
                FlSpot(10, 6),
                FlSpot(11, 7),
              ],
              isCurved: true,
              barWidth: 8,
              colors: [
                Color(0xff686963),
              ],
              belowBarData: BarAreaData(
                show: true,
                colors: [Color(0xff8AA29E).withOpacity(0.4)],
                cutOffY: cutOffYValue,
                applyCutOffY: true,
              ),
              aboveBarData: BarAreaData(
                show: true,
                colors: [Color(0xff3D5467).withOpacity(0.6)],
                cutOffY: cutOffYValue,
                applyCutOffY: true,
              ),
              dotData: FlDotData(
                show: false,
              ),
            ),
          ],
          minY: 0,
          titlesData: FlTitlesData(
            bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 14,
                getTextStyles: (value) => dateTextStyle,
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0:
                      return 'Jan';
                    case 1:
                      return 'Feb';
                    case 2:
                      return 'Mar';
                    case 3:
                      return 'Apr';
                    case 4:
                      return 'May';
                    case 5:
                      return 'Jun';
                    case 6:
                      return 'Jul';
                    case 7:
                      return 'Aug';
                    case 8:
                      return 'Sep';
                    case 9:
                      return 'Oct';
                    case 10:
                      return 'Nov';
                    case 11:
                      return 'Dec';
                    default:
                      return '';
                  }
                }),
            leftTitles: SideTitles(
              showTitles: true,
              getTitles: (value) {
                return '${value + 1}';
              },
            ),
          ),
          axisTitleData: FlAxisTitleData(
              leftTitle: AxisTitle(showTitle: true, titleText: 'Value', margin: 4),
              bottomTitle: AxisTitle(
                  showTitle: true,
                  margin: 0,
                  titleText: '2020',
                  textStyle: dateTextStyle,
                  textAlign: TextAlign.right)),
          gridData: FlGridData(
            show: true,
            checkToShowHorizontalLine: (double value) {
              return value == 1 || value == 6 || value == 4 || value == 5;
            },
          ),
        ),
      ),
    );
  }
}