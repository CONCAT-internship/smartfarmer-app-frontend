import 'dart:ui';
import 'package:flutter/material.dart';

const API = 'https://asia-northeast1-superfarmers.cloudfunctions.net';

final notoSansBold = TextStyle(
  color: Colors.white,
  fontFamily: 'NotoSans-Bold',
);

final notoSansRegular = TextStyle(
  color: Colors.white,
  fontFamily: 'NotoSans-Regular',
);

final notoSansMedium = TextStyle(
  color: Colors.white,
  fontFamily: 'NotoSans-Medium',
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

/* 농장 선택 페이지 */
Color blueGradient1 = Color(0xff52b2f0);
Color blueGradient2 = Color(0xff4968d3);
Color primaryTextColor = Color(0xFF414C6B);
Color secondaryTextColor = Color(0xFFE4979E);

/* 농장 실시간 정보 페이지 */
Color infoButtonColor = Color.fromRGBO(52, 139, 123, 1);
Color backgroundColor = Color.fromRGBO(239, 239, 239, 1);
Color infoGradient1 = Color.fromRGBO(73, 83, 207, 1);
Color infoGradient2 = Color.fromRGBO(134, 13, 255, 1);
Color cardFontColor = Color.fromRGBO(51, 51, 51, 1);
Color deviderColor = Color.fromRGBO(235, 235, 235, 1);
Color infoBoxTextColor = Color.fromRGBO(0, 59, 73, 1);
Color infoBoxResultColor = Color.fromRGBO(73, 51, 0, 1);
Color borderColor = Color.fromRGBO(224, 224, 224, 1);
Color infoBoxTempColor = Color.fromRGBO(64, 78, 255, 1);
Color infoBoxTempColorBlur = Color.fromRGBO(144, 150, 255, 0.5);
Color infoBoxHumidityColor = Color.fromRGBO(255, 165, 66, 1);
Color infoBoxLedColor = Color.fromRGBO(122, 108, 255, 1);

/* 농장 등록 페이지 (QR) */
Color tutorialFontColor = Color.fromRGBO(183, 183, 183, 1);
Color fieldLineColor = Color.fromRGBO(73, 83, 207, 1);
Color fieldTextColor = Color.fromRGBO(51, 51, 51, 1);

var farmer = 'assets/images/farmer.png';
var farmerWomen = 'assets/images/farmer_women.png';
var seed = 'assets/images/seed.png';

var temperature = 'assets/images/temperature.png';
var humidity = 'assets/images/humidity.png';
var sun = 'assets/images/sun.png';
var ion = 'assets/images/ion.png';
var ph = 'assets/images/pH.png';
var waterTemp = 'assets/images/water_temp.png';
var rateOfFlow = 'assets/images/rate_of_flow.png';
var facebook = 'assets/images/facebook.jpg';
var kakaoTalk = 'assets/images/kakao-talk.png';

var wTemperature = 'assets/images/temperature_w.png';
var wHumidity = 'assets/images/humidity_w.png';
var wSun = 'assets/images/sun_w.png';
var wIon = 'assets/images/ion_w.png';
var wPh = 'assets/images/ph_w.png';
var wWaterTemp = 'assets/images/water_temp_w.png';

var qrCodeImg = 'assets/images/QRcode.png';
var farmName = 'assets/images/farm_name.png';