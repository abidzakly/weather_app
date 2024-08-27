import 'package:equatable/equatable.dart';
import 'package:weather_app/network/models/forecasts/forecast_model.dart';
import 'package:weather_app/network/models/weather/weather_model.dart';
import '../bloc_status.dart';

class HomeState extends Equatable {
  const HomeState(
      {this.weatherModel,
      this.forecastsModel,
      this.latitude = 0.0,
      this.longitude = 0.0,
      this.currentDate = "",
      this.isDayTime = true,
      this.appStatus = const InitialStatus()});

  final WeatherModel? weatherModel;
  final ForecastModel? forecastsModel;
  final double latitude;
  final double longitude;
  final AppStatus appStatus;
  final String currentDate;
  final bool isDayTime;

  HomeState copyWith(
      {WeatherModel? weatherModel,
      ForecastModel? forecastsModel,
      double? latitude,
      double? longitude,
      String? currentDate,
      bool? isDayTime,
      AppStatus? appStatus}) {
    return HomeState(
        weatherModel: weatherModel ?? this.weatherModel,
        forecastsModel: forecastsModel ?? this.forecastsModel,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        currentDate: currentDate ?? this.currentDate,
        isDayTime: isDayTime ?? this.isDayTime,
        appStatus: appStatus ?? this.appStatus);
  }

  @override
  List<Object?> get props => [
        weatherModel,
        forecastsModel,
        latitude,
        longitude,
        currentDate,
        isDayTime,
        appStatus
      ];
}
