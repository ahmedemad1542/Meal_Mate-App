import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meal_mate/features/settings/language/manager/cubit/language_cubit.dart';
import 'package:meal_mate/features/settings/language/manager/cubit/language_states.dart';
import 'package:meal_mate/features/settings/theme/manager/cubit/theme_cubit.dart';
import 'package:meal_mate/features/settings/theme/manager/cubit/theme_states.dart';
import 'package:meal_mate/features/settings/widgets/custom_switch.dart';
import 'package:meal_mate/core/theming/custom_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'.tr()),
        elevation: 0,
        backgroundColor: colors.background,
        foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.areaCardBackground, // Use your custom card color
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: colors.elevationShadow,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.language, color: colors.primary, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        'Language'.tr(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colors.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Choose language'.tr(),
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.secondaryText,
                        ),
                      ),
                      BlocBuilder<LanguageCubit, LanguageState>(
                        builder: (context, state) {
                          return CustomSwitch(
                            isOn: state.languageCode == 'ar',
                            leftText: 'EN',
                            rightText: 'AR',
                            activeColor: colors.yesButton,
                            inactiveColor: colors.switchInactiveText,
                            onToggle: (isArabic) {
                              final newLanguage = isArabic ? 'ar' : 'en';
                              context.read<LanguageCubit>().changeLanguage(
                                newLanguage,
                              );
                              context.setLocale(Locale(newLanguage));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Theme Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.areaCardBackground, // Use your custom card color
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: colors.elevationShadow,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BlocBuilder<ThemeCubit, ThemeState>(
                        builder: (context, state) {
                          return Icon(
                            state.isDarkMode
                                ? Icons.dark_mode
                                : Icons.light_mode,
                            color: colors.primary,
                            size: 24,
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Theme'.tr(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colors.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Choose Theme'.tr(),
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.secondaryText,
                        ),
                      ),
                      BlocBuilder<ThemeCubit, ThemeState>(
                        builder: (context, state) {
                          return CustomSwitch(
                            isOn: state.isDarkMode,
                            leftText: 'Light',
                            rightText: 'Dark',
                            activeColor: colors.themeActiveColor,
                            inactiveColor: colors.themeInactiveColor,
                            onToggle: (_) {
                              context.read<ThemeCubit>().toggleTheme();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Additional Info
          ],
        ),
      ),
    );
  }
}
