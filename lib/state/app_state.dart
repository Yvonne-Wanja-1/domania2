import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/preferences_service.dart';

class AppState extends ChangeNotifier {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;

  late PreferencesService _preferencesService;
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  AppState._internal() {
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _preferencesService = PreferencesService(prefs);
    await loadThemePreference();
  }

  Future<void> toggleTheme(bool isDark) async {
    _isDarkMode = isDark;
    await _preferencesService.setThemeMode(isDark ? 'dark' : 'light');
    notifyListeners();
  }

  Future<void> loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _preferencesService = PreferencesService(prefs);
    _isDarkMode = _preferencesService.getThemeMode() == 'dark';
    notifyListeners();
  }
}
