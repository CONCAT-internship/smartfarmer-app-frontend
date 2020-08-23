//class SensorList {
//  final List<SensorChart> sensorDatas;
//
//  SensorList({
//    this.sensorDatas,
//  });
//
//  factory SensorList.fromJson(List<dynamic> parsedJson) {
//    List<SensorChart> sensorDatas = new List<SensorChart>();
//    sensorDatas = parsedJson.map((i) => SensorChart.fromJSON(i)).toList();
//
//    return new SensorList(sensorDatas: sensorDatas);
//  }
//}

class SensorChart {
  final String localTime;
  final num value;

  SensorChart({
    this.localTime,
    this.value,
  });

  factory SensorChart.fromJSON(Map<String, dynamic> json) {
    return SensorChart(
      localTime: json['local_time'],
      value: json['temperature'].toDouble(),
    );
  }
}
