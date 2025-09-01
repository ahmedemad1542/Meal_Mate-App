import 'package:flutter/material.dart';
import 'package:meal_mate/core/theming/app_colors.dart';
import 'package:meal_mate/features/chat_bot/view/chatbot_screen.dart';
import 'package:meal_mate/features/local_meals/add_meal/view/add_meal_screen.dart';
import 'package:meal_mate/features/home_screen/custom_navigaton_bar/model/bottom_nav_items.dart';
import 'package:meal_mate/features/home_screen/home_screen.dart';
import 'package:meal_mate/features/home_screen/widgets/custom_nav_bar.dart';
import 'package:meal_mate/features/online_meals/area_feature/view/area_view.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _currentIndex = 0;

  final List<BottomNavItems> _items = [
    BottomNavItems(
      page: const HomeScreen(),
      iconWidget: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavItems(
      page: AreasScreen(),
      iconWidget: Icon(Icons.local_fire_department),
      label: 'online',
    ),
    BottomNavItems(
      page:  ChatScreen(),
      iconWidget: null,
      label: '',
    ),
    BottomNavItems(
      page: Center(child: Text('Center')),
      iconWidget: Icon(Icons.chat),
      label: 'settings',
    ),
    BottomNavItems(
      page: Center(child: Text('More')),
      iconWidget: Icon(Icons.menu),
      label: 'More',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _items.map((e) => e.page).toList(),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        items: _items,
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
