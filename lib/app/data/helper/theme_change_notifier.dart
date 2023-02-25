import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeChangeNotifier extends ChangeNotifier {
  var brightness = SchedulerBinding.instance.window.platformBrightness;
  bool get isDarkMode => brightness == Brightness.dark;

}
