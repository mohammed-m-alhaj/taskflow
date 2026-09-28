import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../services/api_service.dart';

class SettingsProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  final ApiService _apiService = ApiService();

  ThemeMode _themeMode = ThemeMode.system;
  bool _notificationsEnabled = true;
  bool _dailyReminderEnabled = true;
  String _language = 'ar';

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get dailyReminderEnabled => _dailyReminderEnabled;
  String get language => _language;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final savedMode = await _storageService.getThemeMode();
    if (savedMode != null) {
      if (savedMode == 'dark') {
        _themeMode = ThemeMode.dark;
      } else if (savedMode == 'light') {
        _themeMode = ThemeMode.light;
      } else {
        _themeMode = ThemeMode.system;
      }
    }
    final savedLang = await _storageService.getLanguage();
    if (savedLang != null) {
      _language = savedLang;
    }
    notifyListeners();
  }

  Future<void> syncWithBackend() async {
    if (!_apiService.hasToken) return;
    try {
      final data = await _apiService.getUserSettings();
      if (data.containsKey('theme')) {
        final t = data['theme'] as String?;
        if (t == 'dark') {
          _themeMode = ThemeMode.dark;
        } else if (t == 'light') {
          _themeMode = ThemeMode.light;
        }
      }
      if (data.containsKey('notifications_enabled')) {
        _notificationsEnabled = data['notifications_enabled'] as bool? ?? true;
      }
      if (data.containsKey('language')) {
        _language = data['language'] as String? ?? 'ar';
      }
      notifyListeners();
    } catch (_) {}
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    String modeString = 'system';
    if (mode == ThemeMode.dark) {
      modeString = 'dark';
    } else if (mode == ThemeMode.light) {
      modeString = 'light';
    }
    await _storageService.saveThemeMode(modeString);
    if (_apiService.hasToken) {
      try {
        await _apiService.updateUserSettings({'theme': modeString});
      } catch (_) {}
    }
  }

  Future<void> setLanguage(String lang) async {
    _language = lang;
    notifyListeners();
    await _storageService.saveLanguage(lang);
    if (_apiService.hasToken) {
      try {
        await _apiService.updateUserSettings({'language': lang});
      } catch (_) {}
    }
  }

  Future<void> toggleNotifications(bool value) async {
    _notificationsEnabled = value;
    notifyListeners();
    if (_apiService.hasToken) {
      try {
        await _apiService.updateUserSettings({'notifications_enabled': value});
      } catch (_) {}
    }
  }

  void toggleDailyReminder(bool value) {
    _dailyReminderEnabled = value;
    notifyListeners();
  }
}
