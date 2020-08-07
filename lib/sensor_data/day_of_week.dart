import 'package:json_annotation/json_annotation.dart';
part 'day_of_week.g.dart';

@JsonSerializable(explicitToJson: true)
class DayOfWeek {
  double temperature; // 온도
  double humidity; // 습도
  double pH; // 배양액 산성
  double ec; // 배양액 이온
  double light; // 조도
  @JsonKey(name: 'liquid_temperature')
  double liquidTemp; // 수온
  @JsonKey(name: 'liquid_flow_rate')
  double liquidFRate; // 유량

  DayOfWeek({this.temperature, this.humidity, this.pH, this.ec, this.light,
    this.liquidTemp, this.liquidFRate});

  factory DayOfWeek.fromJson(Map<String, dynamic> json) => _$DayOfWeekFromJson(json);

  Map<String, dynamic> toJson() => _$DayOfWeekToJson(this);
}
