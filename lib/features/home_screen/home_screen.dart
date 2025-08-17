// HomeScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/core/theming/app_assets.dart';
import 'package:meal_mate/core/widgets/meal_card.dart';
import 'package:meal_mate/features/home_screen/widgets/welcome_image_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addMeal');
        },backgroundColor:,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           const WelcomeImageHome()
            ,GridView.builder(
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
