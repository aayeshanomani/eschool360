import 'package:eschool360/styles/common.dart';
import 'package:eschool360/teacherScreens/subjectWiseAnalysis.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StudentProgressReport extends StatefulWidget {
  @override
  _StudentProgressReportState createState() => _StudentProgressReportState();
}

class _StudentProgressReportState extends State<StudentProgressReport> {
  String _value = "Select Student";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        title: Text("Student Progress Report"),
        backgroundColor: bluecolor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  color: Colors.white,
                  width: screenWidth(context) / 1.1,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: bluecolor,
                      ),
                      items: [
                        DropdownMenuItem(
                          child: Text("s123"),
                          value: "s123",
                        ),
                        DropdownMenuItem(
                          child: Text("s234"),
                          value: "s234",
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                      hint: Text(
                        "   " + _value,
                        style: TextStyle(color: bluecolor),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Overall Progress',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 29,
              ),
              if (_value != "Select Student")
                Container(
                  height: screenHeight(context) / 1.5,
                  width: screenWidth(context) / 1.1,
                  decoration: BoxDecoration(
                      color: whitecolor,
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(29))),
                  child:
                      _value == "s123" ? LineChartWidget() : LineChartWidget2(),
                ),
              SizedBox(
                height: 28,
              ),
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubjectWiseAnalysis()));
                  },
                  color: bluecolor,
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Center(
                    child: Text(
                      'View Subject-wise Analysis',
                      style: TextStyle(color: whitecolor),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xffF02D3A),
    const Color(0xffF49097)
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
            show: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(color: Color(0xffDFB2F4), strokeWidth: 1);
            },
            drawVerticalLine: true,
            getDrawingVerticalLine: (value) =>
                FlLine(color: Color(0xffDFB2F4), strokeWidth: 1),
          ),
          borderData: FlBorderData(
              show: true,
              border: Border.all(color: Color(0xffF2F5FF), width: 1)),
          lineBarsData: [
            LineChartBarData(
                spots: [
                  FlSpot(0, 1.8),
                  FlSpot(1, 6.3),
                  FlSpot(2, 2.1),
                  FlSpot(3, 3.4),
                  FlSpot(4, 6.2),
                  FlSpot(5, 5.6),
                  FlSpot(6, 7.7),
                  FlSpot(7, 7.2),
                  FlSpot(8, 5.8),
                  FlSpot(9, 8.4),
                  FlSpot(10, 7.1),
                ],
                isCurved: true,
                colors: gradientColors,
                barWidth: 5,
                belowBarData: BarAreaData(
                  show: true,
                  colors:
                      gradientColors.map((e) => e.withOpacity(0.3)).toList(),
                )),
          ]),
    );
    ;
  }
}

class LineChartWidget2 extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xffF02D3A),
    const Color(0xffF49097)
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
            show: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(color: Color(0xffDFB2F4), strokeWidth: 1);
            },
            drawVerticalLine: true,
            getDrawingVerticalLine: (value) =>
                FlLine(color: Color(0xffDFB2F4), strokeWidth: 1),
          ),
          borderData: FlBorderData(
              show: true,
              border: Border.all(color: Color(0xffF2F5FF), width: 1)),
          lineBarsData: [
            LineChartBarData(
                spots: [
                  FlSpot(0, 3.5),
                  FlSpot(1, 2.3),
                  FlSpot(2, 5.4),
                  FlSpot(3, 1.1),
                  FlSpot(4, 2.5),
                  FlSpot(5, 6.1),
                  FlSpot(6, 8.2),
                  FlSpot(7, 9.6),
                  FlSpot(8, 2.7),
                  FlSpot(9, 6.1),
                  FlSpot(10, 1.5),
                ],
                isCurved: true,
                colors: gradientColors,
                barWidth: 5,
                belowBarData: BarAreaData(
                  show: true,
                  colors:
                      gradientColors.map((e) => e.withOpacity(0.3)).toList(),
                )),
          ]),
    );
  }
}

class LineTitles {
  static getTitlesData() => FlTitlesData(
      show: true,
      leftTitles: SideTitles(
        showTitles: true,
        reservedSize: 38,
        getTextStyles: (value) {
          return const TextStyle(
            color: Color(0xff414066),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          );
        },
        margin: 8,
        getTitles: (value) {
          switch (value.toInt()) {
            case 2:
              return '20%';
            case 5:
              return '50%';
            case 8:
              return '80%';
          }
          return '';
        },
      ),
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTextStyles: (value) {
          return const TextStyle(
            color: Color(0xff414066),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          );
        },
        margin: 8,
        getTitles: (value) {
          switch (value.toInt()) {
            case 2:
              return 'Class 3';
            case 5:
              return 'Class 6';
            case 8:
              return 'Class 9';
          }
          return '';
        },
      ));
}
