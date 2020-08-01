import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/firebase/database_provider.dart';
import 'package:smartfarm/firebase/db_data/provider/mine_farmer_data.dart';
import 'package:smartfarm/screen/auth_page.dart';
import 'package:smartfarm/screen/info_page.dart';
import 'package:smartfarm/screen/sensor_list_page.dart';
import 'package:smartfarm/screen/sign_in.dart';
import 'package:smartfarm/sensor_data/json_tester.dart';
import 'package:smartfarm/utils/progress_indicator.dart';
import 'shared/smartfarmer_constants.dart';
import 'screen/info_page.dart';

void main() => runApp(ChangeNotifierProvider<MineFarmerData>(
    create: (context) => MineFarmerData(), child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InfoPage(),
//      home: Consumer<MineFarmerData>(
//        builder: (context, farmerData, child) {
//          switch (farmerData.status) {
//            case MineFarmerStatus.progress:
//              FirebaseAuth.instance.currentUser().then((firebaseFarmer) {
//                if (firebaseFarmer == null)
//                  farmerData.setFarmerStatus(MineFarmerStatus.none);
//                else
//                  databaseProvider
//                      .linkFarmerData(firebaseFarmer.uid)
//                      .listen((event) {
//                    farmerData.setFarmerData(event);
//                  });
//              });
//              return Progress_Indicator();
//            case MineFarmerStatus.exist:
//              //return SensorListPage();
//              return SensorListPage();
//            default:
//              return AuthPage();
//          }
//        },
//      ),
    );
  }
}
