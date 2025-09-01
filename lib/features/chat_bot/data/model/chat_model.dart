class ChatMessage {
  final String role; // user, bot, or system
  final String content;
  final DateTime timestamp;

  ChatMessage({
    required this.role, 
    required this.content,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}