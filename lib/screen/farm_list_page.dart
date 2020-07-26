import 'package:flutter/material.dart';

class FarmListPage extends StatelessWidget {
  final String sensorUUID;

  const FarmListPage({Key key, this.sensorUUID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(sensorUUID),
    );
  }
}
