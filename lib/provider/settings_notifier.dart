import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingsNotifier extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;

  ThemeMode get mode => _mode;
  set mode(newValue) {
    if (mode != newValue) {
      _mode = newValue;
      notifyListeners();
    }
  }
}
