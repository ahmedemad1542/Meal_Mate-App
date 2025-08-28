import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/core/routing/app_routes.dart';
import 'package:meal_mate/features/home_screen/base_screen.dart';
import 'package:meal_mate/features/meals/add_meal/manager/cubit/add_meal_cubit.dart';
import 'package:meal_mate/features/meals/add_meal/view/add_meal_screen.dart';
import 'package:meal_mate/features/meals/data/repo/local_meals_repo.dart';
import 'package:meal_mate/features/meals/meal_details/view/meal_details.dart';
import 'package:meal_mate/features/meals/update_meal/manager/cubit/update_meal_cubit.dart';
import 'package:meal_mate/features/meals/update_meal/view/update_meal_screen.dart';
import 'package:meal_mate/features/onBoarding/view/on_boarding.dart';
import 'package:meal_mate/features/splash_screen/splash_screen.dart';
import 'package:path/path.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    //initialization
    initialLocation: AppRoutes.splashScreen,
    routes: [
      GoRoute(
        path: AppRoutes.onBoarding,
        name: AppRoutes.onBoarding,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.splashScreen,
        name: AppRoutes.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) => BaseScreen(),
      ),

      GoRoute(
        path: AppRoutes.addMeal,
        name: AppRoutes.addMeal,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => AddMealCubit(LocalMealsRepo()),
            child: AddMealScreen(),
          );
        },
      ),
      //meal details route
      GoRoute(
        path: AppRoutes.mealDetailsScreen,
        name: AppRoutes.mealDetailsScreen,
        builder: (context, state) {
          final meal = state.extra as MealModel;
          final mealKey = meal.key;

          return MealDetailsScreen(meal: meal, mealKey: mealKey);
        },
      ),
      GoRoute(
        path: AppRoutes.updateMealScreen,
        name: AppRoutes.updateMealScreen,
        builder: (context, state) {
          final meal = state.extra as MealModel;

          return BlocProvider(
            create: (context) => UpdateMealCubit(LocalMealsRepo()),
            child: UpdateMealScreen(
              meal: meal,
              mealKey: meal.key,
            ),
          );
        },
      ),
    ],
  );
}
