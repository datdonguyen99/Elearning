import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:elearning/main.dart';

final offlineMode = ValueNotifier<bool>(
    Hive.box('settings').get('offlineMode', defaultValue: false));

final themeModeSetting =
    Hive.box('settings').get('themeMode', defaultValue: 'light') as String;

Locale languageSetting = Locale(appLanguages[Hive.box('settings')
        .get('language', defaultValue: 'Vietnames') as String] ??
    'vi');
