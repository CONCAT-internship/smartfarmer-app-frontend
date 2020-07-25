import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartfarm/firebase/db_data/farmer.dart';
import 'package:smartfarm/firebase/db_data/sensor_data.dart';

class Transfomer {
//  final transSensorData =
//  StreamTransformer<DocumentSnapshot, SensorData>.fromHandlers(
//      handleData: (snapshot, sink) async {
//        sink.add(SensorData.fromSnapshot(snapshot));
//        //snapshot을 SensorData로 변환
//      });
//
//  final transSensorUUID =
//  StreamTransformer<QuerySnapshot, List<SensorData>>.fromHandlers(
//      handleData: (snapshot, sink) async {
//        List<SensorData> sensors = [];
//        snapshot.documents.forEach((doc){
//          sensors.add(SensorData.fromSnapshot(doc));
//        });
//        sink.add(sensors);
//      }
//  );

  final transFarmerData =
      StreamTransformer<DocumentSnapshot, Farmer>.fromHandlers(
          handleData: (snapshot, sink) async {
    sink.add(Farmer.fromSnapshot(snapshot));
    //snapshot을 SensorData로 변환
  });
}
