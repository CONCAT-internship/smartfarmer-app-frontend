import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as graph_charts;

class Graph extends StatefulWidget {
  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    var data = [
      Graph_layout('Mon', 20, Colors.purple),
      Graph_layout('Tue', 30, Colors.pinkAccent),
      Graph_layout('Web', 10, Colors.purple),
      Graph_layout('Thr', 25, Colors.redAccent),
      Graph_layout('Fri', 40, Colors.purple),
      Graph_layout('Sat', 35, Colors.blue),
      Graph_layout('Sun', 12, Colors.purple),
    ];

    var series = [
      new graph_charts.Series(
        id: 'Clicks',
        data: data,
        domainFn: (Graph_layout graph_data, _) => graph_data.day,
        measureFn: (Graph_layout graph_data, _) => graph_data.clicks,
        colorFn: (Graph_layout graph_data, _) => graph_data.color,
      )
    ];

    var chart = new graph_charts.BarChart(series,
        animate: true, animationDuration: Duration(milliseconds: 1500));

    var chartWidget = Padding(
      padding: EdgeInsets.all(32.0),
      child: SizedBox(height: 180.0, child: chart),
    );

    return Container(
      child: chartWidget,
    );
  }
}

class Graph_layout {
  final String day;
  final int clicks;
  final graph_charts.Color color;

  Graph_layout(this.day, this.clicks, Color color)
      : this.color = new graph_charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
