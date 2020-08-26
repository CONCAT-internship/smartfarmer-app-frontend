//import 'package:intl/intl.dart';
//
//class SensorChart {
//  final String localTime;
//  final num value;
//
//  SensorChart({this.localTime, this.value,});
//
//  factory SensorChart.fromJSON(Map<String, dynamic> json) {
//    return SensorChart(
//      localTime: DateFormat('kk:mm').format(DateTime.parse(json['local_time'])),
//      value: json['temperature'].toDouble(),
//    );
//  }
//}

import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smartfarm/model/sensor_model/sensor_chart_data.dart';
part 'sensor_chart.g.dart';

@JsonSerializable()
class SensorChart{
  @JsonKey(name: 'local_time')
  final String localTime;
  final SensorChartData data;

  SensorChart({this.localTime, this.data});

  factory SensorChart.fromJson(Map<String, dynamic> json) =>
      _$SensorChartFromJson(json);

  Map<String, dynamic> toJson() => _$SensorChartToJson(this);
}