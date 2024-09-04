import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primaryColor = Color(0xFF2196F3); // Blue
  static const Color _accentColor = Color(0xFF8BC34A); // Green
  static const Color _backgroundColor = Color(0xFFF7F7F7); // Light Gray
  static const Color _textColor = Color(0xFF333333); // Dark Gray

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: _primaryColor,
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _textColor),
        headline2: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _textColor),
        bodyText1: TextStyle(fontSize: 16, color: _textColor),
        bodyText2: TextStyle(fontSize: 14, color: _textColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: _primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: _accentColor).copyWith(background: _backgroundColor),
    );
  }
}