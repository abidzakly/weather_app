import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/appdata/app_assets.dart';
import 'package:weather_app/appdata/app_colors.dart';
import 'package:weather_app/appdata/global_functions.dart';
import 'package:weather_app/blocs/bloc_status.dart';
import 'package:weather_app/blocs/home/home_bloc.dart';
import 'package:weather_app/blocs/home/home_event.dart';
import 'package:weather_app/blocs/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/appdata/global_data.dart';
import 'package:weather_app/network/weather_repository.dart';
import 'package:weather_app/views/forecast/forecasts_screen.dart';
import 'package:weather_app/views/home/widgets/home_forecast_card.dart';
import 'package:weather_app/views/home/widgets/home_main_status_card.dart';
import 'package:weather_app/views/map/map_pick_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocProvider(
        create: (context) => HomeBloc(WeatherRepository()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.appStatus == const InitialStatus()) {
              context.read<HomeBloc>().add(HomeGetWeather());
            }

            return RefreshIndicator(
                onRefresh: () async {
                  context.read<HomeBloc>().add(HomeRefreshed());
                },
                child: SafeArea(
                    minimum: const EdgeInsets.all(18.0),
                    child: state.appStatus is SubmissionLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: AppColors.secondaryColor,
                          ))
                        : Padding(padding: const EdgeInsets.only(top: 120),child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () => pushToNextScreen(
                                            context, const MapPickScreen()),
                                        icon: Image.asset(
                                          AppAssets.plusRoundedIco,
                                          width: 24,
                                          height: 24,
                                        )),
                                    Text(
                                        "${state.weatherModel?.name ?? ""} , ${state.weatherModel?.sys.country ?? ""}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    const SizedBox(width: 24)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Card(
                                      color: AppColors.secondaryColor,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 16),
                                          child: Text(
                                            state.currentDate,
                                            style: const TextStyle(
                                                color: AppColors.primaryColor),
                                          )),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      state.weatherModel?.weather[0].main ?? "",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18),
                                    ),
                                    state.weatherModel?.weather[0] != null
                                        ? Image.network(
                                            "${globalData.imgBaseUrl}${state.weatherModel?.weather[0].icon}.png",
                                            height: 24,
                                            width: 24,
                                          )
                                        : const SizedBox(width: 8),
                                  ],
                                ),
                                Text(
                                  "${state.weatherModel?.main.temp ?? 0}°",
                                  style: const TextStyle(
                                      fontSize: 98,
                                      fontWeight: FontWeight.bold),
                                ),
                                HomeCard(
                                    speed:
                                        state.weatherModel?.wind.speed ?? 1,
                                    humidity:
                                        state.weatherModel?.main.humidity ?? 1,
                                    visibility:
                                        state.weatherModel?.visibility ?? 1),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Weekly forecast",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                            color: AppColors.secondaryColor),
                                      ),
                                      IconButton(
                                          onPressed: () => pushToNextScreen(
                                              context,
                                              ForecastsScreen(
                                                  latitude: state.latitude,
                                                  longitude: state.longitude)),
                                          icon: const Icon(
                                              Icons.arrow_forward_rounded))
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      state.forecastsModel?.forecasts.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                        width: 120,
                                        child: Card(
                                          color: Colors.blueAccent,
                                          child: Center(
                                            widthFactor: 2,
                                            heightFactor: 2.0,
                                            child: Text(
                                              state.forecastsModel
                                                      ?.forecasts[index].date ??
                                                  "Test",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ));
                                  },
                                ))
                              ]))));
          },
        ),
      ),
    );
  }
}
