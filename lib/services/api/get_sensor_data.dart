import 'dart:convert';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:smartfarm/model/sensor_model/sensor.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class GetSensorData {
  Future<Sensor> getSensor(String uuid) async {
    try {
      print(uuid);
      String url = '$API/RecentStatus?uuid=$uuid';
      final http.Response response = await http.get(url);
      final responseData = jsonDecode(response.body);
      final Sensor sensor = Sensor.fromJson(responseData);
      return sensor;
    } catch (err) {
      throw err;
    }
  }
}

final sensorData = GetSensorData();
