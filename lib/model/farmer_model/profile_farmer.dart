class ProfileFarmer {
  String nickName;
  List<FarmInfo> farmInfo;

  ProfileFarmer({this.nickName, this.farmInfo});

  ProfileFarmer.fromJson(Map<String, dynamic> json) {
    this.nickName = json['nickname'];
    this.farmInfo = (json['farm_info'] as List)
        ?.map((e) {
          return e == null ? null : FarmInfo.fromJson(e as Map<String, dynamic>);
        })?.toList();

  }
}

class FarmInfo {
  String deviceUUID;
  String farmName;

  FarmInfo({this.deviceUUID, this.farmName});

  FarmInfo.fromJson(Map<String, dynamic> json) {
    deviceUUID = json['device_uuid'];
    farmName = json['farm_name'];
  }
}
