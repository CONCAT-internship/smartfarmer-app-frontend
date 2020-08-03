import 'package:json_annotation/json_annotation.dart';

part 'sensor.g.dart';

@JsonSerializable()
class Sensor {
  @JsonKey(name:'temperature')
  final double temp; // 온도
  final double humidity; // 습도
  final double pH; // 배양액 산성
  final double ec; // 배양액 이온
  final double light; // 조도
  @JsonKey(name:'liquid_temperature')
  final double liquidTemp; // 수온
  @JsonKey(name:'liquid_flow_rate')
  final double liquidFRate; // 유량
  @JsonKey(name:'liquid_level')
  final bool liquidLevel; // 수위
  final bool valve; // 수위
  final bool led; // LED
  final bool fan;

  Sensor({this.temp, this.humidity, this.pH, this.ec, this.light,
      this.liquidTemp, this.liquidFRate, this.liquidLevel, this.valve, this.led,
      this.fan});
  factory Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);

  Map<String, dynamic> toJson() => _$SensorToJson(this);
}