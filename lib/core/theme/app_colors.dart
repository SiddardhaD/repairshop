import 'package:flutter/material.dart';

class AppColors {
  // Primary colors - Softer, more professional blue
  static const Color primaryBlue = Color(0xFF5B8DEF);
  static const Color primaryDark = Color(0xFF4A7AD9);
  static const Color primaryLight = Color(0xFF7BA5F5);

  // Accent colors - Professional palette
  static const Color accentGreen = Color(0xFF22C55E);
  static const Color accentOrange = Color(0xFFFF9F43);
  static const Color accentRed = Color(0xFFFF6B6B);
  static const Color accentPurple = Color(0xFF9B7EF8);
  static const Color accentYellow = Color(0xFFFFCA3A);
  static const Color accentTeal = Color(0xFF06B6D4);

  // Status colors
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFFF9F43);
  static const Color error = Color(0xFFFF6B6B);
  static const Color info = Color(0xFF5B8DEF);

  // Text colors - Better contrast
  static const Color textPrimary = Color(0xFF1A202C);
  static const Color textSecondary = Color(0xFF4A5568);
  static const Color textTertiary = Color(0xFF718096);
  static const Color textDisabled = Color(0xFFCBD5E0);

  // Dark mode text
  static const Color textPrimaryDark = Color(0xFFF7FAFC);
  static const Color textSecondaryDark = Color(0xFFE2E8F0);
  static const Color textTertiaryDark = Color(0xFFA0AEC0);

  // Background colors - Softer, more professional (NOT pure white)
  static const Color backgroundLight = Color(
    0xFFF5F7FA,
  ); // 95% white - subtle gray
  static const Color backgroundSecondaryLight = Color(
    0xFFFFFFFF,
  ); // Pure white for cards
  static const Color backgroundTertiaryLight = Color(0xFFEDF0F5);

  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color backgroundSecondaryDark = Color(0xFF1E293B);
  static const Color backgroundTertiaryDark = Color(0xFF334155);

  // Card colors - Pure white to stand out on gray background
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E293B);

  // Divider colors
  static const Color dividerLight = Color(0xFFE2E8F0);
  static const Color dividerDark = Color(0xFF334155);

  // Shadow colors
  static const Color shadowLight = Color(0x08000000);
  static const Color shadowDark = Color(0x20000000);

  // Shimmer colors
  static const Color shimmerBase = Color(0xFFE2E8F0);
  static const Color shimmerHighlight = Color(0xFFF7FAFC);
  static const Color shimmerBaseDark = Color(0xFF334155);
  static const Color shimmerHighlightDark = Color(0xFF475569);

  // Gradient colors for modern look
  static const Color gradientStart = Color(0xFF6BA3F7);
  static const Color gradientEnd = Color(0xFF5B8DEF);

  // Category colors - Professional palette
  static const Color categoryBlue = Color(0xFF5B8DEF);
  static const Color categoryGreen = Color(0xFF22C55E);
  static const Color categoryOrange = Color(0xFFFF9F43);
  static const Color categoryPurple = Color(0xFF9B7EF8);
  static const Color categoryTeal = Color(0xFF06B6D4);
  static const Color categoryPink = Color(0xFFEC4899);
}
