import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/firebase/db_data/provider/mine_farmer_data.dart';
import 'package:smartfarm/firebase/db_data/provider/scan_data.dart';
import 'package:smartfarm/screen/auth_page.dart';
import 'firebase/db_data/provider/firebase_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MineFarmerData>(
          create: (_) => MineFarmerData(),
        ),
        ChangeNotifierProvider<FirebaseProvider>(
          create: (_) => FirebaseProvider(),
        ),
        ChangeNotifierProvider<ScanData>(
          create: (_) => ScanData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
      ),
    );
  }
}

