
import 'package:flutter/material.dart';
import 'package:meal_mate/features/home_screen/widgets/gridview_mealcard.dart';
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
            , const GridviewMealcard()
          ],
        ),
      ),
    );
  }
}
