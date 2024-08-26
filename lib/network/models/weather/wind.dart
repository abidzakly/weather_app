import 'package:json_annotation/json_annotation.dart';

part 'wind.g.dart';


@JsonSerializable()
class Wind {
  Wind({required this.speed, required this.deg, required this.gust});

  final double speed;
  final int deg;
  final double gust;

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
  Map<String, dynamic> toJson() => _$WindToJson(this);
}
