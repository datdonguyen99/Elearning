import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:elearning/services/logger_service.dart';
import 'package:elearning/services/router_service.dart';
import 'package:elearning/services/settings_manager.dart';
import 'package:elearning/style/app_theme.dart';

final logger = Logger();
final appLanguages = <String, String>{'English': 'en', 'Vietnamese': 'vi'};

final appSupportedLocales = appLanguages.values
    .map((languageCode) => Locale.fromSubtags(languageCode: languageCode))
    .toList();

class ElearningApp extends StatefulWidget {
  const ElearningApp({super.key});

  static Future<void> updateAppSate(
    BuildContext context, {
    ThemeMode? newThemeMode,
    Locale? newLocale,
  }) async {
    final state = context.findAncestorStateOfType<_ElearningAppState>()!;
    state.changeSettings(newThemeMode: newThemeMode, newLocale: newLocale);
  }

  @override
  State<ElearningApp> createState() => _ElearningAppState();
}

class _ElearningAppState extends State<ElearningApp> {
  void changeSettings({ThemeMode? newThemeMode, Locale? newLocale}) {
    setState(() {
      if (newThemeMode != null) {
        themeMode = newThemeMode;
        brightness = getBrightnessFromThemeMode(newThemeMode);
      }
      if (newLocale != null) {
        languageSetting = newLocale;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    final trickyFixForTransparency = Colors.black.withOpacity(0.002);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: trickyFixForTransparency,
        systemNavigationBarColor: trickyFixForTransparency,
      ),
    );

    try {
      LicenseRegistry.addLicense(() async* {
        final license =
            await rootBundle.loadString('assets/licenses/LICENSE.txt');
        yield LicenseEntryWithLineBreaks(['roboto'], license);
      });
    } catch (e, stackTrace) {
      logger.log('License Registration Error', e, stackTrace);
    }
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: appSupportedLocales,
      locale: languageSetting,
      routerConfig: NavigationManager.router,
    );
  }
}

Future<void> initialization() async {
  try {
    await Hive.initFlutter();

    final boxNames = ['settings'];

    for (final boxName in boxNames) {
      await Hive.openBox(boxName);
    }

    // Init router
    NavigationManager.instance;
  } catch (e, stackTrace) {
    logger.log('Initialization Error', e, stackTrace);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization();

  runApp(const ElearningApp());
}
