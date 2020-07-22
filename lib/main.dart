import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/screen/info_page.dart';
import 'package:smartfarm/screen/auth_page.dart';

import 'package:smartfarm/utils/progress_indicator.dart';
import 'screen/info_page.dart';

//void main() => runApp(ChangeNotifierProvider<MySensorData>(
//    create: (context) => MySensorData(), child: MyApp()));

void main() => runApp(MyApp());

bool login_Checker = true;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartFarmer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: InfoPage(),

      home: StreamBuilder<FirebaseUser>(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          //User가 로그인한 경우 Stream을 통해서 <FirebaseUser>정보를 준다. 로그아웃 된 상태라면 Stream을 통해 NULL값을 준다.
          builder: (context, snapshot) {
            if (login_Checker) {
              login_Checker = false;
              return Progress_Indicator();
            } else {
              if (snapshot.hasData) {
                //데이터가 있다는 것은 유저가 있다는 것.
                return InfoPage();
              }
              return AuthPage();
            }
          }),
    );
  }
}
