import 'package:flutter/material.dart';

class AppTheme {
  static const background = Color(0xFF231C6B);
  static const surface = Color(0xFF2E2789);
  static const primary = Color(0xFF4F46E5);
  static const primarySoft = Color(0xFF3A32A0);

  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFC5BFEE);
  static const textTertiary = Color(0xFF948CCB);

  static const border = Color(0xFF443BA5);

  static const success = Color(0xFF16A34A);
  static const warning = Color(0xFFF59E0B);
  static const danger = Color(0xFFEF4444);
  static const favorite = Color(0xFFF43F5E);

  static const flutter = Color(0xFF0553B1);
  static const android = Color(0xFF1DA260);
  static const layouts = Color(0xFFF59E0B);
  static const scrollables = Color(0xFFDB2777);
  static const slivers = Color(0xFF7C3AED);
  static const navigation = Color(0xFFDC2626);

  static const flutterLight = Color(0xFF54C5F8);
  static const androidLight = Color(0xFF4ADE80);
  static const layoutsLight = Color(0xFFFCD34D);
  static const scrollablesLight = Color(0xFFF9A8D4);
  static const sliversLight = Color(0xFFC4B5FD);
  static const navigationLight = Color(0xFFFCA5A5);

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: background,

    colorScheme: const ColorScheme.dark(
      primary: primary,
      surface: surface,
      onPrimary: textPrimary,
      onSurface: textPrimary,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      foregroundColor: textPrimary,
      elevation: 0,
    ),

    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: surface,
      indicatorColor: primary,
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(
          color: textPrimary,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}