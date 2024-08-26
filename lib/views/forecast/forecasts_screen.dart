import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/appdata/global_data.dart';
import 'package:weather_app/appdata/global_functions.dart';
import 'package:weather_app/blocs/bloc_status.dart';
import 'package:weather_app/blocs/forecast/forecast_bloc.dart';
import 'package:weather_app/blocs/forecast/forecast_event.dart';
import 'package:weather_app/blocs/forecast/forecast_state.dart';
import 'package:weather_app/network/models/forecasts/day_averages.dart';
import 'package:weather_app/network/models/forecasts/forecast.dart';
import 'package:weather_app/network/models/forecasts/forecast_model.dart';
import 'package:weather_app/network/weather_repository.dart';

import '../../appdata/app_colors.dart';

class ForecastsScreen extends StatelessWidget {
  const ForecastsScreen(
      {super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => ForecastBloc(
                weatherRepository: WeatherRepository(),
                latitude: latitude,
                longitude: longitude),
            child: BlocBuilder<ForecastBloc, ForecastState>(
                builder: (context, state) {
              print("ForecastScreen, Status: ${state.appStatus}");

              if (state.appStatus == const InitialStatus()) {
                context.read<ForecastBloc>().add(ForecastInitialEvent());
              }
              return SafeArea(
                  minimum:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: state.appStatus is SubmissionLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: AppColors.secondaryColor,
                        ))
                      : Column(
                          children: [
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18 ), child:
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Prediction"),
                                    TextButton(
                                        onPressed: () async => context
                                            .read<ForecastBloc>()
                                            .add(ForecastTypeChangedEvent(
                                                isDaytime: !state.isDayTime)),
                                        child: Text(state.isDayTime
                                            ? "DayTime"
                                            : "NightTime")),
                                  ])),
                              Expanded(
                                  child: ListView.builder(
                                      itemCount: state
                                          .forecastsModel?.forecasts.length,
                                      itemBuilder: (context, index) {
                                        final forecastData = state
                                            .forecastsModel?.forecasts[index];
                                        return Card(
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(formatDate(
                                                      forecastData?.date ??
                                                          "")),
                                                  Text(
                                                      "${forecastData?.day_averages.temp.toStringAsFixed(2)}°"),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(forecastData
                                                              ?.day_averages
                                                              .weather_main ??
                                                          ""),
                                                      forecastData?.day_averages
                                                                  .weather_icon !=
                                                              null
                                                          ? Image.network(
                                                              "${globalData.imgBaseUrl}${forecastData?.day_averages.weather_icon}.png")
                                                          : const SizedBox(
                                                              height: 0),
                                                    ],
                                                  )
                                                ],
                                              )),
                                        );
                                      }))
                            ]));
            })));
  }
}
