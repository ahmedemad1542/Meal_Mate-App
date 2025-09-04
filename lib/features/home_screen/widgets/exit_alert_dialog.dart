import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ExitAlertDialog extends StatelessWidget {
  const ExitAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AlertDialog(
      title: Text(
        'Exit App',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: colors.onSurface,
        ),
      ),
      content: Text(
        'Are you sure you want to exit the app?',
        style: TextStyle(color: colors.onSurfaceVariant),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(
            foregroundColor: colors.error,
          ),
          child:  Text(
            'No'.tr(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(
            foregroundColor: colors.primary,
          ),
          child:  Text(
            'Yes'.tr(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
