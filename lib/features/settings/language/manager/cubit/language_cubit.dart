import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/features/settings/language/manager/cubit/language_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<LanguageState> {
  static const String _languageKey = 'selected_language';
  
  LanguageCubit() : super(const LanguageInitial('en')) {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString(_languageKey) ?? 'en';
      emit(LanguageChanged(savedLanguage));
    } catch (e) {
      emit(const LanguageChanged('en'));
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
      emit(LanguageChanged(languageCode));
    } catch (e) {
      
    }
  }
  bool get isArabic => state.languageCode == 'ar';
}