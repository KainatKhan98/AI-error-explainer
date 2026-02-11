import 'package:flutter/material.dart';

class AppTheme {
  static final lightPurpleGrey = ThemeData.light().copyWith(
    // Scaffold background
    scaffoldBackgroundColor: const Color(0xFFF3F4F6), // light grey

    // AppBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF6D28D9), // deep purple
      foregroundColor: Colors.white,
      elevation: 2,
    ),

    // Input decoration (text fields)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white, // white background for inputs
      hintStyle: const TextStyle(color: Color(0xFF6B7280)), // grey hint
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)), // light grey
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
      ),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6D28D9), // purple
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    // Text theme
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black87),
      titleLarge: TextStyle(
        color: Color(0xFF6D28D9),
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );
}
