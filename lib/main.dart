import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/my_Home_Page.dart';
import 'package:meal_mate/core/routing/router_generation_config.dart';
import 'package:meal_mate/onBoarding/on_boarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Meal Mate',  debugShowCheckedModeBanner: false,
         
         routerConfig: RouterGenerationConfig.goRouter,
        );
      },
      
    );
  }
}


