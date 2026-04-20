import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme.dart';
import 'data/models/chat_message.dart';
import 'data/models/study_goal.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive Adapters
  Hive.registerAdapter(StudyGoalAdapter());
  Hive.registerAdapter(ChatMessageAdapter());

  // Open Boxes
  await Hive.openBox<StudyGoal>('study_goals');
  await Hive.openBox<ChatMessage>('chat_history');

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const StudyGenieApp(),
    ),
  );
}

class StudyGenieApp extends StatelessWidget {
  const StudyGenieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudyGenie AI',
      theme: AppTheme.lightTheme, // Switched to light theme
      home: const OnboardingScreen(),
    );
  }
}
