import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/firebase/database_provider.dart';
import 'package:smartfarm/firebase/db_data/sensor_data.dart';

class SensorListPage extends StatelessWidget {
  final List<String> uuid = List.generate(10, (i) => 'Sensor uuid $i');

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<SensorData>>(
      create: (context) => databaseProvider.linkSensorUUID(),
      child: Consumer<List<SensorData>>(
        builder: (context, uuidList, child){
          return Material(
            child: SafeArea(
              child: ListView.separated(
                  itemCount: uuidList == null ? 0 : uuidList.length,
                  itemBuilder: (context, index){
                    return _tile(uuidList[index]);
                  },

                  separatorBuilder: (context, index){
                    return Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                    );
                  },
              ),
            ),
          );
        },
      ),
    );
  }

  ListTile _tile(SensorData sensorData){
    return ListTile(
      title: Text(sensorData.uuid),
    );
  }
}
