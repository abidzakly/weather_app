import 'package:weather_app/network/api_provider.dart';
import 'package:weather_app/network/models/weather_model.dart';

class ApiRepository {
  final ApiProvider _provider = ApiProvider();

  Future<WeatherModel?> getCurrentLocationWeather({required String latitude, required String longitude}) {
    return _provider.getCurrentLocationWeather(latitude: latitude, longitude: longitude);
  }
}