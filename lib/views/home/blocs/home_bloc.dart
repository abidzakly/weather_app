import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:weather_app/blocs/bloc_status.dart';
import 'package:weather_app/network/models/forecasts/forecast_model.dart';
import 'package:weather_app/network/models/weather/weather_model.dart';
import 'package:geolocator/geolocator.dart';
import '../../../network/weather_repository.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'package:weather_app/appdata/global_functions.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WeatherRepository? weatherRepository;

  HomeBloc({this.weatherRepository}) : super(const HomeState()) {
    on<HomeEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeRefreshedEvent) {
      emit(state.copyWith(appStatus: IsLoading()));
      try {
        Position? pos = await weatherRepository?.getCurrentPosition();
        print("latlong in HomeBloc: ${pos!.latitude}, ${pos.longitude}");

        emit(state.copyWith(
            latitude: pos!.latitude,
            longitude: pos.longitude,
            appStatus: IsLoading()));

        WeatherModel? weatherData =
            await weatherRepository?.getCurrentLocationWeather(
                latitude: state.latitude.toString(),
                longitude: state.longitude.toString());

        ForecastModel? forecastsModel =
            await weatherRepository?.getFiveDaysForecasts(
                latitude: state.latitude.toString(),
                longitude: state.longitude.toString());

        emit(state.copyWith(
            weatherModel: weatherData,
            forecastsModel: forecastsModel,
            currentDate: dtToReadable(weatherData!.dt),
            appStatus: const IsSuccess()));
      } catch (e) {
        emit(state.copyWith(appStatus: IsFailed(exception: e)));
      }
    }

    if (event is HomeIsDayTimeChangedEvent) {
      emit(state.copyWith(isDayTime: event.isDaytime));
    }
  }
}
