import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/screens/farm_dashboard/forms/chart_widget.dart';
import 'package:smartfarm/services/api/get_chart_sensor_data.dart';
import 'package:smartfarm/services/api/get_sensor_data.dart';
import 'package:smartfarm/services/scan_data.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class DashBoardWidget extends StatefulWidget {
  @override
  _DashBoardWidgetState createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget> {
  @override
  Widget build(BuildContext context) {
    final scanData = Provider.of<ScanData>(context, listen: false);
    final chartData = Provider.of<GetChartSensorData>(context, listen: false);
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
            future: sensorData.getSensor(scanData.deviceUUID),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final sensor = snapshot.data;
                scanData.setFan(sensor.fan);
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    InfoSession(
                      name: '온도',
                      subName: 'Temperature',
                      image: chartData.sensorInfo == 'temperature'
                          ? wTemperature
                          : temperature,
                      value: sensor.temperature.toString(),
                      color: chartData.sensorInfo == 'temperature'
                          ? infoBoxTempColor
                          : Colors.white,
                      fontColor: chartData.sensorInfo == 'temperature'
                          ? Colors.white
                          : cardFontColor,
                      unit: '℃',
                      onPressed: () => setState(
                          () => chartData.setSensorInfo('temperature')),
                    ),
                    InfoSession(
                      name: '습도',
                      subName: 'humidity',
                      image: chartData.sensorInfo == 'humidity'
                          ? wHumidity
                          : humidity,
                      value: sensor.humidity.toString(),
                      color: chartData.sensorInfo == 'humidity'
                          ? infoBoxHumidityColor
                          : Colors.white,
                      fontColor: chartData.sensorInfo == 'humidity'
                          ? Colors.white
                          : cardFontColor,
                      unit: '%',
                      onPressed: () =>
                          setState(() => chartData.setSensorInfo('humidity')),
                    ),
                    InfoSession(
                      name: '일조시간',
                      subName: 'Led Duration',
                      image: chartData.sensorInfo == 'lightTime' ? wSun : sun,
                      value: sensor.light.toString(),
                      color: chartData.sensorInfo == 'lightTime'
                          ? infoBoxLedColor
                          : Colors.white,
                      fontColor: chartData.sensorInfo == 'lightTime'
                          ? Colors.white
                          : cardFontColor,
                      unit: 'h',
                      onPressed: () =>
                          setState(() => chartData.setSensorInfo('lightTime')),
                    ),
                    InfoSession(
                      name: '산성도',
                      subName: 'pH',
                      image: chartData.sensorInfo == 'pH' ? wPh : ph,
                      value: sensor.pH.toString(),
                      color: chartData.sensorInfo == 'pH'
                          ? infoBoxHumidityColor
                          : Colors.white,
                      fontColor: chartData.sensorInfo == 'pH'
                          ? Colors.white
                          : cardFontColor,
                      unit: '%',
                      onPressed: () =>
                          setState(() => chartData.setSensorInfo('pH')),
                    ),
                    InfoSession(
                      name: '양액농도',
                      subName: 'EC',
                      image: chartData.sensorInfo == 'ec' ? wIon : ion,
                      value: sensor.ec.toString(),
                      color: chartData.sensorInfo == 'ec'
                          ? infoBoxTempColor
                          : Colors.white,
                      fontColor: chartData.sensorInfo == 'ec'
                          ? Colors.white
                          : cardFontColor,
                      unit: 'dS/m',
                      onPressed: () =>
                          setState(() => chartData.setSensorInfo('ec')),
                    ),
                    InfoSession(
                      name: '수온',
                      subName: 'Liquid temp',
                      image: chartData.sensorInfo == 'liquidTemp' ? wWaterTemp : waterTemp,
                      value: sensor.liquidTemp.toString(),
                      color: chartData.sensorInfo == 'liquidTemp'
                          ? infoBoxLedColor
                          : Colors.white,
                      fontColor: chartData.sensorInfo == 'liquidTemp'
                          ? Colors.white
                          : cardFontColor,
                      unit: '℃',
                      onPressed: () =>
                          setState(() => chartData.setSensorInfo('liquidTemp')),
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
                future: sensorData.getSensor(scanData.deviceUUID),
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
  final value;
  final Function onPressed;
  final color;
  final fontColor;
  final unit;

  const InfoSession(
      {Key key,
      this.name,
      this.onPressed,
      this.subName,
      this.image,
      this.value,
      this.color,
      this.unit,
      this.fontColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GetChartSensorData>(
      builder: (context, snapshot, child) {
        return LayoutBuilder(
          builder: (context, size) {
            return Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    width: size.maxWidth > 350
                        ? size.maxWidth / 2 - 66
                        : size.maxWidth / 2 - 60,
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(width: 1.5, color: borderColor),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onPressed,
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
                                      color: fontColor,
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
                                  color: fontColor,
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
                                      color: fontColor,
                                      fontFamily: 'NotoSans-Bold',
                                      fontSize: 10.0,
                                    ),
                                  ),
                                  Text(
                                    unit,
                                    style: TextStyle(
                                        color: fontColor,
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
//                isClicked
//                    ? Positioned(
//                        top: 0.0,
//                        right: 0.0,
//                        child: Container(
//                          height: 18.0,
//                          width: 18.0,
//                          decoration: BoxDecoration(
//                            color: Colors.redAccent,
//                            shape: BoxShape.circle,
//                          ),
//                          child: Center(
//                            child: Text(
//                              '!',
//                              style: TextStyle(
//                                fontSize: 13.0,
//                                fontWeight: FontWeight.bold,
//                                color: Colors.white,
//                              ),
//                            ),
//                          ),
//                        ),
//                      )
//                    : Padding(
//                        padding: EdgeInsets.only(left: 0),
//                      ),
              ],
            );
          },
        );
      },
    );
  }
}
