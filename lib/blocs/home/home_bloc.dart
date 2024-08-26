import 'package:bloc/bloc.dart';
import 'package:weather_app/blocs/bloc_status.dart';
import 'package:weather_app/network/models/forecasts/forecast_model.dart';
import 'package:weather_app/network/models/weather/weather_model.dart';
import 'package:geolocator/geolocator.dart';
import '../../network/weather_repository.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'package:weather_app/appdata/global_functions.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WeatherRepository? weatherRepo;

  HomeBloc(this.weatherRepo) : super(const HomeState()) {
    on<HomeEvent>(_onStartOrRefreshed);
  }

  _onStartOrRefreshed(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeGetWeather || event is HomeRefreshed) {
      emit(state.copyWith(appStatus: SubmissionLoading()));
      try {
        Position? pos = await weatherRepo?.getCurrentPosition();

        print("test 1 : ${pos?.latitude ?? "0 lat"}");
        print("test 2 : ${pos?.longitude ?? "0 long"}");

        emit(state.copyWith(
            latitude: pos!.latitude,
            longitude: pos.longitude,
            appStatus: SubmissionLoading()));

        WeatherModel? weatherData =
        await weatherRepo?.getCurrentLocationWeather(
            latitude: state.latitude.toString(),
            longitude: state.longitude.toString());

        ForecastModel? forecastsModel = await weatherRepo
            ?.getFiveDaysForecasts(latitude: state.latitude.toString(),
            longitude: state.longitude.toString());

        print("test 3 : ${weatherData?.weather[0].icon ?? "no img"}");

        emit(state.copyWith(
            weatherModel: weatherData,
            forecastsModel: forecastsModel,
            currentDate: dtToReadable(weatherData!.dt),
            appStatus: const SubmissionSuccess()));

      } catch (e) {
        emit(state.copyWith(appStatus: SubmissionFailed(exception: e)));
      }
    }
  }
}
