import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:meal_mate/features/chat_bot/data/model/chat_model.dart';

class ChatRepo {
  final Dio _dio;

  ChatRepo({String? apiKey})
      : _dio = Dio(
          BaseOptions(
            baseUrl: "https://api.groq.com/openai/v1/",
            headers: {
              "Authorization": "Bearer ${apiKey ?? dotenv.env['GROQ_API_KEY']}",
              "Content-Type": "application/json",
            },
          ),
        );

  Future<String> sendMessage(String userMessage, List<ChatMessage> conversationHistory) async {
    // List of models to try (in order of preference)
    final models = ["llama-3.3-70b-versatile", "llama-3.1-8b-instant", "gemma2-9b-it"];
    
    for (String model in models) {
      try {
        print("=== API Call Debug ===");
        print("User message: $userMessage");
        print("Trying model: $model");
        
        // Build conversation context with system message
        List<Map<String, String>> messages = [
          {
            "role": "system",
            "content": """You are ChefBot, a specialized cooking assistant. Your ONLY purpose is to help with cooking and recipes.

STRICT RULES:
1. ONLY respond to cooking-related questions (ingredients, recipes, cooking techniques, meal planning, nutrition related to food)
2. For ANY non-cooking question, respond: "I'm ChefBot! I only help with cooking and recipes. What ingredients do you have today?"
3. When users mention ingredients, suggest 2-3 specific recipes that use those ingredients
4. Always provide step-by-step cooking instructions
5. Be friendly and encouraging about cooking
6. If someone asks about restaurants, food delivery, or non-cooking food topics, redirect them back to cooking

Examples of what you should help with:
- Recipe suggestions based on ingredients
- Cooking instructions and techniques
- Ingredient substitutions
- Meal planning
- Food preparation tips

Examples of what you should NOT help with:
- Weather, news, general chat
- Non-food related topics
- Restaurant recommendations
- Food delivery services"""
          }
        ];

        // Add conversation history (only bot and user messages, skip system)
        for (var message in conversationHistory.take(8).where((msg) => msg.role != "system")) {
          messages.add({
            "role": message.role == "user" ? "user" : "assistant",
            "content": message.content,
          });
        }

        // Add current user message
        messages.add({
          "role": "user",
          "content": userMessage,
        });

        print("Messages count: ${messages.length}");
        print("API URL: ${_dio.options.baseUrl}chat/completions");

        final response = await _dio.post(
          "chat/completions",
          data: {
            "messages": messages,
            "model": model,
            "temperature": 0.7,
            "max_tokens": 1000,
          },
          options: Options(
            sendTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          ),
        );

        print("Response status: ${response.statusCode}");
        print("Response data: ${response.data}");

        if (response.statusCode == 200 && response.data != null) {
          final choices = response.data['choices'];
          if (choices != null && choices.isNotEmpty) {
            final String generatedText = choices[0]['message']['content'].toString().trim();
            print("Generated text: $generatedText");
            print("✅ Success with model: $model");
            return generatedText;
          } else {
            print("No choices in response");
            continue; // Try next model
          }
        } else {
          print("Bad response: ${response.statusCode} - ${response.data}");
          continue; // Try next model
        }
      } on DioException catch (e) {
        print("DioException with $model: ${e.type} - ${e.message}");
        print("Response: ${e.response?.statusCode} - ${e.response?.data}");
        
        if (e.response?.statusCode == 401) {
          return "🔑 API key issue! Please check your Groq API key.";
        } else if (e.response?.statusCode == 400) {
          final errorData = e.response?.data;
          if (errorData is Map && errorData['error']?['message']?.toString().contains('decommissioned') == true) {
            print("❌ Model $model is decommissioned, trying next model...");
            continue; // Try next model
          }
          // If it's not a model issue and we're on the last model, return error
          if (model == models.last) {
            return "⚠️ Request error: ${errorData?['error']?['message'] ?? 'Bad request'}";
          }
          continue; // Try next model
        } else if (e.response?.statusCode == 429) {
          return "⏱️ Too many requests! Please wait a moment and try again.";
        } else if (e.type == DioExceptionType.connectionTimeout || 
                   e.type == DioExceptionType.receiveTimeout) {
          return "⏰ Connection timeout! Please check your internet and try again.";
        } else {
          // If this is the last model, return error
          if (model == models.last) {
            return "🌐 Network error: ${e.message ?? 'Please check your connection'}";
          }
          continue; // Try next model
        }
      } catch (e) {
        print("General error with $model: $e");
        if (model == models.last) {
          return "❌ Something went wrong: ${e.toString()}";
        }
        continue; // Try next model
      }
    }
    
    return "❌ All models failed. Please try again later.";
  }
}