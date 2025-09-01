import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/core/theming/app_colors.dart';
import 'package:meal_mate/features/chat_bot/manager/cubit/chatbot_cubit.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.orange,
      foregroundColor: Colors.white,
      title: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.restaurant_menu,
              color: AppColors.orange,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ChefBot",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "Your Cooking Assistant",
                style: TextStyle(fontSize: 12.sp, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, size: 22.sp),
          onSelected: (value) {
            if (value == 'clear') {
              context.read<ChatCubit>().clearChat();
            }
          },
          itemBuilder:
              (context) => [
                PopupMenuItem(
                  value: 'clear',
                  child: Row(
                    children: [
                      Icon(Icons.clear_all, size: 20.sp),
                      SizedBox(width: 8.w),
                      Text('Clear Chat', style: TextStyle(fontSize: 14.sp)),
                    ],
                  ),
                ),
              ],
        ),
      ],
    );
  }
}
