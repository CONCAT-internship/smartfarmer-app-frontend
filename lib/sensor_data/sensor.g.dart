// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sensor _$SensorFromJson(Map<String, dynamic> json) {
  return Sensor(
    json['uuid'] as String,
    (json['temperature'] as num)?.toDouble(),
    (json['humidity'] as num)?.toDouble(),
    (json['pH'] as num)?.toDouble(),
    (json['ec'] as num)?.toDouble(),
    (json['light'] as num)?.toDouble(),
    (json['liquid_temperature'] as num)?.toDouble(),
    (json['liquid_flow_rate'] as num)?.toDouble(),
    json['liquid_level'] as bool,
    json['valve'] as bool,
    json['led'] as bool,
    json['fan'] as bool,
  );
}

Map<String, dynamic> _$SensorToJson(Sensor instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'temperature': instance.temp,
      'humidity': instance.humidity,
      'pH': instance.pH,
      'ec': instance.ec,
      'light': instance.light,
      'liquid_temperature': instance.liquidTemp,
      'liquid_flow_rate': instance.liquidFRate,
      'liquid_level': instance.liquidLevel,
      'valve': instance.valve,
      'led': instance.led,
      'fan': instance.fan,
    };
