import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key, this.color = AppColors.secondaryColor});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: color,
    ));
  }
}

class OnErrorWidget extends StatelessWidget {
  const OnErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: const Text(
            "Unexpected Error.\nCheck your internet connection and try again.\n(Pull to Refresh)",
            textAlign: TextAlign.center,
          )),
    );
  }
}
