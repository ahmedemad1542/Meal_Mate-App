import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Add New Meal',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: Colors.orange, 
    );
  }

  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
