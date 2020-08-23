import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartfarm/model/farmer.dart';

class Transfomer {
  final transFarmerData = StreamTransformer<DocumentSnapshot, Farmer>.fromHandlers(
      handleData: (snapshot, sink) async {
        sink.add(Farmer.fromSnapshot(snapshot));
  });
}
