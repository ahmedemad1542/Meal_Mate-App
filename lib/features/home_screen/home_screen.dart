import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/core/theming/app_assets.dart';
import 'package:meal_mate/core/widgets/meal_card.dart';
import 'package:meal_mate/features/home_screen/custom_navigaton_bar/model/bottom_nav_items.dart';
import 'package:meal_mate/features/home_screen/widgets/custom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<BottomNavItems> _items = [
    BottomNavItems(
      page: Center(child: Text('Home')),
      iconWidget: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavItems(
      page: Center(child: Text('Offers')),
      iconWidget: Icon(Icons.local_fire_department),
      label: 'Offers',
    ),
    BottomNavItems(
      page: Center(child: Text('Center')),
      iconWidget: null,
      label: '',
    ),
    BottomNavItems(
      page: Center(child: Text('Chat')),
      iconWidget: Icon(Icons.chat),
      label: 'Chat',
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
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                AppAssets.home,
                fit: BoxFit.cover,
                height: 230.h,
              ),
            ),
            GridView.builder(
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 44,
                crossAxisSpacing: 30,
                childAspectRatio: 160 / 210,
              ),
              itemBuilder: (context, index) => const MealCard(),
            ),
            IndexedStack(
              index: _currentIndex,
              children: _items.map((e) => e.page).toList(),
            ),
          ],
        ),
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
