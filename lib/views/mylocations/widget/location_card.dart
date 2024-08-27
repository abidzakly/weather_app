import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  const LocationCard(
      {super.key,
      required this.locationName,
      required this.temp,
      required this.weatherCondition,
      required this.isCurrentLocation});

  final String locationName;
  final double temp;
  final String weatherCondition;
  final bool isCurrentLocation;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Column(
            children: [Text(locationName), Text(weatherCondition)],
          ),
          Text(temp.toStringAsFixed(2))
        ],
      ),
    );
  }
}
