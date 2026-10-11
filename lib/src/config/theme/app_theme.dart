// Mirrors lib/config/theme/app_theme.dart in the HMS app; keep both in sync.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => _base(
    brightness: Brightness.light,
    scaffold: AppColors.lightBackground,
    cardColor: AppColors.cardBackground,
    cardBorder: AppColors.white,
    textColor: AppColors.black,
    primary: AppColors.primary,
  );

  static ThemeData _base({
    required Brightness brightness,
    required Color scaffold,
    required Color cardColor,
    required Color cardBorder,
    required Color textColor,
    required Color primary,
  }) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      error: AppColors.danger,
      onError: Colors.white,
      surface: cardColor,
      onSurface: textColor,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      fontFamily: 'Poppins',
      canvasColor: cardBorder,

      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.white,
          systemNavigationBarDividerColor: AppColors.white,
          systemNavigationBarColor: AppColors.white,
        ),
        backgroundColor: scaffold,
        foregroundColor: textColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      // No shadow — flat, bordered cards per the design reference.
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(color: cardBorder),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        hintStyle: TextStyle(color: AppColors.textMuted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primary, width: 1.4),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(0, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      dividerColor: cardBorder,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
        headlineSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        titleLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        titleMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
      ),
    );
  }
}

/// Every screen uses these — never a raw TextStyle — so dark mode "just
/// works" without any screen touching color logic itself.
extension AppTextStyles on BuildContext {
  TextStyle get extraBold => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get bold => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get semiBold => Theme.of(this).textTheme.headlineSmall!;
  TextStyle get medium => Theme.of(this).textTheme.titleLarge!;
  TextStyle get regular => Theme.of(this).textTheme.titleMedium!;
}
