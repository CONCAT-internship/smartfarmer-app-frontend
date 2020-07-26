import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/firebase/database_provider.dart';
import 'package:smartfarm/firebase/db_data/provider/mine_farmer_data.dart';
import 'package:smartfarm/firebase/db_data/sensor_data.dart';
import 'package:smartfarm/screen/farm_list_page.dart';

class SensorListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<SensorData>>(
      create: (context) => databaseProvider.linkSensorUUID(),
      child: Consumer<List<SensorData>>(
        builder: (context, uuidList, child) {
          return Material(
            child: SafeArea(
              child: ListView.separated(
                itemCount: uuidList == null ? 0 : uuidList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(uuidList[index].uuid),
                    onTap: () {
                      //databaseProvider.addSensorUUID(),
                      databaseProvider.addSensorUUID(
                          farmerKey: Provider.of<MineFarmerData>(context,
                                  listen: false)
                              .data
                              .farmerKey,
                          sensorUUID: uuidList[index].uuid);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FarmListPage(),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
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
}
