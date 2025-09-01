import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/features/chat_bot/data/model/chat_model.dart';
import 'package:meal_mate/features/chat_bot/data/repo/chat_repo.dart';
import 'package:meal_mate/features/chat_bot/manager/cubit/chatbot_states.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo repo;
  final List<ChatMessage> _messages = [];
  bool _hasStarted = false;

  ChatCubit(this.repo) : super(ChatInitial()) {
    _initializeChat();
  }

  void _initializeChat() {
    if (!_hasStarted) {
      _hasStarted = true;
      _messages.add(ChatMessage(
        role: "bot", 
        content: "👋 Hi! I'm ChefBot, your personal cooking assistant!\n\n🥘 What ingredients do you have in your kitchen today? I'll suggest some delicious recipes you can make!"
      ));
      emit(ChatLoaded(List.from(_messages)));
    }
  }

  void sendMessage(String userMessage) async {
    if (userMessage.trim().isEmpty) return;

    print("=== ChatCubit Debug ===");
    print("Sending message: $userMessage");

    // Add user message
    _messages.add(ChatMessage(role: "user", content: userMessage));
    emit(ChatLoaded(List.from(_messages), isTyping: true));

    try {
      // Get bot response
      print("Calling repo.sendMessage...");
      final response = await repo.sendMessage(userMessage, _messages);
      print("Got response: $response");
      
      // Add bot response
      _messages.add(ChatMessage(role: "bot", content: response));
      emit(ChatLoaded(List.from(_messages)));
    } catch (e) {
      print("Error in sendMessage: $e");
      _messages.add(ChatMessage(
        role: "bot", 
        content: "Sorry, I'm having trouble right now. Please try again! 😊"
      ));
      emit(ChatLoaded(List.from(_messages)));
    }
  }

  void clearChat() {
    _messages.clear();
    _hasStarted = false;
    _initializeChat();
  }

  void addQuickReply(String message) {
    sendMessage(message);
  }
}