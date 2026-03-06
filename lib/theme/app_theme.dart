import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const _primary = Color(0xFF1A73E8);
  static const _secondary = Color(0xFF34A853);
  static const _error = Color(0xFFEA4335);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primary,
          secondary: _secondary,
          error: _error,
          brightness: Brightness.light,
        ),
        navigationRailTheme: const NavigationRailThemeData(
          backgroundColor: Color(0xFFF8F9FA),
          indicatorColor: Color(0xFFE8F0FE),
        ),
        cardTheme: CardThemeData(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color(0xFFF8F9FA),
          foregroundColor: Color(0xFF202124),
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _primary,
          secondary: _secondary,
          error: _error,
          brightness: Brightness.dark,
        ),
      );
}
