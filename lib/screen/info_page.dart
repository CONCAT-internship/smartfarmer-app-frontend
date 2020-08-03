import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/firebase/db_data/provider/mine_farmer_data.dart';
import 'package:http/http.dart' as http;
import 'package:smartfarm/forms/graph.dart';
import 'package:smartfarm/sensor_data/sensor.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:smartfarm/firebase/database_provider.dart';

class InfoPage extends StatefulWidget {
  String sensorUUID;
  InfoPage({Key key, this.sensorUUID}) : super(key : key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {

  Future<Sensor> getSeonsor() async{
    try{
      String url = 'https://asia-northeast1-superfarmers.cloudfunctions.net/RecentStatus?uuid=${widget.sensorUUID}';
      final http.Response response = await http.get(url);
      final responseData = json.decode(response.body);
      final Sensor sensor = Sensor.fromJson(responseData);

      return sensor;
    } catch (err){
      throw err;
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
                  icon: Icon(Icons.menu),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.notifications_none),
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
                  backgroundImage:
                  AssetImage('assets/images/ogu.png'),
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
      child: SingleChildScrollView(
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
              ]),
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
                Container(
                  height: 140.0,
                  child: FutureBuilder(
                    future: getSeonsor(),
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        final sensor = snapshot.data;
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            _InfoCard('온도', temp, 'Temperature', sensor.temp.toString(), '℃'),
                            _InfoCard('습도', humidity, 'Humidity', sensor.humidity.toString(), '%'),
                            _InfoCard('산성', ph, 'pH', sensor.pH.toString(), '%'),
                            _InfoCard('이온', ion, 'ec', sensor.ec.toString(), 'cc'),
                            _InfoCard('조도', sun, 'Roughness', sensor.light.toString(), 'lx'),
                            _InfoCard('수온', waterTemp, 'Water Temperature', sensor.liquidTemp.toString(), '℃'),
                            _InfoCard('유량', rateOfFlow, 'Rate of flow', sensor.liquidFRate.toString(), 'lpm'),
                          ],
                        );
                      } else {
                        return Center(child: CircularProgressIndicator(),);
                      }
                    },
                  ),
                ),
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
                      "25.0도",
                      style: TextStyle(
                        color: infoBoxResultColor,
                        fontFamily: 'NotoSans-Bold',
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
                Graph(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final name;
  final image;
  final subTitle;
  final upvotes;
  final unit;

  _InfoCard(this.name, this.image, this.subTitle, this.upvotes, this.unit);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        height: 140.0,
        width: 110.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38.0),
          color: cardColor_off,
        ),
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
              style:
                  TextStyle(color: cardFontColor, fontFamily: 'NotoSans-Bold'),
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
                        style: TextStyle(color: cardFontColor, fontSize: 11.0),
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
    );
  }
}
