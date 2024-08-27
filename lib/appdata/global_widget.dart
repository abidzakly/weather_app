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
    return const Center(
      child: Text("Unknown Error."),
    );
  }
}
