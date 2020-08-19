import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class ChartWidget extends StatefulWidget {
  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(

            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 25,
          textStyle: TextStyle(
            color: chartTextColor,
            fontFamily: 'NotoSans-Regular',
            fontSize: 13.0,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '3:10';
              case 2:
                return '3:13';
              case 4:
                return '3:16';
              case 6:
                return '3:19';
              case 8:
                return '3:22';
              case 10:
                return '3:25';
              case 12:
                return '3:28';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: chartTextColor,
            fontFamily: 'NotoSans-Regular',
            fontSize: 13.0,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 10:
                return '10';
              case 16:
                return '15';
              case 24:
                return '25';
              case 30:
                return '30';

            }
            return '';
          },
          reservedSize: 12,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 12,
      minY: 10,
      maxY: 30,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 10.2),
            FlSpot(2, 15.1),
            FlSpot(4, 25.2),
            FlSpot(6, 25.1),
            FlSpot(8, 24.9),
            FlSpot(10, 25.0),
            FlSpot(12, 26.0),

          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 2,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
