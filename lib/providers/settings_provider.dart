import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _darkMode = false;
  Color _themeColor = Colors.blue; // Default theme color
  SharedPreferences? prefs;

  bool get darkMode => _darkMode;
  Color get themeColor => _themeColor;

  SettingsProvider() {
    initPreferences();
  }

  void toggleMode() {
    _darkMode = !_darkMode;
    _savePreferences();
    notifyListeners();
  }

  void setThemeColor(Color color) {
    _themeColor = color;
    _savePreferences();
    notifyListeners();
  }

  void initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      _darkMode = prefs!.getBool('darkMode') ?? false;
      int? colorValue = prefs!.getInt('themeColor');
      if (colorValue != null) {
        _themeColor = Color(colorValue);
      }
    }
    notifyListeners();
  }

  void _savePreferences() {
    if (prefs != null) {
      prefs!.setBool('darkMode', _darkMode);
      prefs!.setInt('themeColor', _themeColor.value);
    }
  }
}
