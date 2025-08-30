import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_mate/core/routing/app_routes.dart';
import 'package:meal_mate/core/theming/app_colors.dart';
import 'package:meal_mate/features/home_screen/widgets/gridview_mealcard.dart';
import 'package:meal_mate/features/home_screen/widgets/welcome_image_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed(AppRoutes.addMeal);
        },
        backgroundColor: AppColors.orange,
        foregroundColor: AppColors.white,
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [const WelcomeImageHome(), const GridviewMealcard()],
        ),
      ),
    );
  }
}
