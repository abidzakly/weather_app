import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  final String main;
  final String description;
  final String icon;

  Weather({
    this.main = "Unidentified",
    this.description = "No description yet.",
    this.icon = "",
  });

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}