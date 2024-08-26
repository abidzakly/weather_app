import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/network/models/weather/sys.dart';
import 'package:weather_app/network/models/weather/weather.dart';
import 'package:weather_app/network/models/weather/wind.dart';

import 'main.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  final List<Weather> weather;
  final Main main;
  final Sys sys;
  final String name;
  final int dt;
  final int visibility;
  final Wind wind;

  WeatherModel({
    required this.weather,
    required this.main,
    required this.sys,
    required this.name,
    required this.dt,
    required this.visibility,
    required this.wind
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}





