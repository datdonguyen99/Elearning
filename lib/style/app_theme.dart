import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:elearning/services/settings_manager.dart';

ThemeMode themeMode = getThemeMode(themeModeSetting);
Brightness brightness = getBrightnessFromThemeMode(themeMode);

ThemeMode getThemeMode(String themeModeString) {
  switch (themeModeString) {
    case 'dark':
      return ThemeMode.dark;
    case 'light':
      return ThemeMode.light;
    case 'system':
      return ThemeMode.system;
    default:
      return ThemeMode.light;
  }
}

Brightness getBrightnessFromThemeMode(ThemeMode themeMode) {
  final themeBrightnessMapping = {
    ThemeMode.dark: Brightness.dark,
    ThemeMode.light: Brightness.light,
    ThemeMode.system:
        SchedulerBinding.instance.platformDispatcher.platformBrightness,
  };

  return themeBrightnessMapping[themeMode] ?? Brightness.dark;
}
