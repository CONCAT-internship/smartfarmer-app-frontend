import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smartfarm/sensor_data/sensor.dart';

class JsonTester extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    Future<Sensor> getSeonsor() async{
////      try{
////        const String url = 'jhjhjhjhjhjhjhjhjhjhhhjhjjhjhjh';
////
////        final http.Response response = await http.get(url);
////        final responseData = json.decode(response.body);
////        final Sensor sensor = Sensor.fromJson(responseData);
////
////        print(sensor.toJson());
////        return sensor;
////      } catch (err){
////        throw err;
////      }
////    }
    String sampleData =
        '{"uuid": "adsfasdf", "temperature": 33, "humidity": 77}';

    Map<String, dynamic> sensorMap = jsonDecode(sampleData);

    var sensorData = Sensor.fromJson(sensorMap);
    var jsonData = sensorData.toJson();
    return Scaffold(
      body: SafeArea(
        child: Text(
          'uuid: ${sensorData.uuid} \n temp: ${sensorData.temp} \n humidity: ${sensorData.humidity} \n $jsonData',
          textScaleFactor: 2,),
      ),
    );
  }
}
