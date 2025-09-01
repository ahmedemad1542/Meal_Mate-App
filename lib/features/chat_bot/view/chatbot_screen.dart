import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/features/chat_bot/manager/cubit/chatbot_cubit.dart';
import 'package:meal_mate/features/chat_bot/manager/cubit/chatbot_states.dart';
import 'package:meal_mate/features/chat_bot/view/widgets/chat_app_bar.dart';
import 'package:meal_mate/features/chat_bot/view/widgets/chat_input.dart';
import 'package:meal_mate/features/chat_bot/view/widgets/chat_message_bubble.dart';
import 'package:meal_mate/features/chat_bot/view/widgets/quick_reply_section.dart';
import 'package:meal_mate/features/chat_bot/view/widgets/typing_indicator.dart';

import 'widgets/error_view.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    final msg = _controller.text.trim();
    if (msg.isNotEmpty) {
      context.read<ChatCubit>().sendMessage(msg);
      _controller.clear();
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: const ChatAppBar(),
      body: Column(
        children: [
          // Quick replies section
          QuickReplySection(
            onReplyTap: () => Future.delayed(
              const Duration(milliseconds: 100), 
              _scrollToBottom
            ),
          ),
          
          // Chat messages
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatLoaded) {
                  Future.delayed(const Duration(milliseconds: 300), _scrollToBottom);
                }
              },
              builder: (context, state) {
                if (state is ChatLoaded) {
                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: state.messages.length + (state.isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (state.isTyping && index == state.messages.length) {
                        return const TypingIndicator();
                      }
                      
                      final message = state.messages[index];
                      return ChatMessageBubble(message: message);
                    },
                  );
                } else if (state is ChatError) {
                  return ErrorView(message: state.message);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          
          // Input section
          ChatInput(
            controller: _controller,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}