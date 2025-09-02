abstract class ThemeState {
  final bool isDarkMode;
  const ThemeState(this.isDarkMode);
}

class ThemeInitial extends ThemeState {
  const ThemeInitial(bool isDarkMode) : super(isDarkMode);
}

class ThemeChanged extends ThemeState {
  const ThemeChanged(bool isDarkMode) : super(isDarkMode);
}