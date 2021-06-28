import 'package:eschool360/styles/common.dart';
import 'package:eschool360/teacherScreens/subjectWiseAnalysis.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LibStats extends StatefulWidget {
  @override
  _LibStatsState createState() => _LibStatsState();
}

class _LibStatsState extends State<LibStats> {
  String _value = "s123";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        title: Text("Library Progress Report"),
        backgroundColor: bluecolor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                width: screenWidth(context) / 1.1,
            
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
                Center(
                  child: Container(
                    height: screenHeight(context) / 1.5,
                    width: screenWidth(context) / 1.1,
                    decoration: BoxDecoration(
                        color: whitecolor,
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(29))),
                    child:
                        _value == "s123" ? LineChartWidget() : LineChartWidget2(),
                  ),
                ),
              SizedBox(
                height: 28,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xffDABFFF),
    const Color(0xff907AD6)
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
              return FlLine(color: Color(0xff4F518C), strokeWidth: 1);
            },
            drawVerticalLine: true,
            getDrawingVerticalLine: (value) =>
                FlLine(color: Color(0xff2C2A4A), strokeWidth: 1),
          ),
          borderData: FlBorderData(
              show: true,
              border: Border.all(color: Color(0xff7FDEFF), width: 1)),
          lineBarsData: [
            LineChartBarData(
                spots: [
                  FlSpot(0, 7.3),
                  FlSpot(1, 6.7),
                  FlSpot(2, 0.6),
                  FlSpot(3, 9.4),
                  FlSpot(4, 7.6),
                  FlSpot(5, 7.6),
                  FlSpot(6, 3.4),
                  FlSpot(7, 9.3),
                  FlSpot(8, 7.8),
                  FlSpot(9, 5.2),
                  FlSpot(10, 1.8),
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
        showTitles: false,
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
              return '2012';
            case 5:
              return '2015';
            case 8:
              return '2018';
          }
          return '';
        },
      ));
}
