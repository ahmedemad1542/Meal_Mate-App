import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meal_mate/core/utils/app_assets.dart';
import 'package:meal_mate/core/utils/app_colors.dart';
import 'package:meal_mate/core/utils/text_style.dart';
import 'package:meal_mate/core/widgets/custom_painter.dart';
import 'package:meal_mate/core/widgets/meal_card.dart';
import 'package:meal_mate/features/home_screen/custom_navigaton_bar/model/bottom_nav_items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<BottomNavItems> _items = [
    BottomNavItems(
      page: Center(child: Text('Home', style: TextStyles.skipAndNext)),
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
              itemCount: 2,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 160 / 210,
              ),
              itemBuilder: (context, index) => const MealCard(),
            ),
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: _items.map((e) => e.page).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          CustomPaint(size: Size(1.sw, 75.h), painter: BNBCustomPainter()),

          Positioned(
            top: -28.h,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
              child: Container(
                height: 65.h,
                width: 65.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.black,
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 5.r),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.ai,
                    width: 40.w,
                    height: 40.h,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 75.h,
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              currentIndex: _currentIndex,
              onTap: (index) {
                if (index == 2) return;
                setState(() {
                  _currentIndex = index;
                });
              },
              items:
                  _items.asMap().entries.map((entry) {
                    int idx = entry.key;
                    BottomNavItems item = entry.value;
                    Color iconColor =
                        (idx == _currentIndex)
                            ? AppColors.orange
                            : AppColors.black;

                    if (item.iconWidget == null) {
                      return const BottomNavigationBarItem(
                        icon: SizedBox.shrink(),
                        label: '',
                      );
                    }

                    return BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(top: 1.0.h),
                        child: IconTheme(
                          data: IconThemeData(color: iconColor),
                          child: item.iconWidget!,
                        ),
                      ),
                      label: item.label,
                    );
                  }).toList(),
              selectedItemColor: AppColors.black,
              unselectedItemColor: AppColors.black,
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(color: AppColors.black),
              unselectedLabelStyle: const TextStyle(color: Colors.black45),
              type: BottomNavigationBarType.fixed,
            ),
          ),
        ],
      ),
    );
  }
}
