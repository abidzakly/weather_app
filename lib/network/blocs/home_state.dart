part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
 const HomeState();
}

class HomeInitialState extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeLoadedState extends HomeState {
  final WeatherModel weatherData;
  const HomeLoadedState({this.weatherData = const WeatherModel()});
  @override
  List<Object?> get props => [weatherData];
}

class HomeErrorState extends HomeState {
  @override
  List<Object> get props => [];
}