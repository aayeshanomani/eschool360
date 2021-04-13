import 'package:eschool360/styles/common.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SubjectWiseAnalysis extends StatefulWidget {
  @override
  _SubjectWiseAnalysisState createState() => _SubjectWiseAnalysisState();
}

class _SubjectWiseAnalysisState extends State<SubjectWiseAnalysis> {
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
                'Subject-wise Performance',
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
              if (_value != "Select Student")
                Container(
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: bluecolor,
                    borderRadius: containerRadius,
                  ),
                  child: Text(
                    _value == "s123"
                        ? 'Subject that needs the most attention - Physics'
                        : 'Subject that needs the most attention - Biology',
                    style: TextStyle(color: whitecolor),
                  ),
                ),
              SizedBox(height: 73,)
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
                  FlSpot(0, 4.6),
                  FlSpot(1, 7.2),
                  FlSpot(2, 1.5),
                  FlSpot(3, 1.1),
                  FlSpot(4, 3.9),
                  FlSpot(5, 3.8),
                  FlSpot(6, 8.6),
                  FlSpot(7, 7.8),
                  FlSpot(8, 6.3),
                  FlSpot(9, 6.6),
                  FlSpot(10, 7.5),
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
                  FlSpot(0, 1.5),
                  FlSpot(1, 3.7),
                  FlSpot(2, 10),
                  FlSpot(3, 5.2),
                  FlSpot(4, 4.1),
                  FlSpot(5, 1.3),
                  FlSpot(6, 9.3),
                  FlSpot(7, 10),
                  FlSpot(8, 6.7),
                  FlSpot(9, 10),
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
            fontSize: 10,
          );
        },
        margin: 8,
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return 'Eng';
            case 1:
              return 'Hin';
            case 2:
              return 'Mat';
            case 3:
              return 'Phy';
            case 4:
              return 'Chem';
            case 5:
              return 'Bio';
            case 6:
              return 'His';
            case 7:
              return 'Geo';
            case 8:
              return 'Comp';
            case 9:
              return 'Evs';
            case 10:
              return 'PE';
          }
          return '';
        },
      ));
}
