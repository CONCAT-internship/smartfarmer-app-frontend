import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:smartfarm/model/api_response.dart';
import 'package:smartfarm/model/farmer_model/profile_farmer.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class FarmerProfile with ChangeNotifier {

  bool isLoading = true;

  ProfileFarmer _profileFarmer = new ProfileFarmer();
  List<FarmInfo> list = new List();

  FarmerProfile(){
    _profileFarmer.farmInfo = list;
  }

  setFarmerProfile(ProfileFarmer data){
    _profileFarmer = data;
    isLoading = false;
    notifyListeners();
  }

  ProfileFarmer getFarmerProfile(){
    return _profileFarmer;
  }

  Future<ProfileFarmer> getProfile(String uid) {
    return http.get(API + '/ProfileFarmer?uid=$uid').then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(data.bodyBytes));
        final ProfileFarmer profileFarmer = ProfileFarmer.fromJson(jsonData);
        return profileFarmer;
      } else {
        return null;
      }
    });
  }
}
