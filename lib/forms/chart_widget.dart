import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:smartfarm/model/sensor_chart.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';
import 'package:http/http.dart' as http;


class ChartWidget extends StatefulWidget {
  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  List<SensorChart> _sensorChart = [];

  void _getChartSensor() async {
    final response = await http.post(
      '$API/LookupByNumber',
      body: jsonEncode({"uuid": "756e6b776f000c04", "key": "temperature", "number": 7}),
      headers: {'Content-Type': "application/json"},
    );

    if (response.statusCode == 200) {
      final List<SensorChart> parseResponse = jsonDecode(response.body)
          .map<SensorChart>((json) => SensorChart.fromJSON(json))
          .toList();
      setState(() {
        _sensorChart.clear();
        _sensorChart.addAll(parseResponse);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getChartSensor();
  }

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
              child: LineChart(mainData()),
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
                return this._sensorChart[0].localTime;
              case 2:
                return this._sensorChart[1].localTime;
              case 4:
                return this._sensorChart[2].localTime;
              case 6:
                return this._sensorChart[3].localTime;
              case 8:
                return this._sensorChart[4].localTime;
              case 10:
                return this._sensorChart[5].localTime;
              case 12:
                return this._sensorChart[6].localTime;
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
            FlSpot(0, this._sensorChart[0].value),
            FlSpot(2, this._sensorChart[1].value),
            FlSpot(4, this._sensorChart[2].value),
            FlSpot(6, this._sensorChart[3].value),
            FlSpot(8, this._sensorChart[4].value),
            FlSpot(10, this._sensorChart[5].value),
            FlSpot(12, this._sensorChart[6].value),
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
