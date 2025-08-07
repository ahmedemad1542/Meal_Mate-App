import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_mate/core/routing/app_routes.dart';
import 'package:meal_mate/core/style/app_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation = Tween<double>(begin: 0.0, end: 2.4).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _controller.forward(); // start animation

    _navigateAfterSplash();
  }

 void _navigateAfterSplash() async {
  await Future.delayed(const Duration(seconds: 3));

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? firstTime = prefs.getBool('firstTime');

  if (firstTime == null) {
    await prefs.setBool('firstTime', true);
   context.goNamed(AppRoutes.onBoarding);
  } else { 
  context.goNamed(AppRoutes.homeScreen);
  }
}


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset(
            AppAssets.logo,
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}

