import 'package:flutter/material.dart';

extension CustomColors on ColorScheme {
  // defult icon colors if there is no flag
  Color get flagIcon =>
      brightness == Brightness.dark ? Colors.grey[400]! : Colors.grey[700]!;

  // card colors
  Color get areaCardBackground =>
      brightness == Brightness.dark ? const Color(0xFF2C2C2C) : Colors.white;
// card text
  Color get areaCardText => onSurface;

  //Dialog
  Color get yesButton => Colors.green;
  Color get noButton => Colors.red;

  //AppBar
  Color get appBarText => onPrimary;

  // error text
  Color get errorText => error;

  // New for ApiMealsScreen
  Color get apiMealCardBackground =>
      brightness == Brightness.dark ? const Color(0xFF2C2C2C) : Colors.white;
  Color get brokenImageIcon =>
      brightness == Brightness.dark ? Colors.grey[400]! : Colors.grey[700]!;
  Color get apiMealsAppBar => surface;

  // ApiMealDetailScreen
  Color get apiMealDetailBackground =>
      brightness == Brightness.dark ? const Color(0xFF2C2C2C) : Colors.white;

  Color get switchBorder =>
      brightness == Brightness.dark ? Colors.grey[600]! : Colors.grey[300]!;
  Color get switchShadow => Colors.black.withOpacity(0.2);
  Color get switchInactiveText =>
      brightness == Brightness.dark ? Colors.grey[400]! : Colors.grey[600]!;
  Color get switchActiveText => onPrimary;

  Color get infoBackground => primary.withOpacity(0.1);
  Color get infoBorder => primary.withOpacity(0.3);
  Color get themeActiveColor =>
      brightness == Brightness.dark
          ? Colors.indigo.shade400
          : Colors.indigo.shade600;
  Color get themeInactiveColor =>
      brightness == Brightness.dark
          ? Colors.orange.shade400
          : Colors.orange.shade600;
  Color get secondaryText => onSurfaceVariant; // small/secondary text
  Color get elevationShadow =>
      brightness == Brightness.dark
          ? Colors.black.withOpacity(0.4)
          : Colors.black.withOpacity(0.1);

            // Chat-specific
  Color get userBubble =>
      brightness == Brightness.dark ? const Color(0xFF1B5E20) : const Color(0xFF2E7D63);

  Color get userBubbleText => Colors.white;

  Color get timestampColor =>
      brightness == Brightness.dark ? Colors.grey.shade400 : const Color(0xFF9E9E9E);

  Color get userAvatarBg =>
      brightness == Brightness.dark ? const Color(0xFF2C2C2C) : const Color(0xFFE0E0E0);

  Color get userAvatarIcon =>
      brightness == Brightness.dark ? Colors.grey.shade300 : const Color(0xFF757575);


}

