import 'package:json_annotation/json_annotation.dart';

part 'farm_info.g.dart';

@JsonSerializable()
class FarmInfo {
  @JsonKey(name: 'device_uuid')
  final String deviceUUID;
  @JsonKey(name: 'farm_name')
  final String farmName;

  FarmInfo(this.deviceUUID, this.farmName);

  factory FarmInfo.fromJson(Map<String, dynamic> json) => _$FarmInfoFromJson(json);

}
