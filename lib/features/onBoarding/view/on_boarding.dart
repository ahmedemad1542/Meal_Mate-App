import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_mate/core/routing/app_routes.dart';
import 'package:meal_mate/core/style/app_colors.dart';
import 'package:meal_mate/core/style/text_style.dart';
import 'package:meal_mate/features/onBoarding/data/onboarding_data.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  double currentPage = 0;

  void _nextPage() {
    if (currentPage < onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentPage = index.toDouble();
          });
        },
        itemCount: onboardingPages.length,
        itemBuilder: (context, index) {
          final page = onboardingPages[index];
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(page.imagePath, fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 16.h,
                left: 32.w,
                right: 32.w,
                child: Container(
                  width: 311.w,
                  height: 404.h,
                  padding: EdgeInsets.all(32.h),
                  decoration: BoxDecoration(
                    color: AppColors.orange.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(84.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        page.title,
                        style: TextStyles.onBoardingTitle,
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      Text(
                        page.description,
                        style: TextStyles.onBoardingDescribtion,
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      DotsIndicator(
                        dotsCount: onboardingPages.length,
                        position: currentPage,
                        decorator: DotsDecorator(
                          size: const Size(24, 6),
                          activeSize: const Size(24, 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          color: Color(0xFFC2C2C2),
                          activeColor: AppColors.white,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Prev Button
                          currentPage == 0
                              ? SizedBox(width: 80.w)
                              : TextButton(
                                onPressed: _prevPage,
                                child: Text(
                                  "Prev",
                                  style: TextStyles.skipAndNext,
                                ),
                              ),

                          if (currentPage == onboardingPages.length - 1)
                            TextButton(
                              onPressed: () {
                                 context.push(AppRoutes.homeScreen);
                                x   
                              },
                              child: Text(
                                "Let's Start",
                                style: TextStyles.skipAndNext,
                              ),
                            )
                          else
                            TextButton(
                              onPressed: _nextPage,
                              child: Text(
                                "Next",
                                style: TextStyles.skipAndNext,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
