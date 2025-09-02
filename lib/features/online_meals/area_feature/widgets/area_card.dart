import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meal_mate/core/theming/custom_colors.dart';

class AreaCard extends StatelessWidget {
  final String name;
  final String? code;
  final VoidCallback onTap;

  const AreaCard({
    super.key,
    required this.name,
    this.code,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        color: colors.areaCardBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (code != null)
              SvgPicture.asset(
                'icons/flags/svg/$code.svg',
                package: 'country_icons',
                width: 48,
                height: 48,
              )
            else
              Icon(Icons.flag, size: 48, color: colors.flagIcon),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: colors.areaCardText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
