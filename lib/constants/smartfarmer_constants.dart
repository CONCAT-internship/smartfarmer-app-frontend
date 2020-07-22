import 'dart:ui';

import 'package:flutter/material.dart';

const Color smartfarmer_primarycolor = Color.fromRGBO(56, 182, 60, 1);//Color(0xFF0C9869);
const Color smartfarmer_bgcolor = Color.fromRGBO(244, 244, 244, 1);
const double smartfarmer_padding = 25.0;
const double smartfarmer_auth_padding = 30.0;

var appBarColor = Color(0xFF17294b);

var bgColor = Color(0xFF0d193a);
var buttonColor = Color(0xFF1b335d);

var blueGradient1 = Color(0xff52b2f0);
var blueGradient2 = Color(0xff4968d3);

var login_Gradient1 = Color(0xFF73AEF5);
var login_Gradient2 = Color(0xFF61A4F1);
var login_Gradient3 = Color(0xFF478DE0);
var login_Gradient4 = Color(0xFF398AE5);

var pinkGradient1 = Color(0xfffc6d86);
var pinkGradient2 = Color(0xfffed0d1);


var temp = 'assets/images/temp.png';
var humidity = 'assets/images/humidity.png';
var sun = 'assets/images/sun.png';
var facebook = 'assets/images/facebook.jpg';
var kakaotalk = 'assets/images/kakao-talk.png';


final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

