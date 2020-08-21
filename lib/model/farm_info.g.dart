// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farm_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FarmInfo _$FarmInfoFromJson(Map<String, dynamic> json) {
  return FarmInfo(
    json['device_uuid'] as String,
    json['farm_name'] as String,
  );
}

Map<String, dynamic> _$FarmInfoToJson(FarmInfo instance) => <String, dynamic>{
      'device_uuid': instance.deviceUUID,
      'farm_name': instance.farmName,
    };
