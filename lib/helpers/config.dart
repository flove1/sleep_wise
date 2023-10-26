
import 'dart:math';

import 'package:flutter/material.dart';

class AppConfig{
  AppConfig._();

  static int alarmID = 0;
  static double width = 0;
  static double height = 0;
  static double spacing = 0;
  static double fontScaling = 0;

  static void init(BuildContext context){
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.width;
    spacing = MediaQuery.of(context).size.width / 20;
    fontScaling = min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) * 0.0025;
  }
}