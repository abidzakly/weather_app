import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/network/models/weather/sys.dart';
import 'package:weather_app/network/models/weather/weather.dart';

import 'main.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  final List<Weather> weather;
  final Main main;
  final Sys sys;
  final String name;

  WeatherModel({
    required this.weather,
    required this.main,
    required this.sys,
    required this.name
  });

  const WeatherModel.empty()
      : weather = const [],
        main = const Main(temp: 0.0, humidity: 0),
        sys = const Sys(country: 'ID'),
        name = "Unidentified";

  factory WeatherModel.fromJson(Map<String, dynamic> json) => _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}





