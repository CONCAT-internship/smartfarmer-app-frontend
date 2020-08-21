import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartfarm/shared/db_key.dart';

class Farmer {
  final String farmerKey;
  final List<dynamic> deviceUUID;
  final DocumentReference reference;

  Farmer.fromMap(Map<String, dynamic> map, this.farmerKey, {this.reference})
      : deviceUUID = map[KEY_SENSOR_UUID];

  Farmer.fromSnapshot(DocumentSnapshot ds)
      : this.fromMap(
          ds.data,
          ds.documentID,
          reference: ds.reference,
        );

  static Map<String, dynamic> createMap(String nickName) {
    Map<String, dynamic> map = Map();
    map[KEY_NICKNAME] = nickName;
    map[KEY_SENSOR_UUID] = [];
    return map;
  }
}
