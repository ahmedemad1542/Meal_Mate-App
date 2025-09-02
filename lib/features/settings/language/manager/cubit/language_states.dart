abstract class LanguageState {
  final String languageCode;
  const LanguageState(this.languageCode);
}

class LanguageInitial extends LanguageState {
  const LanguageInitial(String languageCode) : super(languageCode);
}

class LanguageChanged extends LanguageState {
  const LanguageChanged(String languageCode) : super(languageCode);
}
