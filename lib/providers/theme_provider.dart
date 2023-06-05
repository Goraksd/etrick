import 'package:etrick/app_theme.dart';
import 'package:flutter/material.dart';


class AppThemeProvider with ChangeNotifier, WidgetsBindingObserver {
  late ThemeData _currentTheme;
  late Brightness _brightness;
  ThemeMode _selectedTheme = ThemeMode.system;

  AppThemeProvider() {
    WidgetsBinding.instance.addObserver(this);
    _currentTheme =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark
            ? AppTheme.darkTheme
            : AppTheme.lightTheme;
  }

  @override
  void didChangePlatformBrightness() {
    _brightness = WidgetsBinding.instance.window.platformBrightness;
    if (_brightness == Brightness.dark) {
      _currentTheme = AppTheme.darkTheme;
    } else if (_brightness == Brightness.light) {
      _currentTheme = AppTheme.lightTheme;
    }
    notifyListeners();
  }

  ThemeMode get selectedThemeMode => _selectedTheme;
  Brightness get currentBrightness => _brightness;

  ThemeData get selectedTheme {
    if (_selectedTheme == ThemeMode.system) {
      return _currentTheme;
    } else if (_selectedTheme == ThemeMode.light) {
      return AppTheme.lightTheme;
    } else {
      return AppTheme.darkTheme;
    }
  }

  void toggleTheme() {
    if (_selectedTheme == ThemeMode.system) {
      _selectedTheme = ThemeMode.light;
    } else if (_selectedTheme == ThemeMode.light) {
      _selectedTheme = ThemeMode.dark;
    } else {
      _selectedTheme = ThemeMode.system;
    }
    notifyListeners();
  }
}
