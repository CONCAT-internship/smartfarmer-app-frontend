import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/firebase/database_provider.dart';
import 'package:smartfarm/firebase/db_data/provider/mine_farmer_data.dart';
import 'package:smartfarm/screen/info_page.dart';
import 'package:smartfarm/screen/sensor_list_page.dart';
import 'package:smartfarm/screen/sign_in.dart';
import 'package:smartfarm/utils/progress_indicator.dart';
import 'screen/info_page.dart';

void main() => runApp(ChangeNotifierProvider<MineFarmerData>(
    create: (context) => MineFarmerData(), child: MyApp()));

bool isItFirstData = true;
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot){
          if(isItFirstData){
            isItFirstData = false;
            return Progress_Indicator();
          } else{
            if(snapshot.hasData){
              databaseProvider.createFarmer(farmerKey: snapshot.data.uid, email: snapshot.data.email);
              var myUserData = Provider.of<MineFarmerData>(context);
              databaseProvider.linkFarmerData(snapshot.data.uid).listen((event) {
                myUserData.setFarmerData(event);
              });
              return InfoPage();
            }
            return SignIn();
          }
        }),



//      Consumer<MineFarmerData>(
//        builder: (context, farmerData, child) {
//          switch (farmerData.status) {
//            case MineFarmerStatus.progress:
//              FirebaseAuth.instance.currentUser().then((firebaseFarmer) {
//                if (firebaseFarmer == null)
//                  farmerData.setFarmerStatus(MineFarmerStatus.none);
//                else
//                  databaseProvider
//                      .linkFarmerData(firebaseFarmer.uid)
//                      .listen((farmer) {
//                    farmerData.setFarmerData(farmer);
//                  });
//              });
//              return Progress_Indicator();
//            case MineFarmerStatus.exist:
//              return InfoPage();
//
//            default:
//              return SignIn();
//          }
//        },
//      ),
    );
  }
}
