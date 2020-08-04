// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_sensor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeekSensor _$WeekSensorFromJson(Map<String, dynamic> json) {
  return WeekSensor(
    sun: json['sun'] == null
        ? null
        : DayOfWeek.fromJson(json['sun'] as Map<String, dynamic>),
    mon: json['mon'] == null
        ? null
        : DayOfWeek.fromJson(json['mon'] as Map<String, dynamic>),
    tue: json['tue'] == null
        ? null
        : DayOfWeek.fromJson(json['tue'] as Map<String, dynamic>),
    wed: json['wed'] == null
        ? null
        : DayOfWeek.fromJson(json['wed'] as Map<String, dynamic>),
    thr: json['thr'] == null
        ? null
        : DayOfWeek.fromJson(json['thr'] as Map<String, dynamic>),
    fri: json['fri'] == null
        ? null
        : DayOfWeek.fromJson(json['fri'] as Map<String, dynamic>),
    sat: json['sat'] == null
        ? null
        : DayOfWeek.fromJson(json['sat'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WeekSensorToJson(WeekSensor instance) =>
    <String, dynamic>{
      'sun': instance.sun?.toJson(),
      'mon': instance.mon?.toJson(),
      'tue': instance.tue?.toJson(),
      'wed': instance.wed?.toJson(),
      'thr': instance.thr?.toJson(),
      'fri': instance.fri?.toJson(),
      'sat': instance.sat?.toJson(),
    };
