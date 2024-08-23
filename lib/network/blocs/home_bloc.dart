import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/network/models/weather/weather_model.dart';
import 'package:weather_app/network/models/weather/weather.dart';
import 'package:weather_app/network/models/weather/sys.dart';
import 'package:weather_app/network/models/weather/main.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<StartHomeEvent>(_onStart);
    on<ToggleHomeEvent>(_onToggle);
  }

  _onStart(StartHomeEvent event, Emitter<HomeState> emit) {
    emit(const HomeLoadedState(weatherData: []));
  }

  _onToggle(ToggleHomeEvent event) {
    final state = this.state;

    if (state is HomeLoadedState) {
    WeatherModel weatherData = state.
    }
    emit(const HomeLoadedState(weatherData: []))
  }
}