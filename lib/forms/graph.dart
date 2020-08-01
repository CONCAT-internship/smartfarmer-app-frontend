import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as graph_charts;
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class Graph extends StatefulWidget {
  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    var data = [
      GraphLayout('Mon', 20, noneGraphColor),
      GraphLayout('Tue', 30, noneGraphColor),
      GraphLayout('Web', 10, noneGraphColor),
      GraphLayout('Thr', 25, todayGraphColor),
      GraphLayout('Fri', 40, noneGraphColor),
      GraphLayout('Sat', 35, noneGraphColor),
      GraphLayout('Sun', 12, noneGraphColor),
    ];

    var series = [
      new graph_charts.Series(
        id: 'Clicks',
        data: data,
        domainFn: (GraphLayout graphData, _) => graphData.day,
        measureFn: (GraphLayout graphData, _) => graphData.clicks,
        colorFn: (GraphLayout graphData, _) => graphData.color,
      )
    ];

    var chart = new graph_charts.BarChart(series,
        animate: true, animationDuration: Duration(milliseconds: 1500));

    var chartWidget = SizedBox(height: 180.0, child: chart);

    return Container(
      child: chartWidget,
    );
  }
}


class GraphLayout {
  final String day;
  final int clicks;
  final graph_charts.Color color;

  GraphLayout(this.day, this.clicks, Color color)
      : this.color = new graph_charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
