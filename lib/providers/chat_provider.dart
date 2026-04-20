import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/models/chat_message.dart';
import '../services/ai_service.dart';
import 'ai_provider.dart';

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  final AIService _aiService;
  final Box<ChatMessage> _chatBox;

  ChatNotifier(this._aiService, this._chatBox) : super(_chatBox.values.toList());

  Future<void> sendMessage(String text) async {
    final userMsg = ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    state = [...state, userMsg];
    _chatBox.add(userMsg);

    // Get AI response
    final responseText = await _aiService.getCompletion(text);
    final aiMsg = ChatMessage(
      text: responseText,
      isUser: false,
      timestamp: DateTime.now(),
    );

    state = [...state, aiMsg];
    _chatBox.add(aiMsg);
  }

  void clearHistory() {
    _chatBox.clear();
    state = [];
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>((ref) {
  final aiService = ref.watch(aiServiceProvider);
  final box = Hive.box<ChatMessage>('chat_history');
  return ChatNotifier(aiService, box);
});
