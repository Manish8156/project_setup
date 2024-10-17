import 'package:flutter/material.dart';

class AppTheme {
  /// for light theme
  ThemeData get lightTheme {
    return ThemeData.light().copyWith();
  }

  ThemeData get darkTheme {
    return lightTheme;
  }
}
