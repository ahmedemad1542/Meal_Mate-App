import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/features/chat_bot/manager/cubit/chatbot_cubit.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AppBar(
      elevation: 0,
      backgroundColor: colors.primary, 
      foregroundColor: colors.onPrimary,
      title: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: colors.onPrimary, 
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.restaurant_menu,
              color: colors.primary, 
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ChefBot",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: colors.onPrimary, 
                ),
              ),
              Text(
                "Your Cooking Assistant",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: colors.onPrimary.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, size: 22.sp, color: colors.onPrimary),
          onSelected: (value) {
            if (value == 'clear') {
              context.read<ChatCubit>().clearChat();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'clear',
              child: Row(
                children: [
                  Icon(Icons.clear_all, size: 20.sp, color: colors.onSurface),
                  SizedBox(width: 8.w),
                  Text(
                    'Clear Chat',
                    style: TextStyle(fontSize: 14.sp, color: colors.onSurface),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
