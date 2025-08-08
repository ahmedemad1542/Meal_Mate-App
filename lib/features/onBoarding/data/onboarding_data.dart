import 'package:meal_mate/core/utils/app_assets.dart';
import 'package:meal_mate/features/onBoarding/model/onBoarding_model.dart';

final List<OnBoardingModel> onboardingPages = [
  OnBoardingModel(
    imagePath: AppAssets.on1,
    title: 'Save Your\nMeals\nIngredients',
    description: 'You can add meals ingredients to your list',
  ),
  OnBoardingModel(
    imagePath: AppAssets.on2,
    title: 'Discover New Meals.',
    description: 'Discover New Meals online\n from different countries',
  ),
  OnBoardingModel(
    imagePath: AppAssets.on3,
    title: 'Use AI to Generate Meals',
    description:
        'Tell AI which ingredients you have\n and it will\ngenerate amazing meals with them',
  ),
];
