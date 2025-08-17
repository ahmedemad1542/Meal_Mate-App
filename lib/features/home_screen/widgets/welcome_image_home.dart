import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/core/theming/app_assets.dart';

class WelcomeImageHome extends StatelessWidget {
  const WelcomeImageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
              width: double.infinity,
              child: Image.asset(
                AppAssets.home,
                fit: BoxFit.cover,
                height: 230.h,
              ),
            );
  }
}