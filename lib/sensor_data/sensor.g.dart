// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sensor _$SensorFromJson(Map<String, dynamic> json) {
  return Sensor(
    temp: (json['temperature'] as num)?.toDouble(),
    humidity: (json['humidity'] as num)?.toDouble(),
    pH: (json['pH'] as num)?.toDouble(),
    ec: (json['ec'] as num)?.toDouble(),
    light: (json['light'] as num)?.toDouble(),
    liquidTemp: (json['liquid_temperature'] as num)?.toDouble(),
    liquidFRate: (json['liquid_flow_rate'] as num)?.toDouble(),
    liquidLevel: json['liquid_level'] as bool,
    valve: json['valve'] as bool,
    led: json['led'] as bool,
    fan: json['fan'] as bool,
  );
}

Map<String, dynamic> _$SensorToJson(Sensor instance) => <String, dynamic>{
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
