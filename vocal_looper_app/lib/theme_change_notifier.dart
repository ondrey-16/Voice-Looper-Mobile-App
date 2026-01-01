import 'package:flutter/material.dart';

class ThemeChangeNotifier extends ChangeNotifier {
  bool isDark = true;
  void changeTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
