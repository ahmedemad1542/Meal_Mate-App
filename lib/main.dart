import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:meal_mate/core/model/meal_model.dart';
import 'package:meal_mate/core/routing/router_generation_config.dart';
import 'package:meal_mate/features/meals/add_meal/manager/cubit/add_meal_cubit.dart';

import 'package:meal_mate/features/meals/data/repo/local_meals_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(MealModelAdapter());
  await Hive.openBox<MealModel>('meals');

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
          
            BlocProvider(
              create: (context) => AddMealCubit(LocalMealsRepo()),
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
