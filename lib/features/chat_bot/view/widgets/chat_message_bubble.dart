import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_mate/core/theming/custom_colors.dart';
import 'package:meal_mate/features/chat_bot/data/model/chat_model.dart';


class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isUser = message.role == "user";

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: colors.primary, // bot avatar bg
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.restaurant_menu,
                color: colors.onPrimary,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              decoration: BoxDecoration(
                color: isUser ? colors.userBubble : colors.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                  bottomLeft: Radius.circular(isUser ? 20.r : 4.r),
                  bottomRight: Radius.circular(isUser ? 4.r : 20.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: colors.elevationShadow,
                    blurRadius: 8.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content,
                    style: TextStyle(
                      color: isUser ? colors.userBubbleText : colors.onSurface,
                      fontSize: 16.sp,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}",
                    style: TextStyle(
                      color: isUser
                          ? colors.userBubbleText.withOpacity(0.8)
                          : colors.timestampColor,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) ...[
            SizedBox(width: 8.w),
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: colors.userAvatarBg,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, color: colors.userAvatarIcon, size: 18.sp),
            ),
          ],
        ],
      ),
    );
  }
}
