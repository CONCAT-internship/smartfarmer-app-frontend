import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartfarm/shared/db_key.dart';

class SensorData {
  final String sensorKey;
  final String uuid; // 아두이노 기기 고유번호
  final double temp; // 온도
  final double humidity; // 습도
  final double pH; // 배양액 산성
  final double ec; // 배양액 이온
  final double light; // 조도
  final double liquidTemp; // 수온
  final double liquidFRate; // 유량
  final bool liquidLevel; // 수위
  final bool valve; // 수위
  final bool led; // LED
  final bool fan;
  final DocumentReference reference;

  SensorData.fromMap(Map<String, dynamic> map, this.sensorKey, {this.reference})
      : uuid = map[KEY_UUID],
        temp = map[KEY_TEMPERATURE],
        humidity = map[KEY_HUMIDITY],
        pH = map[KEY_PH],
        ec = map[KEY_EC],
        light = map[KEY_LIGHT],
        liquidTemp = map[KEY_LIQUID_TEMPERATURE],
        liquidFRate = map[KEY_LIQUID_FLOW_RATE],
        liquidLevel = map[KEY_LIQUID_LEVEL],
        valve = map[KEY_VALVE],
        led = map[KEY_LED],
        fan = map[KEY_FAN];

  SensorData.fromSnapshot(DocumentSnapshot ds)
      : this.fromMap(
          ds.data,
          ds.documentID,
          reference: ds.reference,
        );


}
