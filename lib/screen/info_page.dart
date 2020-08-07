import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/firebase/db_data/provider/mine_farmer_data.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as graphCharts;
import 'package:smartfarm/forms/graph.dart';
import 'package:smartfarm/sensor_data/sensor.dart';
import 'package:smartfarm/sensor_data/week_sensor.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:intl/intl.dart';
import 'package:smartfarm/firebase/database_provider.dart';

class InfoPage extends StatefulWidget {
  String sensorUUID;

  InfoPage({Key key, this.sensorUUID}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  Future<Sensor> getSensor() async {
//    var now = (DateTime.now().millisecondsSinceEpoch) / 1000;
//    print(DateFormat('EE').format(DateTime.now()));
//    var day = 24 * 60 * 60;
//    var lastSunStart = now % (7 * day) < (3 * day)
//        ? now - now % (7 * day) - (4 * day)
//        : now - now % (7 * day) + (3 * day);
//    print(lastSunStart);
    try {
      String url =
          'https://asia-northeast1-superfarmers.cloudfunctions.net/RecentStatus?uuid=${widget.sensorUUID}';
      final http.Response response = await http.get(url);
      final responseData = jsonDecode(response.body);
      final Sensor sensor = Sensor.fromJson(responseData);
      return sensor;
    } catch (err) {
      throw err;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: drawerKey,
      endDrawer: Drawer(
          child: SafeArea(
              child: ListView(padding: EdgeInsets.zero, children: <Widget>[]))),
      //backgroundColor: backgroundColor,
      bottomNavigationBar: _buildBottomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFloatingActionButton(context),
      body: Stack(
        children: <Widget>[
          _headerGradient(size),
          Container(
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.066,
                ),
                _headerContents(size),
                SizedBox(
                  height: 30,
                ),
                infoBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BottomAppBar _buildBottomAppBar() {
    return BottomAppBar(
      color: backgroundColor,
      //notchMargin: 12.0,
      child: Container(
        height: 50.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  drawerKey.currentState.openEndDrawer();
                },
                color: infoButtonColor,
                iconSize: 32.0,
                //size: 32.0,
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  //databaseProvider.recv();
                },
                color: Colors.grey,
                iconSize: 32.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: infoButtonColor,
      child: Icon(Icons.add),
      onPressed: () {
        Provider.of<MineFarmerData>(context, listen: false).logoutFarmer();
        //FirebaseAuth.instance.signOut();
      },
    );
  }

  Container _headerGradient(Size size) {
    return Container(
      height: size.height * 0.8,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            infoGradient1,
            infoGradient2,
          ],
          stops: [0.1, 0.5],
        ),
      ),
    );
  }

  Container _headerContents(Size size) {
    return Container(
        padding: EdgeInsets.only(
          left: 25.0,
          right: 10.0,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "슈퍼파머스",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'NotoSans-Bold',
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.notifications_none),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.menu),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/ogu.png'),
                  radius: 25.0,
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "김태훈님",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NotoSans-Bold',
                        fontSize: 19.0,
                      ),
                    ),
                    Text(
                      "당신의 농장은 잘 관리되고 있습니다.",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NotoSans-Thin',
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  Expanded infoBox() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15.0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "장치 제어",
                    style: TextStyle(
                      color: infoBoxTextColor,
                      fontFamily: 'NotoSans-Bold',
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: <Widget>[
                      InfoSession(
                        isClicked: false,
                        name: '온도',
                        subName: 'Temperature',
                        image: temperature,
                        value: '20',
                        press: () {},
                      ),
                      InfoSession(
                        isClicked: false,
                        name: '습도',
                        subName: 'humidity',
                        image: humidity,
                        value: '30',
                        press: () {},
                      ),
                      InfoSession(
                        isClicked: false,
                        name: '일조시간',
                        subName: 'Led Duration',
                        image: sun,
                        value: '5',
                        press: () {},
                      ),
                      InfoSession(
                        isClicked: false,
                        name: '산성도',
                        subName: 'pH',
                        image: ph,
                        value: '8',
                        press: () {},
                      ),
                      InfoSession(
                        isClicked: false,
                        name: '양액농도',
                        subName: 'EC',
                        image: ion,
                        value: '50',
                        press: () {},
                      ),
                      InfoSession(
                        isClicked: false,
                        name: '수온',
                        subName: 'Liquid temp',
                        image: waterTemp,
                        value: '30',
                        press: () {},
                      ),
                    ],
                  ),
//                  Container(
//                    height: 140.0,
//                    child: FutureBuilder(
//                      future: getSensor(),
//                      builder: (context, snapshot) {
//                        if (snapshot.hasData) {
//                          final sensor = snapshot.data;
//                          return ListView(
//                            scrollDirection: Axis.horizontal,
//                            children: <Widget>[
//                              _InfoCard('temperature', '온도', temp,
//                                  'Temperature', sensor.temperature.toString(), '℃'),
//                              _InfoCard('humidity', '습도', humidity, 'Humidity',
//                                  sensor.humidity.toString(), '%'),
//                              _InfoCard('ph', '산성', ph, 'pH',
//                                  sensor.pH.toString(), '%'),
//                              _InfoCard('ion', '이온', ion, 'ec',
//                                  sensor.ec.toString(), 'cc'),
//                              _InfoCard('light', '조도', sun, 'Roughness',
//                                  sensor.light.toString(), 'lx'),
//                              _InfoCard(
//                                  'waterTemp',
//                                  '수온',
//                                  waterTemp,
//                                  'Water Temperature',
//                                  sensor.liquidTemp.toString(),
//                                  '℃'),
//                              _InfoCard(
//                                  'waterFlow',
//                                  '유량',
//                                  rateOfFlow,
//                                  'Rate of flow',
//                                  sensor.liquidFRate.toString(),
//                                  'lpm'),
//                            ],
//                          );
//                        } else {
//                          return Center(
//                            child: CircularProgressIndicator(),
//                          );
//                        }
//                      },
//                    ),
//                  ),
                  SizedBox(
                    height: 30,
                  ),
                  DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 2.0,
                    dashLength: 4.0,
                    dashColor: deviderColor,
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "실시간 온도상황",
                    style: TextStyle(
                      color: infoBoxTextColor,
                      fontFamily: 'NotoSans-Bold',
                      fontSize: 15.0,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "현재 온도 ",
                        style: TextStyle(
                          color: infoBoxTextColor,
                          fontFamily: 'NotoSans-Medium',
                          fontSize: 13.0,
                        ),
                      ),
                      Text(
                        "23.1도",
                        style: TextStyle(
                          color: infoBoxResultColor,
                          fontFamily: 'NotoSans-Bold',
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                  //Graph(),
                  Container(
                    height: 180.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoSession extends StatelessWidget {
  final name;
  final subName;
  final image;
  final value;
  final bool isClicked;
  final Function press;

  const InfoSession({
    Key key,
    this.isClicked = false,
    this.name,
    this.press,
    this.subName,
    this.image,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: size.maxWidth / 2 - 60,
          decoration: BoxDecoration(
            color: isClicked ? Colors.blue : Colors.white,
            border: Border.all(width: 1.5, color: borderColor),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: press,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(
                            color: cardFontColor,
                            fontFamily: 'NotoSans-Bold',
                            fontSize: 13.0,
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 18.0,
                          height: 18.0,
                          child: Image.asset(image),
                        ),
                      ],
                    ),
                    Text(
                      subName,
                      style: TextStyle(
                        color: cardFontColor,
                        fontFamily: 'NotoSans-Regular',
                        fontSize: 10.0,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        color: cardFontColor,
                        fontFamily: 'NotoSans-Regular',
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _InfoCard extends StatelessWidget {
  final value;
  final name;
  final image;
  final subTitle;
  final upvotes;
  final unit;

  _InfoCard(this.value, this.name, this.image, this.subTitle, this.upvotes,
      this.unit);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: () {
          if (value == 'temperature') {}
        },
        child: Container(
          height: 140.0,
          width: 110.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(38.0),
              color: (subTitle != "Temperature") ? cardColor_off : null,
              gradient: (subTitle == "Temperature")
                  ? LinearGradient(
                      colors: [tempGradient1, tempGradient2],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )
                  : null,
              boxShadow: []),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16.0,
              ),
              Container(
                width: 35.0,
                height: 40.0,
                child: Image.asset(image),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                name,
                style: TextStyle(
                    color: cardFontColor, fontFamily: 'NotoSans-Bold'),
              ),
              SizedBox(
                height: 2.0,
              ),
              Text(
                subTitle,
                style: TextStyle(
                    color: cardFontColor,
                    fontSize: 10.0,
                    fontFamily: 'NotoSans-Regular'),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          upvotes,
                          style:
                              TextStyle(color: cardFontColor, fontSize: 11.0),
                        ),
                        Text(
                          unit,
                          style: TextStyle(color: cardFontColor, fontSize: 9.0),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
