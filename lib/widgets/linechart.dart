import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LineChartContainer extends StatefulWidget {
  const LineChartContainer({Key? key}) : super(key: key);

  @override
  _LineChartContainerState createState() => _LineChartContainerState();
}

class _LineChartContainerState extends State<LineChartContainer> {
  String selectedYear = '2022';
  List<String> yearList = [
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',

  ];
  bool isYearListVisible = false;
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 0.9,
      height: screenSize.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0XFF292929),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              buildSelectedYearBox(screenSize),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: LineChart(
                  isShowingMainData ? sampleData1 : sampleData2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  bottom: 25,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildBox(const Color(0XFFFFFFFF)),
                      buildBoxText(
                        'Income',
                        const Color(0XFFFFFFFF),
                      ),
                      buildBox(const Color(0XFF01AA45)),
                      buildBoxText(
                        'Savings',
                        const Color(0XFF01AA45),
                      ),
                      buildBox(const Color(0XFFED3237)),
                      buildBoxText(
                        'Expense',
                        const Color(0XFF01AA45),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        titlesData: FlTitlesData(
          leftTitles: SideTitles(showTitles: false),
          rightTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(showTitles: false),
        ),
        lineTouchData: lineTouchData1,
        gridData: gridData,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 11,
        maxY: 4,
        minY: 0.50,
      );

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        borderData: borderData,
        minX: 0,
        maxX: 20,
        maxY: 8,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];

  LineTouchData get lineTouchData2 => LineTouchData(
        enabled: false,
      );

  FlGridData get gridData => FlGridData(
        show: false,
        drawVerticalLine: false,
        drawHorizontalLine: false,
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
        border: Border.all(
          color: Colors.transparent, // Set the color to transparent
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false, colors: [Colors.transparent]),
        colors: [Colors.green],
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 1.90),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          colors: [Colors.transparent],
        ),
        colors: [Colors.red],
        spots: const [
          FlSpot(1, 3),
          FlSpot(3, 3.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(10, 4.5),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        colors: [Colors.white],
        isCurved: true,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false, colors: [Colors.transparent]),
        spots: const [
          FlSpot(2, 3),
          FlSpot(2, 1),
          FlSpot(6, 3),
          FlSpot(10, 1.3),
          FlSpot(10, 3.9),
        ],
      );
  Widget buildSelectedYearBox(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.only(right: 180, top: 20),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isYearListVisible = !isYearListVisible;
              });
            },
            child: Container(
              width: screenSize.width * 0.25,
              height: screenSize.width * 0.10,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x00000026),
                    offset: Offset(0, 4),
                    blurRadius: 20,
                  ),
                ],
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectedYear,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFF181818),
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          if (isYearListVisible)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x00000026),
                    offset: Offset(0, 4),
                    blurRadius: 20,
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                children: yearList.map((year) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedYear = year;
                        isYearListVisible = false;
                      });
                    },
                    child: Container(
                      width: screenSize.width * 0.2,
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: Text(year),
                    ),
                  );
                }).toList(),
              ),
            ),
            ],
      ),
    );
  }

  Container buildBox(Color color) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
    );
  }

  Text buildBoxText(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
