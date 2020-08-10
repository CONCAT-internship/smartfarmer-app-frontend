import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm/firebase/db_data/farmer.dart';

class MineFarmerData extends ChangeNotifier {
  Farmer _mineFarmerData;
  Farmer get data => _mineFarmerData;

  MineFarmerStatus _mineFarmerStatus = MineFarmerStatus.progress;
  MineFarmerStatus get status => _mineFarmerStatus;

  void setFarmerData(Farmer farmer) {
    _mineFarmerData = farmer;
    _mineFarmerStatus = MineFarmerStatus.exist;
    notifyListeners();
    //값이 바뀌면 위젯들에게 알림
  }
  void setFarmerStatus(MineFarmerStatus status) {
    _mineFarmerStatus = status;
    notifyListeners();
  }
  void logoutFarmer() {
    _mineFarmerData = null;
    _mineFarmerStatus = MineFarmerStatus.none;
    notifyListeners();
  }
}

enum MineFarmerStatus { progress, none, exist }
