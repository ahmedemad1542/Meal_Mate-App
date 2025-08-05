import 'package:go_router/go_router.dart';
import 'package:meal_mate/core/routing/app_routes.dart';
import 'package:meal_mate/features/add_meal/view/Home_screen/home_screen.dart';
import 'package:meal_mate/features/add_meal/view/add_meal.dart';
import 'package:meal_mate/onBoarding/on_boarding.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    //initialization
    initialLocation: AppRoutes.onBoarding,
    routes: [
      GoRoute(
        path: AppRoutes.onBoarding,
        name: AppRoutes.onBoarding,
        builder: (context, state) => const OnBoarding(),
      ),

      GoRoute(
        path: AppRoutes.homeScreen,
        name: AppRoutes.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),

      GoRoute(
        path: AppRoutes.addMeal,
        name: AppRoutes.addMeal,
        builder: (context, state) => const AddMeal(),
      ),
    ],
  );
}
