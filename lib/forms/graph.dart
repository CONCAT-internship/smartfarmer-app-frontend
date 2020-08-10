import 'package:flutter/material.dart';
import 'package:smartfarm/json/week_sensor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as graphCharts;
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class Graph extends StatefulWidget {
  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  var data;

  Future<WeekSensor> getWeekSensor() async {
    try {
      String url =
          'https://asia-northeast1-superfarmers.cloudfunctions.net/DailyAverage?uuid=123e6b776f000c04&unixtime=1595116800';
      //'https://asia-northeast1-superfarmers.cloudfunctions.net/DailyAverage?uuid=${widget.sensorUUID}&unixtime=1595116800';

      final http.Response response = await http.get(url);
      final responseData = jsonDecode(response.body);
      final WeekSensor weekSensor = WeekSensor.fromJson(responseData);

      return weekSensor;
    } catch (err) {
      throw err;
    }
  }

  @override
  void initState() {
    super.initState();
    getWeekSensor();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var series = [
      new graphCharts.Series(
        id: 'sensorData',
        data: data,
        domainFn: (GraphLayout graphData, _) => graphData.day,
        measureFn: (GraphLayout graphData, _) => graphData.clicks,
        colorFn: (GraphLayout graphData, _) => graphData.color,
      )
    ];

    var chart = new graphCharts.BarChart(series,
        animate: true, animationDuration: Duration(milliseconds: 1500));

    return Container(
      child: Container(height: 180.0, child: chart),
    );
  }
}

class GraphLayout {
  final String day;
  final int clicks;
  final graphCharts.Color color;

  GraphLayout(this.day, this.clicks, Color color)
      : this.color = new graphCharts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
