import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartfarm/constants/db_key.dart';
import 'package:smartfarm/firebase/db_data/sensor_data.dart';
import 'package:smartfarm/firebase/db_data/transfomer.dart';

DatabaseProvider databaseProvider = DatabaseProvider();

class DatabaseProvider with Transfomer {
  final Firestore _firestore = Firestore.instance;

  Stream<SensorData> linkSensorData(String sensorKey) {
    return _firestore
        .collection(COLLECTION_NAME)
        .document(sensorKey)
        .snapshots()
        .transform(transSensorData);
  }

  Stream<List<SensorData>> linkSensorUUID() {
    return _firestore
        .collection(COLLECTION_NAME)
        .snapshots()
        .transform(transSensorUUID);
  }
}
