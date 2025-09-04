import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meal_mate/core/theming/custom_colors.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(
        "exit_app".tr(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: colors.onSurface,
        ),
      ),
      content: Text(
       "are_you_sure_exit_app".tr(),
        style: TextStyle(color: colors.onSurfaceVariant),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(foregroundColor: colors.noButton),
          child:  Text(
            "no".tr(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(foregroundColor: colors.yesButton),
          child:  Text(
            "yes".tr(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
