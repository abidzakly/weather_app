part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class StartHomeEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class AddHomeEvent extends HomeEvent {
  final WeatherModel weatherObj;

  const AddHomeEvent(this.weatherObj);

  @override
  List<Object> get props => [weatherObj];
}

class RemoveHomeEvent extends HomeEvent {
  final WeatherModel weatherObj;

  const RemoveHomeEvent(this.weatherObj);

  @override
  List<Object> get props => [weatherObj];
}

class ToggleHomeEvent extends HomeEvent {
  final WeatherModel weatherObj;

  const ToggleHomeEvent(this.weatherObj);

  @override
  List<Object> get props => [weatherObj];
}