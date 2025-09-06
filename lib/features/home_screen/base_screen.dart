import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meal_mate/core/theming/app_assets.dart';
import 'package:meal_mate/core/theming/app_colors.dart';

import 'package:meal_mate/features/calculators/calculators_page.dart';
import 'package:meal_mate/features/chat_bot/view/chatbot_screen.dart';
import 'package:meal_mate/features/home_screen/custom_navigaton_bar/model/bottom_nav_items.dart';
import 'package:meal_mate/features/home_screen/home_screen.dart';
import 'package:meal_mate/features/home_screen/widgets/custom_nav_bar.dart';
import 'package:meal_mate/features/online_meals/area_feature/view/area_view.dart';
import 'package:meal_mate/features/settings/view/settings_page.dart';


class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _currentIndex = 0;

  Widget _buildSvgIcon(String asset, int iconIndex) {
    return SvgPicture.asset(
      asset,
      color: _currentIndex == iconIndex ? AppColors.orange : AppColors.black,
      height: 24,
      width: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    // نستخدم المفاتيح فقط (labels) بدل النصوص المترجمة
    final items = [
      BottomNavItems(
        page: const HomeScreen(),
        iconWidget: _buildSvgIcon(AppAssets.homeicon, 0),
        label: "home",
      ),
      BottomNavItems(
        page: AreasScreen(),
        iconWidget: _buildSvgIcon(AppAssets.discover, 1),
        label: "discover",
      ),
      BottomNavItems(
        page: ChatScreen(),
        iconWidget: null,
        label: '',
      ),
      BottomNavItems(
        page: const CalculatorsPage(),
        iconWidget: _buildSvgIcon(AppAssets.calculator, 3),
        label: "calculators",
      ),
      BottomNavItems(
        page: const SettingsPage(),
        iconWidget: _buildSvgIcon(AppAssets.settings, 4),
        label: "settings",
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: items.map((e) => e.page).toList(),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        items: items,
        onTabSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        onCenterButtonTap: () {
          setState(() {
            _currentIndex = 2;
          });
        },
      ),
    );
  }
}