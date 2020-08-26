import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smartfarm/model/farmer_model/profile_farmer.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class FarmerProfile{
  Future<ProfileFarmer> getProfile(String uid) {
    return http
        .get(API + '/ProfileFarmer?uid=$uid')
        .then((data) {
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

final farmerInfo = FarmerProfile();
