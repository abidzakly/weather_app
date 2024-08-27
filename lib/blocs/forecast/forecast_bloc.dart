import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/bloc_status.dart';
import 'package:weather_app/blocs/forecast/forecast_event.dart';
import 'package:weather_app/blocs/forecast/forecast_state.dart';
import 'package:weather_app/blocs/home/home_bloc.dart';
import 'package:weather_app/network/models/forecasts/forecast_model.dart';
import 'package:weather_app/network/weather_repository.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final WeatherRepository? weatherRepository;

  ForecastBloc({this.weatherRepository}) : super(const ForecastState()) {
    on<ForecastEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(
      ForecastEvent event, Emitter<ForecastState> emit) async {
    if (event is ForecastInitialEvent) {
      emit(state.copyWith(
          latitude: event.latitude,
          longitude: event.longitude,
          appStatus: IsLoading()));
    }
    if (event is ForecastInitialEvent || event is ForecastRefreshedEvent) {
      emit(state.copyWith(
          latitude: state.latitude,
          longitude: state.longitude,
          appStatus: IsLoading()));
      ForecastModel? forecastModel =
          await weatherRepository?.getFiveDaysForecasts(
              latitude: state.latitude.toString(),
              longitude: state.longitude.toString());
      emit(state.copyWith(
          forecastsModel: forecastModel, appStatus: const IsSuccess()));
    }

    if (event is ForecastTypeChangedEvent) {
      emit(state.copyWith(appStatus: IsLoading()));
      emit(state.copyWith(
          isDayTime: event.isDaytime, appStatus: const IsSuccess()));
    }
  }
}
