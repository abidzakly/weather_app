import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/bloc_status.dart';
import 'package:weather_app/blocs/forecast/forecast_event.dart';
import 'package:weather_app/blocs/forecast/forecast_state.dart';
import 'package:weather_app/network/models/forecasts/forecast_model.dart';
import 'package:weather_app/network/weather_repository.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final WeatherRepository? weatherRepository;
  final double? latitude;
  final double? longitude;

  ForecastBloc({this.weatherRepository, this.latitude, this.longitude})
      : super(const ForecastState()) {
    on<ForecastEvent>((event, emit) async {
      await mapEventToState(event, emit);
    });
  }

  Future mapEventToState(
      ForecastEvent event, Emitter<ForecastState> emit) async {
    emit(state.copyWith(appStatus: SubmissionLoading()));
    if (event is ForecastInitialEvent) {
      emit(state.copyWith(
          latitude: latitude,
          longitude: longitude,
          appStatus: SubmissionLoading()));
      ForecastModel? forecastModel =
          await weatherRepository?.getFiveDaysForecasts(
              latitude: state.latitude.toString(),
              longitude: state.latitude.toString());
      emit(state.copyWith(
          forecastsModel: forecastModel, appStatus: const SubmissionSuccess()));
    }

    if (event is ForecastTypeChangedEvent) {
      emit(state.copyWith(appStatus: SubmissionLoading()));
      emit(state.copyWith(
          isDayTime: event.isDaytime, appStatus: const SubmissionSuccess()));
    }
  }
}
