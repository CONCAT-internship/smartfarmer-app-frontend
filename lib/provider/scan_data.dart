import 'package:flutter/foundation.dart';

class ScanData with ChangeNotifier{
  String _deviceUUID = '';
  String get deviceUUID => _deviceUUID;
  void setDeviceUUID(String deviceUUID){
    _deviceUUID = deviceUUID;
    notifyListeners();
  }

  bool _isScan = false;
  bool get isScan => _isScan;
  void setScan(bool value){
    _isScan = value;
    notifyListeners();
  }

  bool _isFan = false;
  bool get isFan => _isFan;
  void setFan(bool value){
    _isFan = value;
    notifyListeners();
  }
}