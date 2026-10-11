// Mirrors lib/config/theme/app_colors.dart in the HMS app; keep both in sync.
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xFF502455);
  static const purpleDark = Color(0xFF421D3F);
  static const secondary = Color(0xFF86537C);

  static const lightBackground = Color(0xFFEFEFEF);
  static const lightBorder = Color(0xFFE3E8F3);
  static const cardBackground = Color(0xFFFAFAFA);

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const textSecondary = Color(0xFF5B5F76);
  static const textMuted = Color(0xFF6C7891);

  // STATUS =========================
  static const Color success = Color(0xFF54D62C);
  static const Color successLight = Color(0xFFDBF4CE);
  static const Color warning = Color(0xFFFF9142);
  static const Color warningLight = Color(0xFFFFE9E1);
  static const Color danger = Color(0xFFFF4343);
  static const Color dangerLight = Color(0xFFFFE2E2);
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFFE3F2FD);

  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondary, primary],
  );
}
