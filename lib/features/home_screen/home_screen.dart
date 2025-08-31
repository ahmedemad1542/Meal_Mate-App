import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_mate/core/routing/app_routes.dart';
import 'package:meal_mate/core/theming/app_colors.dart';
import 'package:meal_mate/features/home_screen/widgets/gridview_mealcard.dart';
import 'package:meal_mate/features/home_screen/widgets/welcome_image_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<bool> _showExitDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Exit App',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text('Are you sure you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text(
                'No',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
              ),
              child: const Text(
                'Yes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        
        final shouldExit = await _showExitDialog(context);
        if (shouldExit) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
