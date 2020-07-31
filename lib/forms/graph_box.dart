import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smartfarm/forms/graph.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';
import 'package:smartfarm/sensor_data/json_tester.dart';
import 'package:smartfarm/sensor_data/sensor.dart';

class Graph_Box extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String sampleData =
        '{"uuid": "adsfasdf", "temperature": 33, "humidity": 77}';

    Map<String, dynamic> sensorMap = jsonDecode(sampleData);

    var sensorData = Sensor.fromJson(sensorMap);
    var jsonData = sensorData.toJson();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //음 뭐하지 ...? 뭘 추가해야할까?
        Padding(
          padding: EdgeInsets.only(top: 30, right: 25.0, left: 25.0),
          child: Container(
            width: double.infinity,
            height: 370,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0.0, 3.0),
                    blurRadius: 15.0,
                  ),
                ]),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(smartfarmer_padding),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            '30.0',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                          ),
                          Text(
                            '현재 온도',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                //Graph(),
                //JsonTester(),
                Text(
                  'uuid: ${sensorData.uuid} \n temp: ${sensorData.temp} \n humidity: ${sensorData.humidity} \n $jsonData',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
