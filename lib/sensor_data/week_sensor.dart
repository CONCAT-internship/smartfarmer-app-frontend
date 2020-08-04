import 'package:json_annotation/json_annotation.dart';
import 'package:smartfarm/sensor_data/day_of_week.dart';
part 'week_sensor.g.dart';

@JsonSerializable(explicitToJson: true)
class WeekSensor {
  DayOfWeek sun;
  DayOfWeek mon;
  DayOfWeek tue;
  DayOfWeek wed;
  DayOfWeek thr;
  DayOfWeek fri;
  DayOfWeek sat;

  WeekSensor({this.sun, this.mon, this.tue, this.wed, this.thr, this.fri, this.sat});

  factory WeekSensor.fromJson(Map<String, dynamic> json) => _$WeekSensorFromJson(json);
  Map<String, dynamic> toJson() => _$WeekSensorToJson(this);

//  WeekSensor.fromJson(Map<String, dynamic> json){
//    sun = json['sun'] != null ? new DayOfWeek.fromJson(json['sun']) : null;
//    mon = json['mon'] != null ? new DayOfWeek.fromJson(json['mon']) : null;
//    tue = json['tue'] != null ? new DayOfWeek.fromJson(json['tue']) : null;
//    wed = json['wed'] != null ? new DayOfWeek.fromJson(json['wed']) : null;
//    thr = json['thr'] != null ? new DayOfWeek.fromJson(json['thr']) : null;
//    fri = json['fri'] != null ? new DayOfWeek.fromJson(json['fri']) : null;
//    sat = json['sat'] != null ? new DayOfWeek.fromJson(json['sat']) : null;
//  }
}