import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:ai_face/const/globals.dart' as globals;
class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      globals.darkmode= false;
      return brightness == Brightness.dark;
    } else {
      globals.darkmode= true;
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {

    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.black),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.white),
  );
}