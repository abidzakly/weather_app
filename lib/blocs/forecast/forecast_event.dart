import 'package:equatable/equatable.dart';

abstract class ForecastEvent extends Equatable {
  const ForecastEvent();
}

class ForecastInitialEvent extends ForecastEvent {
  const ForecastInitialEvent({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  List<Object> get props => [latitude, longitude];
}

class ForecastRefreshedEvent extends ForecastEvent {
  @override
  List<Object?> get props => [];
}

class ForecastTypeChangedEvent extends ForecastEvent {
  const ForecastTypeChangedEvent({this.isDaytime});

  final bool? isDaytime;

  @override
  List<Object?> get props => [isDaytime];
}
