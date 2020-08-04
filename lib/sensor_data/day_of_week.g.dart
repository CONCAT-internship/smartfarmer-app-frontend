// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_of_week.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayOfWeek _$DayOfWeekFromJson(Map<String, dynamic> json) {
  return DayOfWeek(
    temp: (json['temperature'] as num)?.toDouble(),
    humidity: (json['humidity'] as num)?.toDouble(),
    pH: (json['pH'] as num)?.toDouble(),
    ec: (json['ec'] as num)?.toDouble(),
    light: (json['light'] as num)?.toDouble(),
    liquidTemp: (json['liquid_temperature'] as num)?.toDouble(),
    liquidFRate: (json['liquid_flow_rate'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$DayOfWeekToJson(DayOfWeek instance) => <String, dynamic>{
      'temperature': instance.temp,
      'humidity': instance.humidity,
      'pH': instance.pH,
      'ec': instance.ec,
      'light': instance.light,
      'liquid_temperature': instance.liquidTemp,
      'liquid_flow_rate': instance.liquidFRate,
    };
