class ProfileFarmer {
  final String nickName;
  final List<FarmInfo> farmInfo;

  ProfileFarmer({this.nickName, this.farmInfo});

  factory ProfileFarmer.fromJson(Map<String, dynamic> json) {
    return ProfileFarmer(
      nickName: json['nickname'],
      farmInfo: (json['farm_info'] as List)
          .map((e) => e == null ? null : FarmInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class FarmInfo {
  final String deviceUUID;
  final String farmName;

  FarmInfo({this.deviceUUID, this.farmName});

  factory FarmInfo.fromJson(Map<String, dynamic> json) {
    return FarmInfo(
      deviceUUID: json['device_uuid'],
      farmName: json['farm_name'],
    );
  }
}
