import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color moss = Color(0xFF183A2D);
  static const Color fern = Color(0xFF2F6B4F);
  static const Color sage = Color(0xFFDDE8D5);
  static const Color cream = Color(0xFFF4F6F0);
  static const Color amber = Color(0xFFF2B35B);
  static const Color ink = Color(0xFF1E2A22);
  static const Color mist = Color(0xFF55635A);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
  );
  static ThemeData darkTheme = ThemeData();
}
