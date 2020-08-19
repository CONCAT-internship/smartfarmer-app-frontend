import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:smartfarm/forms/chart_widget.dart';
import 'package:smartfarm/json/sensor.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';
import 'package:http/http.dart' as http;

class DashBoardWidget extends StatefulWidget {
  @override
  _DashBoardWidgetState createState() => _DashBoardWidgetState();
}

Future<Sensor> getSensor() async {
  try {
    String url = '$API/RecentStatus?uuid=756e6b776f000c04';
    //'$API/RecentStatus?uuid=${widget.sensorUUID}';
    final http.Response response = await http.get(url);
    final responseData = jsonDecode(response.body);
    final Sensor sensor = Sensor.fromJson(responseData);
    return sensor;
  } catch (err) {
    throw err;
  }
}

class _DashBoardWidgetState extends State<DashBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
          FutureBuilder(
            future: getSensor(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final sensor = snapshot.data;
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    InfoSession(
                      isClicked: true,
                      name: '온도',
                      subName: 'Temperature',
                      image: temperature,
                      clickImg: wTemperature,
                      value: sensor.temperature.toString(),
                      color: infoBoxTempColor,
                      unit: '℃',
                      press: () {},
                    ),
                    InfoSession(
                      isClicked: false,
                      name: '습도',
                      subName: 'humidity',
                      image: humidity,
                      clickImg: wHumidity,
                      value: sensor.humidity.toString(),
                      color: infoBoxHumidityColor,
                      unit: '%',
                      press: () {},
                    ),
                    InfoSession(
                      isClicked: false,
                      name: '일조시간',
                      subName: 'Led Duration',
                      image: sun,
                      clickImg: wSun,
                      value: sensor.light.toString(),
                      color: infoBoxLedColor,
                      unit: 'h',
                      press: () {},
                    ),
                    InfoSession(
                      isClicked: false,
                      name: '산성도',
                      subName: 'pH',
                      image: ph,
                      clickImg: wPh,
                      value: sensor.pH.toString(),
                      color: infoBoxHumidityColor,
                      unit: '%',
                      press: () {},
                    ),
                    InfoSession(
                      isClicked: false,
                      name: '양액농도',
                      subName: 'EC',
                      image: ion,
                      clickImg: wIon,
                      value: sensor.ec.toString(),
                      color: infoBoxTempColor,
                      unit: 'dS/m',
                      press: () {},
                    ),
                    InfoSession(
                      isClicked: false,
                      name: '수온',
                      subName: 'Liquid temp',
                      image: waterTemp,
                      clickImg: wWaterTemp,
                      value: sensor.liquidTemp.toString(),
                      color: infoBoxLedColor,
                      unit: '℃',
                      press: () {},
                    ),
                  ],
                );
              }
            },
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
              FutureBuilder(
                future: getSensor(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final sensor = snapshot.data;
                    return Text(
                      '${sensor.temperature}도',
                      style: TextStyle(
                        color: infoBoxResultColor,
                        fontFamily: 'NotoSans-Bold',
                        fontSize: 13.0,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          ChartWidget(),
        ],
      ),
    );
  }
}

class InfoSession extends StatelessWidget {
  final name;
  final subName;
  final image;
  final clickImg;
  final value;
  final bool isClicked;
  final Function press;
  final color;
  final unit;

  const InfoSession(
      {Key key,
      this.isClicked = false,
      this.name,
      this.press,
      this.subName,
      this.image,
      this.clickImg,
      this.value,
      this.color,
      this.unit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: size.maxWidth > 350
                  ? size.maxWidth / 2 - 66
                  : size.maxWidth / 2 - 60,
              decoration: BoxDecoration(
                color: isClicked ? color : Colors.white,
                border: isClicked
                    ? null
                    : Border.all(width: 1.5, color: borderColor),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: press,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              name,
                              style: TextStyle(
                                color: isClicked ? Colors.white : cardFontColor,
                                fontFamily: 'NotoSans-Bold',
                                fontSize: 13.0,
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: 18.0,
                              height: 18.0,
                              child: Image.asset(isClicked ? clickImg : image),
                            ),
                          ],
                        ),
                        Text(
                          subName,
                          style: TextStyle(
                            color: isClicked ? Colors.white : cardFontColor,
                            fontFamily: 'NotoSans-Regular',
                            fontSize: 10.0,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              value,
                              style: TextStyle(
                                color: isClicked ? Colors.white : cardFontColor,
                                fontFamily: 'NotoSans-Bold',
                                fontSize: 10.0,
                              ),
                            ),
                            Text(
                              unit,
                              style: TextStyle(
                                  color:
                                      isClicked ? Colors.white : cardFontColor,
                                  fontFamily: 'NotoSans-Bold',
                                  fontSize: 10.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          isClicked
              ? Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: Container(
                    height: 18.0,
                    width: 18.0,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '!',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(left: 0),
                ),
        ],
      );
    });
  }
}
