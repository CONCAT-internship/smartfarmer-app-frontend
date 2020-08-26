import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/services/api/farmer_profile.dart';
import 'package:smartfarm/services/firebase_provider.dart';
import 'package:smartfarm/services/scan_data.dart';
import 'package:smartfarm/screens/auth/auth_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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

