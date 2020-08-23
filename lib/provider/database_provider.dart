import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartfarm/model/farmer.dart';
import 'package:smartfarm/shared/db_key.dart';
import 'package:smartfarm/provider/transfomer.dart';


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

  Stream<Farmer> linkFarmerData(String farmerKey) {
    return _firestore
        .collection(COLLECTION_FARMER)
        .document(farmerKey)
        .snapshots()
        .transform(transFarmerData);
  }

  Future<void> createFarmer({String farmerKey, String nickName}) async {
    final DocumentReference farmerRef =
        _firestore.collection(COLLECTION_FARMER).document(farmerKey);
    final DocumentSnapshot snapshot = await farmerRef.get();
    return _firestore.runTransaction((Transaction tx) async {
      if (!snapshot.exists) await tx.set(farmerRef, Farmer.createMap(nickName));
    });
  }

  Future<Map<String, dynamic>> addSensorUUID(
      {String farmerKey, String device_uuid}) async {
    final DocumentReference farmerRef =
        _firestore.collection(COLLECTION_FARMER).document(farmerKey);
    final DocumentSnapshot snapshot = await farmerRef.get();

    return _firestore.runTransaction((Transaction tx) async {
      if (snapshot.exists) await tx.update(farmerRef, <String, dynamic>{
        KEY_SENSOR_UUID : FieldValue.arrayUnion([device_uuid])
      });
    });
  }

  Future<Map<String, dynamic>> delSensorUUID(
      {String farmerKey, String device_uuid}) async {
    final DocumentReference farmerRef =
    _firestore.collection(COLLECTION_FARMER).document(farmerKey);
    final DocumentSnapshot snapshot = await farmerRef.get();

    return _firestore.runTransaction((Transaction tx) async {
      if (snapshot.exists) await tx.update(farmerRef, <String, dynamic>{
        KEY_SENSOR_UUID : FieldValue.arrayRemove([device_uuid])
      });
    });
  }
}
