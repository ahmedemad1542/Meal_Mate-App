abstract class ThemeState {
  final bool isDarkMode;
  const ThemeState(this.isDarkMode);
}

class ThemeInitial extends ThemeState {
  const ThemeInitial(super.isDarkMode);
}

class ThemeChanged extends ThemeState {
  const ThemeChanged(super.isDarkMode);
}