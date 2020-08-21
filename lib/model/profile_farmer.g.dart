// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_farmer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileFarmer _$ProfileFarmerFromJson(Map<String, dynamic> json) {
  return ProfileFarmer(
    nickName: json['nick_name'] as String,
    farmInfo: (json['farm_info'] as List)
        ?.map((e) =>
            e == null ? null : FarmInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProfileFarmerToJson(ProfileFarmer instance) =>
    <String, dynamic>{
      'nick_name': instance.nickName,
      'farm_info': instance.farmInfo,
    };
