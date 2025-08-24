import 'package:go_router/go_router.dart';
import 'package:meal_mate/core/routing/app_routes.dart';
import 'package:meal_mate/features/home_screen/base_screen.dart';
import 'package:meal_mate/features/add_meal/view/add_meal_screen.dart';
import 'package:meal_mate/features/onBoarding/view/on_boarding.dart';
import 'package:meal_mate/features/splash_screen/splash_screen.dart';

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
        builder: (context, state) => const AddMealScreen(),
      ),
    ],
  );
}
