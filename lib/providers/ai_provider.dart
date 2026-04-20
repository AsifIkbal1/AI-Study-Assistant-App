import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_service.dart';
import 'settings_provider.dart';

final aiServiceProvider = Provider<AIService>((ref) {
  final apiKeyAsync = ref.watch(settingsProvider);
  
  return apiKeyAsync.when(
    data: (key) => GroqService(apiKey: key ?? ""),
    loading: () => GroqService(apiKey: ""),
    error: (e, st) => GroqService(apiKey: ""),
  );
});
