import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:smartfarm/model/sensor_model/sensor.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class GetChartSensorData with ChangeNotifier{
  String _sensorInfo = '';
  String get sensorInfo => _sensorInfo;
  void setSensorInfo(String value){
    _sensorInfo = value;
    notifyListeners();
  }
}


