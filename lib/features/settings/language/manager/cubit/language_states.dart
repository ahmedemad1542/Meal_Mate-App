abstract class LanguageState {
  final String languageCode;
  const LanguageState(this.languageCode);
}

class LanguageInitial extends LanguageState {
  const LanguageInitial(super.languageCode);
}

class LanguageChanged extends LanguageState {
  const LanguageChanged(super.languageCode);
}
