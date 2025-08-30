import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Add Your Recipe',
        style: TextStyle(color: Colors.white, fontSize: 22.sp),
      ),
      centerTitle: true,
      backgroundColor: Colors.orange,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
