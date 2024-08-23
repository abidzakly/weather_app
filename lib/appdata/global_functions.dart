import 'dart:ui';

import 'package:flutter/material.dart';

double getScreenHeight(){
  return PlatformDispatcher.instance.views.first.physicalSize.height / PlatformDispatcher.instance.views.first.devicePixelRatio;
}

double getScreenWidth(){
  return PlatformDispatcher.instance.views.first.physicalSize.width / PlatformDispatcher.instance.views.first.devicePixelRatio;
}

void showSnackBar(BuildContext context, String text){
  if(context.mounted){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text))
    );
  }
}