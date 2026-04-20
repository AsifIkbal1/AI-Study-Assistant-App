import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

class SettingsNotifier extends StateNotifier<AsyncValue<String?>> {
  final SharedPreferences _prefs;
  static const String _apiKey = 'ai_api_key';

  SettingsNotifier(this._prefs) : super(const AsyncValue.loading()) {
    _loadApiKey();
  }

  void _loadApiKey() {
    final key = _prefs.getString(_apiKey);
    state = AsyncValue.data(key);
  }

  Future<void> setApiKey(String key) async {
    await _prefs.setString(_apiKey, key);
    state = AsyncValue.data(key);
  }

  Future<void> removeApiKey() async {
    await _prefs.remove(_apiKey);
    state = const AsyncValue.data(null);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, AsyncValue<String?>>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SettingsNotifier(prefs);
});
