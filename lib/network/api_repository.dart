import 'package:weather_app/network/api_service.dart';
import 'package:weather_app/network/models/weather/weather_model.dart';

class ApiRepository {
  final ApiService _service = ApiService();

  Future<WeatherModel?> getCurrentLocationWeather(
      {required String latitude, required String longitude}) async {
    final response = await _service.dio.get(
        "/weather?lat=-$latitude&lon=$longitude&appid=${_service.apiKey}");

    if (response.statusCode == 200) {
      WeatherModel weatherData = WeatherModel.fromJson(response.data);
      return weatherData;
    } else {
      return null;
    }
  }
}
