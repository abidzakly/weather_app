import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeGetWeather extends HomeEvent {
  @override
  List<Object> get props => [];
}

class HomeRefreshed extends HomeEvent {
  @override
  List<Object?> get props => [];
}


