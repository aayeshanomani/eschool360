import 'package:eschool360/services/database.dart';
import 'package:eschool360/styles/common.dart';
import 'package:eschool360/styles/widgets.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../loading.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  CalendarController calendarController;

  Map<DateTime, List<dynamic>> events;
  List<Map<DateTime, List<dynamic>>> total;
  Map<DateTime, int> index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calendarController = CalendarController();
    events = {};
    total = [];
    index = {};
  }

  Map<String, List<dynamic>> encodeMap(Map<DateTime, List<dynamic>> map) {
    Map<String, List<dynamic>> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, List<dynamic>> decodeMap(Map<String, List<dynamic>> map) {
    Map<DateTime, List<dynamic>> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bluecolor,
          elevation: 0.0,
          title: Text('Attendance'),
        ),
        body: StreamBuilder(
            stream: Database().getAttendance(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Loading();
              for (int i = 0; i < snapshot.data.documents.length; i++) {
                if (snapshot.data.documents[i]['date'] != null) {
                  String date = snapshot.data.documents[i]['date'];
                  List eveList = [];
                  eveList.add(snapshot.data.documents[i][date]);
                  print(eveList);
                  Map<String, List<dynamic>> map = {date: eveList};
                  Map<DateTime, List<dynamic>> newmap = decodeMap(map);
                  print(newmap);
                  total.add(newmap);
                  events.addAll(newmap);
                }
              }
              if (!snapshot.hasData) return Loading();
              return SingleChildScrollView(
                  child: Center(
                      child: SingleChildScrollView(
                          child: Stack(children: <Widget>[
                Container(
                  height: screenHeight(context),
                  width: double.infinity,
                ),
                Container(
                  color: bluecolor,
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                        child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[50],
                        borderRadius: borderRadius,
                      ),
                      height: screenHeight(context) * 2,
                      width: screenWidth(context),
                      child: Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: borderRadius,
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            TableCalendar(
                              events: events,
                              calendarController: calendarController,
                              calendarStyle: CalendarStyle(
                                todayColor: whitecolor,
                                selectedColor: bluecolor,
                                todayStyle: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: bluecolor),
                              ),
                              headerStyle: HeaderStyle(
                                  formatButtonDecoration: BoxDecoration(
                                    color: whitecolor,
                                    borderRadius: buttonRadius,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5.0,
                                      ),
                                    ],
                                  ),
                                  formatButtonShowsNext: false,
                                  titleTextStyle: bigbluetext),
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              weekendDays: [DateTime.sunday],
                              
                              builders: CalendarBuilders(
                                selectedDayBuilder: (context, date, events) {
                                  return Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      date.day.toString(),
                                      style: TextStyle(
                                          color: whitecolor, fontSize: 16),
                                    ),
                                    decoration: BoxDecoration(
                                        color: bluecolor,
                                        shape: BoxShape.circle),
                                    margin: EdgeInsets.all(4.0),
                                  );
                                },
                                markersBuilder:
                                    (context, date, events, holidays) {
                                  List markers = <Widget>[];
                                  markers.add(Positioned(
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: events[0] == 'present'
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      width: 10.0,
                                      height: 10.0,
                                    ),
                                  ));
                                  return markers;
                                },
                              ),
                            ),
                            SizedBox(height: 30,),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row
                              (
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>
                                [
                                
                                  AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                        width: 10.0,
                                        height: 10.0,
                                      ),
                                      SizedBox(width: 50,),
                                      Text('Absent'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row
                              (
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>
                                [
                                
                                  AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green,
                                        ),
                                        width: 10.0,
                                        height: 10.0,
                                      ),
                                      SizedBox(width: 50,),
                                      Text('Present'),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  )
                )
              ]
            )
          )
        )
      );
    }));
  }
}
