// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_chart_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensorChartData _$SensorChartDataFromJson(Map<String, dynamic> json) {
  return SensorChartData(
    darkTime: (json['dark_time'] as num)?.toDouble(),
    temperature: (json['temperature'] as num)?.toDouble(),
    humidity: (json['humidity'] as num)?.toDouble(),
    pH: (json['pH'] as num)?.toDouble(),
    ec: (json['ec'] as num)?.toDouble(),
    light: (json['light'] as num)?.toDouble(),
    liquidTemp: (json['liquid_temperature'] as num)?.toDouble(),
    led: json['led'] as bool,
    fan: json['fan'] as bool,
    lightTime: (json['light_time'] as num)?.toDouble(),
    liquidLevel: json['liquid_level'] as bool,
  );
}

Map<String, dynamic> _$SensorChartDataToJson(SensorChartData instance) =>
    <String, dynamic>{
      'dark_time': instance.darkTime,
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'pH': instance.pH,
      'ec': instance.ec,
      'light': instance.light,
      'liquid_temperature': instance.liquidTemp,
      'liquid_level': instance.liquidLevel,
      'led': instance.led,
      'fan': instance.fan,
      'light_time': instance.lightTime,
    };
