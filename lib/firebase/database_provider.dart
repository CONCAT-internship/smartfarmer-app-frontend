import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartfarm/shared/db_key.dart';
import 'package:smartfarm/firebase/db_data/sensor_data.dart';
import 'package:smartfarm/firebase/db_data/transfomer.dart';

import 'db_data/farmer.dart';

DatabaseProvider databaseProvider = DatabaseProvider();

class DatabaseProvider with Transfomer {
  final Firestore _firestore = Firestore.instance;

//  Stream<SensorData> linkSensorData(String sensorKey) {
//    return _firestore
//        .collection(COLLECTION_NAME)
//        .document(sensorKey)
//        .snapshots()
//        .transform(transSensorData);
//  }

  // documents 모두 갖고옴
  Stream<List<SensorData>> linkSensorUUID() {
    return _firestore
        .collection(COLLECTION_NAME)
        .snapshots()
        .transform(transSensorUUID);
  }

  Stream<Farmer> linkFarmerData(String farmerKey) {
    return _firestore
        .collection(COLLECTION_FARMER)
        .document(farmerKey)
        .snapshots()
        .transform(transFarmerData);
  }

  Future<void> createFarmer({String farmerKey, String email}) async {
    final DocumentReference farmerRef =
        _firestore.collection(COLLECTION_FARMER).document(farmerKey);
    final DocumentSnapshot snapshot = await farmerRef.get();
    return _firestore.runTransaction((Transaction tx) async {
      if (!snapshot.exists) await tx.set(farmerRef, Farmer.createMap(email));
    });
  }

  Future<Map<String, dynamic>> addSensorUUID(
      {String farmerKey, String sensorUUID}) async {
    final DocumentReference farmerRef =
        _firestore.collection(COLLECTION_FARMER).document(farmerKey);
    final DocumentSnapshot snapshot = await farmerRef.get();

    return _firestore.runTransaction((Transaction tx) async {
      if (snapshot.exists) await tx.update(farmerRef, <String, dynamic>{
        KEY_SENSOR_UUID : FieldValue.arrayUnion([sensorUUID])
      });
    });
  }

  Future<Map<String, dynamic>> delSensorUUID(
      {String farmerKey, String sensorUUID}) async {
    final DocumentReference farmerRef =
    _firestore.collection(COLLECTION_FARMER).document(farmerKey);
    final DocumentSnapshot snapshot = await farmerRef.get();

    return _firestore.runTransaction((Transaction tx) async {
      if (snapshot.exists) await tx.update(farmerRef, <String, dynamic>{
        KEY_SENSOR_UUID : FieldValue.arrayRemove([sensorUUID])
      });
    });
  }
}
