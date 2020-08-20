import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/model/farmer.dart';

class MineFarmerData extends ChangeNotifier {
  Farmer _mineFarmerData;
  Farmer get data => _mineFarmerData;

  void setFarmerData(Farmer farmer) {
    _mineFarmerData = farmer;
    notifyListeners();
    //값이 바뀌면 위젯들에게 알림
  }
}

