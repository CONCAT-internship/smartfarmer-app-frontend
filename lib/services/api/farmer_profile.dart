import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:smartfarm/model/api_response.dart';
import 'package:smartfarm/model/farmer_model/profile_farmer.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class FarmerProfile with ChangeNotifier {
  ProfileFarmer _profileFarmer;

  ProfileFarmer getProfileFarmer() {
    return _profileFarmer;
  }

  void setProfileFarmer(ProfileFarmer profileFarmer) {
    _profileFarmer = profileFarmer;
    notifyListeners();
  }

  Future<APIResponse<ProfileFarmer>> getProfile(String uid) {
    return http.get(API + '/ProfileFarmer?uid=$uid').then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(data.bodyBytes));
        final ProfileFarmer profileFarmer = ProfileFarmer.fromJson(jsonData);
        setProfileFarmer(profileFarmer);
        return APIResponse(data: profileFarmer, error: false);
      } else {
        return APIResponse(error: true, errorMessage: '알 수 없는 에러입니다. 잠시 뒤 시도해주세요.');
      }
    });
  }
}

final farmerInfo = FarmerProfile();
