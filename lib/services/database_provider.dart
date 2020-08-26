import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartfarm/model/farmer_model/farmer.dart';
import 'package:smartfarm/shared/db_key.dart';
import 'package:smartfarm/utils/transfomer.dart';

DatabaseProvider databaseProvider = DatabaseProvider();

class DatabaseProvider with Transfomer {
  final Firestore _fireStore = Firestore.instance;

  Stream<Farmer> linkFarmerData(String farmerKey) {
    return _fireStore
        .collection(COLLECTION_FARMER)
        .document(farmerKey)
        .snapshots()
        .transform(transFarmerData);
  }

  Future<void> createFarmer({String farmerKey, String nickName}) async {
    final DocumentReference farmerRef =
        _fireStore.collection(COLLECTION_FARMER).document(farmerKey);
    final DocumentSnapshot snapshot = await farmerRef.get();
    return _fireStore.runTransaction((Transaction tx) async {
      if (!snapshot.exists) await tx.set(farmerRef, Farmer.createMap(nickName));
    });
  }

  Future<Map<String, dynamic>> addSensorUUID(
      {String farmerKey, String deviceUUID}) async {
    final DocumentReference farmerRef =
        _fireStore.collection(COLLECTION_FARMER).document(farmerKey);
    final DocumentSnapshot snapshot = await farmerRef.get();

    return _fireStore.runTransaction((Transaction tx) async {
      if (snapshot.exists)
        await tx.update(farmerRef, <String, dynamic>{
          KEY_SENSOR_UUID: FieldValue.arrayUnion([deviceUUID])
        });
    });
  }

  Future<Map<String, dynamic>> delSensorUUID(
      {String farmerKey, String deviceUUID}) async {
    final DocumentReference farmerRef =
        _fireStore.collection(COLLECTION_FARMER).document(farmerKey);
    final DocumentSnapshot snapshot = await farmerRef.get();

    return _fireStore.runTransaction((Transaction tx) async {
      if (snapshot.exists)
        await tx.update(farmerRef, <String, dynamic>{
          KEY_SENSOR_UUID: FieldValue.arrayRemove([deviceUUID])
        });
    });
  }
}
