import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:elearning/main.dart';
import 'package:elearning/services/router_service.dart';
import 'package:elearning/services/data_manager.dart';
import 'package:elearning/utilities/bottom_sheet.dart';
import 'package:elearning/utilities/toast.dart';
import 'package:elearning/widgets/custom_bar.dart';
import 'package:elearning/extensions/l10n.dart';
import 'package:elearning/style/app_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final activatedColor =
        Theme.of(context).colorScheme.surfaceContainerHighest;
    final inactivatedColor = Theme.of(context).colorScheme.secondaryContainer;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n!.setting),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildSectionTitle(primaryColor, context.l10n!.preferences),
            CustomBar(
              context.l10n!.themeMode,
              FluentIcons.weather_sunny_28_filled,
              onTap: () {
                final availableModes = [
                  ThemeMode.light,
                  ThemeMode.dark,
                  ThemeMode.system
                ];

                showCustomBottomSheet(
                  context,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: availableModes.length,
                    itemBuilder: (context, idx) {
                      final currMode = availableModes[idx];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        color: themeMode == currMode
                            ? activatedColor
                            : inactivatedColor,
                        child: ListTile(
                          minTileHeight: 65,
                          title: Text(currMode.name),
                          onTap: () {
                            addOrUpdateData(
                              'settings',
                              'themeMode',
                              currMode.name,
                            );
                            ElearningApp.updateAppSate(
                              context,
                              newThemeMode: currMode,
                            );

                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            CustomBar(
              context.l10n!.language,
              FluentIcons.translate_24_filled,
              onTap: () {
                final availableLanguages = appLanguages.keys.toList();
                final activeLanguageCode =
                    Localizations.localeOf(context).languageCode;

                showCustomBottomSheet(
                  context,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: availableLanguages.length,
                    itemBuilder: (context, idx) {
                      final currLanguage = availableLanguages[idx];
                      final currLanguageCode =
                          appLanguages[currLanguage] ?? 'vi';
                      return Card(
                        margin: const EdgeInsets.all(10),
                        color: activeLanguageCode == currLanguageCode
                            ? activatedColor
                            : inactivatedColor,
                        child: ListTile(
                          minTileHeight: 65,
                          title: Text(currLanguage),
                          onTap: () {
                            addOrUpdateData(
                              'settings',
                              'language',
                              currLanguage,
                            );
                            ElearningApp.updateAppSate(
                              context,
                              newLocale: Locale(currLanguageCode),
                            );

                            WidgetsBinding.instance.addPostFrameCallback(
                              (_) {
                                showCustomToast(
                                  message: context.l10n!.languageMsg,
                                );
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            _buildSectionTitle(primaryColor, context.l10n!.others),
            CustomBar(
              context.l10n!.licenses,
              FluentIcons.document_24_filled,
              onTap: () => NavigationManager.router.go('/settings/license'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(Color primaryColor, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color: primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
