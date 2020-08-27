import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:smartfarm/model/sensor_model/sensor_chart.dart';
import 'package:smartfarm/services/api/get_chart_sensor_data.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';
import 'package:http/http.dart' as http;

class ChartWidget extends StatefulWidget {
  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  List<SensorChart> _sensorChart = [];

  void _getChartSensor() async {
    try {
      final response = await http.post(
        '$API/LookupByNumber',
        body: jsonEncode({"uuid": "756e6b776f000c04", "number": 7}),
        headers: {'Content-Type': "application/json"},
      );

      if (response.statusCode == 200) {
        final List<SensorChart> parseResponse = jsonDecode(response.body)
            .map<SensorChart>((json) => SensorChart.fromJson(json))
            .toList();
        setState(() {
          _sensorChart.clear();
          _sensorChart.addAll(parseResponse);
        });
      }
    } catch (err) {
      throw err;
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
    final chartData = Provider.of<GetChartSensorData>(context);
    double minY = 10, maxY = 30;

    List<FlSpot> humidityList = [
      for (int i = 0; i < this._sensorChart.length; i++)
        FlSpot((i).toDouble(), this._sensorChart[i].data.humidity),
    ];

    List<FlSpot> temperatureList = [
      for (int i = 0; i < this._sensorChart.length; i++)
        FlSpot((i).toDouble(), this._sensorChart[i].data.temperature),
    ];

    List<FlSpot> lightTimeList = [
      for (int i = 0; i < this._sensorChart.length; i++)
        FlSpot((i).toDouble(), this._sensorChart[i].data.lightTime),
    ];

    List<FlSpot> pHList = [
      for (int i = 0; i < this._sensorChart.length; i++)
        FlSpot((i).toDouble(), this._sensorChart[i].data.pH),
    ];

    List<FlSpot> ecList = [
      for (int i = 0; i < this._sensorChart.length; i++)
        FlSpot((i).toDouble(), this._sensorChart[i].data.ec),
    ];

    List<FlSpot> liquidTempList = [
      for (int i = 0; i < this._sensorChart.length; i++)
        FlSpot((i).toDouble(), this._sensorChart[i].data.liquidTemp),
    ];

    List<FlSpot> currentList = temperatureList;

    switch (chartData.sensorInfo) {
      case 'temperature':
        minY = 5;
        maxY = 30;
        currentList = temperatureList;
        break;
      case 'humidity':
        minY = 40;
        maxY = 80;
        currentList = humidityList;
        break;
      case 'lightTime':
        minY = 0;
        maxY = 24;
        currentList = lightTimeList;
        break;
      case 'pH':
        minY = -1;
        maxY = 8;
        currentList = pHList;
        break;
      case 'ec':
        minY = 0;
        maxY = 2;
        currentList = ecList;
        break;
      case 'liquidTemp':
        minY = 10;
        maxY = 30;
        currentList = liquidTempList;
        break;
    }

    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: LineChart(
                LineChartData(
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
                            return this._sensorChart[0].localTime ?? '';
                          case 1:
                            return this._sensorChart[1].localTime ?? '';
                          case 2:
                            return this._sensorChart[2].localTime ?? '';
                          case 3:
                            return this._sensorChart[3].localTime ?? '';
                          case 4:
                            return this._sensorChart[4].localTime ?? '';
                          case 5:
                            return this._sensorChart[5].localTime ?? '';
                          case 6:
                            return this._sensorChart[6].localTime ?? '';
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
                        fontSize: 10.0,
                      ),
                      getTitles: (value) {
                        print('value?? $value');
                        switch (value.toInt()) {
                          case 0:
                            return '0';
                          case 2:
                            return '2';
                          case 4:
                            return '4';
                          case 6:
                            return '6';
                          case 8:
                            return '8';
                          case 10:
                            return '10';
                          case 15:
                            return '15';
                          case 20:
                            return '20';
                          case 24:
                            return '25';
                          case 25:
                            return '25';
                          case 30:
                            return '30';
                          case 40:
                            return '40';
                          case 50:
                            return '50';
                          case 60:
                            return '60';
                          case 70:
                            return '70';
                          case 80:
                            return '80';
                        }
                        return '';
                      },
                      reservedSize: 12,
                      margin: 12,
                    ),
                  ),
                  borderData: FlBorderData(
                      show: false,
                      border:
                      Border.all(color: const Color(0xff37434d), width: 1)),
                  minX: 0,
                  maxX: 6,
                  minY: minY,
                  maxY: maxY,
                  lineBarsData: [
                    LineChartBarData(
                      spots: currentList,
                      isCurved: true,
                      colors: gradientColors,
                      barWidth: 2,
                      isStrokeCapRound: false,
                      dotData: FlDotData(
                        show: true,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        colors: gradientColors
                            .map((color) => color.withOpacity(0.3))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
