import 'package:flutter/material.dart';
import 'package:smartfarm/firebase/db_data/sensor_data.dart';

class MineSensorData extends ChangeNotifier{
  SensorData _mineSensorData;
  SensorData get data => _mineSensorData;

  void setSensorData(SensorData sensorData){
    _mineSensorData = sensorData;
    notifyListeners();
    //값이 바뀌면 위젯들에게 알림
  }
}