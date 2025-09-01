import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/features/chat_bot/manager/cubit/chatbot_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickReplySection extends StatelessWidget {
  final VoidCallback onReplyTap;

  const QuickReplySection({super.key, required this.onReplyTap});

  final List<String> quickReplies = const [
    "🥚 I have eggs and bread",
    "🍖 I have chicken and rice",
    "🥬 I have vegetables",
    "🍝 I want pasta recipes",
    "🥗 Healthy meal ideas",
    "🍰 Dessert recipes",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: quickReplies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: ActionChip(
              label: Text(
                quickReplies[index],
                style: TextStyle(fontSize: 12.sp),
              ),
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFFE0E0E0)),
              onPressed: () {
                context.read<ChatCubit>().addQuickReply(
                  quickReplies[index].replaceAll(RegExp(r'[^\w\s]'), '').trim(),
                );
                onReplyTap();
              },
            ),
          );
        },
      ),
    );
  }
}
