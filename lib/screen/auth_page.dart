import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/animation/fade_animation.dart';
import 'package:smartfarm/firebase/db_data/provider/database_provider.dart';
import 'package:smartfarm/firebase/db_data/provider/firebase_provider.dart';
import 'package:smartfarm/firebase/db_data/provider/mine_farmer_data.dart';
import 'package:smartfarm/screen/connect_page.dart';
import 'package:smartfarm/screen/login_page.dart';
import 'package:smartfarm/screen/signup_page.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class AuthPage extends StatelessWidget {
  FirebaseProvider fp;

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    logger.d("user: ${fp.getUser()}");

    if(fp.getUser() != null){
      return ConnectPage();
    }
//    if (fp.getUser() != null) {
//      databaseProvider
//          .linkFarmerData(fp.getUser().uid)
//          .listen((event) {
//        Provider.of<MineFarmerData>(context).setFarmerData(event);
//      });
//
//      return ConnectPage();
//    } else {
      return Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    FadeAnimation(
                      1,
                      Text(
                        "환영합니다",
                        style: TextStyle(
                          fontFamily: 'NotoSans-Bold',
                          fontSize: 32.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                      1.2,
                      Text(
                        "스마트파머는 당신의 농작물을 24시간 지킵니다. 멋진 농작물을 심을 준비가 되셨나요?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'NotoSans-Regular',
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
                FadeAnimation(
                  1.4,
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(farmer),
                    )),
                  ),
                ),
                Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.5,
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          '로그인',
                          style: TextStyle(
                            fontFamily: 'NotoSans-Medium',
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                      1.6,
                      Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          ),
                        ),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                          color: infoBoxHumidityColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            '가입하기',
                            style: TextStyle(
                              fontFamily: 'NotoSans-Medium',
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  //}
}
