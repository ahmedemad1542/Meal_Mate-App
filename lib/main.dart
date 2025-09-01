import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/core/routing/router_generation_config.dart';
import 'package:meal_mate/features/chat_bot/data/repo/chat_repo.dart';
import 'package:meal_mate/features/chat_bot/manager/cubit/chatbot_cubit.dart';

import 'package:meal_mate/features/local_meals/add_meal/manager/cubit/add_meal_cubit.dart';

import 'package:meal_mate/core/data/repo/local_meals_repo.dart';
import 'package:meal_mate/features/online_meals/api_meal_details/data/repo/api_meal_details_repo.dart';
import 'package:meal_mate/features/online_meals/api_meal_details/manager/cubit/api_meal_details_cubit.dart';
import 'package:meal_mate/features/online_meals/api_meals/data/repo/api_meals_repo.dart';
import 'package:meal_mate/features/online_meals/api_meals/manager/cubit/api_meals_cubit.dart';
import 'package:meal_mate/features/online_meals/area_feature/data/repo/area_repo.dart';
import 'package:meal_mate/features/online_meals/area_feature/manager/cubit/area_cubit.dart';
import 'package:meal_mate/features/online_meals/category_feature/data/repo/category_repo.dart';
import 'package:meal_mate/features/online_meals/category_feature/manager/cubit/category_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(MealModelAdapter());
  await Hive.openBox<MealModel>('meals');
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AddMealCubit(LocalMealsRepo())),
            BlocProvider(create: (_) => AreaCubit(AreaRepo())..getAreas()),
            BlocProvider(
              create: (_) => CategoryCubit(CategoryRepo())..getCategories(),
            ),
            BlocProvider(create: (_) => ApiMealCubit(ApiMealsRepo())),
            BlocProvider(create: (_) => ChatCubit(ChatRepo())),
            BlocProvider(
              create: (_) => ApiMealDetailCubit(ApiMealDetailRepo()),
            ),
          ],

          child: MaterialApp.router(
            title: 'Meal Mate',
            debugShowCheckedModeBanner: false,
            routerConfig: RouterGenerationConfig.goRouter,
          ),
        );
      },
    );
  }
}
