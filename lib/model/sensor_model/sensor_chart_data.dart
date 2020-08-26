import 'package:json_annotation/json_annotation.dart';

part 'sensor_chart_data.g.dart';

@JsonSerializable(explicitToJson: true)
class SensorChartData {
  @JsonKey(name: 'dark_time')
  final double darkTime;
  final double temperature; // 온도
  final double humidity; // 습도
  final double pH; // 배양액 산성
  final double ec; // 배양액 이온
  final double light; // 조도
  @JsonKey(name: 'liquid_temperature')
  final double liquidTemp; // 수온
  @JsonKey(name: 'liquid_level')
  final bool liquidLevel;
  final bool led; // LED
  final bool fan;
  @JsonKey(name: 'light_time')
  final double lightTime;

  SensorChartData({
    this.darkTime,
    this.temperature,
    this.humidity,
    this.pH,
    this.ec,
    this.light,
    this.liquidTemp,
    this.led,
    this.fan,
    this.lightTime,
    this.liquidLevel,
  });

  factory SensorChartData.fromJson(Map<String, dynamic> json) =>
      _$SensorChartDataFromJson(json);

  Map<String, dynamic> toJson() => _$SensorChartDataToJson(this);
}
