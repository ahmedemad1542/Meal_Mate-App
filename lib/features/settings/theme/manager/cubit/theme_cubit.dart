import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/features/settings/theme/manager/cubit/theme_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeKey = 'is_dark_mode';

  ThemeCubit() : super(const ThemeInitial(false)) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDarkMode = prefs.getBool(_themeKey) ?? false;
      emit(ThemeChanged(isDarkMode));
    } catch (e) {
      emit(const ThemeChanged(false));
    }
  }

  Future<void> toggleTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final newTheme = !state.isDarkMode;
      await prefs.setBool(_themeKey, newTheme);
      emit(ThemeChanged(newTheme));
    } catch (e) {}
  }
}
