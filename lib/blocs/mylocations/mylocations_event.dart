part of 'mylocations_bloc.dart';

abstract class MylocationsEvent extends Equatable {
  const MylocationsEvent();
}

class HomeGetWeatherEvent extends MylocationsEvent {
  @override
  List<Object> get props => [];
}

class HomeRefreshedEvent extends MylocationsEvent {
  @override
  List<Object?> get props => [];
}

class HomeIsDayTimeChangedEvent extends MylocationsEvent {
  const HomeIsDayTimeChangedEvent({this.isDaytime});

  final bool? isDaytime;

  @override
  List<Object?> get props => [isDaytime];
}
