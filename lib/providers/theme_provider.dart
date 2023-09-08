import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../config/theme.dart';

class DarkThemeProvider with ChangeNotifier {
  bool get isDarkMode => _isDarkMode;

  static late final SharedPreferences prefs;

  bool _isDarkMode = prefs.getBool('isDarkMode') ?? true;

  static Future init() async => prefs = await SharedPreferences.getInstance();

  // ignore: non_constant_identifier_names
  ThemeProvider() {
    _loadThemePreference();
  }

  ThemeData getTheme() {
    return _isDarkMode ? darkThem : lightTheme;
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _saveThemePreference();
    notifyListeners();
  }

  Future<void> _loadThemePreference() async {
    _isDarkMode = prefs.getBool('isDarkMode')!;
    notifyListeners();
  }

  Future<void> _saveThemePreference() async {
    prefs.setBool('isDarkMode', _isDarkMode);
  }
}
