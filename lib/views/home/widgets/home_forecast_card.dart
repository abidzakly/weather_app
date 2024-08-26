import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/appdata/global_functions.dart';
import 'package:weather_app/appdata/global_data.dart';
import 'package:weather_app/network/models/forecasts/forecast.dart';

import '../../../appdata/app_colors.dart';

class HomeForecastCard extends StatelessWidget {
  const HomeForecastCard({super.key, this.forecastsData});

  final List<Forecast>? forecastsData;

  @override
  Widget build(BuildContext context) {
    print(forecastsData);
    return Expanded(
        child: forecastsData != null
            ? ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: forecastsData?.length,
                itemBuilder: (context, index) {
                  Text(
                    forecastsData?[index].date ?? "TEst",
                    style: const TextStyle(color: AppColors.secondaryColor),
                  );
                  return null;
                },
              )
            : const Text(
                "Data empty",
                style: TextStyle(color: AppColors.secondaryColor),
              ));
  }
}
