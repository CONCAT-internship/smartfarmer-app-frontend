import 'package:json_annotation/json_annotation.dart';
import 'farm_info.dart';

part 'profile_farmer.g.dart';

@JsonSerializable()
class ProfileFarmer {
  @JsonKey(name: 'nickname')
  final String nickName;
  @JsonKey(name: 'farm_info')
  final List<FarmInfo> farmInfo;

  ProfileFarmer({this.nickName, this.farmInfo});

  factory ProfileFarmer.fromJson(Map<String, dynamic> json) =>
      _$ProfileFarmerFromJson(json);
}
