// HomeScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/core/theming/app_assets.dart';
import 'package:meal_mate/core/widgets/meal_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (onPressed),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                AppAssets.home,
                fit: BoxFit.cover,
                height: 230.
                ,
              ),
            ),
            GridView.builder(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 44,
                crossAxisSpacing: 30,
                childAspectRatio: 160 / 210,
              ),
              itemBuilder: (context, index) => const MealCard(),
            ),
          ],
        ),
      ),
    );
  }
}
