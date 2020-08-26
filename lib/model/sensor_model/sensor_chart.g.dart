// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensorChart _$SensorChartFromJson(Map<String, dynamic> json) {
  return SensorChart(
    localTime: DateFormat('kk:mm').format(DateTime.parse(json['local_time'])),
    data: json['data'] == null
        ? null
        : SensorChartData.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SensorChartToJson(SensorChart instance) =>
    <String, dynamic>{
      'local_time': instance.localTime,
      'data': instance.data,
    };
