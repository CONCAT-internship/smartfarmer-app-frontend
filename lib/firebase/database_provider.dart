import 'package:cloud_firestore/cloud_firestore.dart';

DatabaseProvider databaseProvider = DatabaseProvider();

class DatabaseProvider {
  Future<void> send() {
    return Firestore.instance
        .collection('Farmer')
        .document()
        .setData({'email': 'test@naver.com', 'sensor_uuid': '00441122'});
  }

  Future<dynamic> recv() {
    Firestore.instance
        .collection('Farmer')
        .document('1')
        .get()
        .then((DocumentSnapshot recv_data) => print(recv_data.data));
  }
}
