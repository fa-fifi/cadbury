import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppTheme {
  static ThemeData primary = ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.blue,
      brightness: SchedulerBinding.instance.window.platformBrightness);
}
