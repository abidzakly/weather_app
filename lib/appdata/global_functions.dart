import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/appdata/global_variables.dart';

String getImgUrl(String imgId, String? size) {
  return ("${globalVariable.imgBaseUrl}$imgId$size.png");
}


double getScreenHeight() {
  return PlatformDispatcher.instance.views.first.physicalSize.height /
      PlatformDispatcher.instance.views.first.devicePixelRatio;
}

double getScreenWidth() {
  return PlatformDispatcher.instance.views.first.physicalSize.width /
      PlatformDispatcher.instance.views.first.devicePixelRatio;
}

void showSnackBar(BuildContext context, String text) {
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

String dtToReadable(int dt) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true);
  String formattedDate = DateFormat('EEEE, dd MMMM').format(date.toLocal());
  return formattedDate;
}

void pushToNextScreen(BuildContext context, Widget nextScreen) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => nextScreen),
  );
}

void pushAndRemoveToNextScreen(BuildContext context, Widget nextScreen) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => nextScreen),
    (route) => false,
  );
}
