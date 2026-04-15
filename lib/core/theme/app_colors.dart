import 'package:flutter/material.dart';

class AppColors {
  // DARK PREMIUM PALETTE 🔥 - Startup-level colors
  // Primary colors - Professional Blue (#3B82F6)
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF60A999);

  // Secondary - Purple for premium gradient 🔥
  static const Color accentPurple = Color(0xFF8B5CF6);
  static const Color accentPurpleDark = Color(0xFF7C3AED);
  static const Color accentPurpleLight = Color(0xFFA78BFA);

  // Status colors - Clear & Consistent (VERY IMPORTANT)
  static const Color success = Color(0xFF22C55E); // ✅ Completed
  static const Color warning = Color(0xFFF59E0B); // ⏳ In Progress
  static const Color error = Color(0xFFEF4444); // ❗ Issue/Delay
  static const Color info = Color(0xFF3B82F6); // 📦 Received

  // Additional accent colors
  static const Color accentGreen = Color(0xFF22C55E);
  static const Color accentOrange = Color(0xFFF59E0B);
  static const Color accentRed = Color(0xFFEF4444);
  static const Color accentYellow = Color(0xFFFBBF24);
  static const Color accentTeal = Color(0xFF06B6D4);

  // Text colors - Light theme
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary = Color(0xFF64748B);
  static const Color textDisabled = Color(0xFF94A3B8);

  // Text colors - Dark Premium 🔥
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textTertiaryDark = Color(0xFF64748B);

  // Background colors - Light Clean SaaS
  static const Color backgroundLight = Color(0xFFF8FAFC); // Main bg - 95% white
  static const Color backgroundSecondaryLight = Color(
    0xFFFFFFFF,
  ); // Cards - pure white
  static const Color backgroundTertiaryLight = Color(0xFFF1F5F9);

  // Background colors - Dark Premium 🔥
  static const Color backgroundDark = Color(0xFF0F172A); // Deep Navy
  static const Color backgroundSecondaryDark = Color(0xFF1E293B); // Card bg
  static const Color backgroundTertiaryDark = Color(0xFF334155);

  // Card colors - Stand out
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E293B);

  // Divider colors
  static const Color dividerLight = Color(0xFFE2E8F0);
  static const Color dividerDark = Color(0xFF334155);

  // Shadow colors - Soft shadows (8pt grid)
  static const Color shadowLight = Color(0x0D000000); // Soft shadow
  static const Color shadowDark = Color(0x33000000); // Softer dark shadow

  // Shimmer colors
  static const Color shimmerBase = Color(0xFFE2E8F0);
  static const Color shimmerHighlight = Color(0xFFF1F5F9);
  static const Color shimmerBaseDark = Color(0xFF1E293B);
  static const Color shimmerHighlightDark = Color(0xFF334155);

  // Gradient colors - Blue to Purple 🔥 (Premium look)
  static const Color gradientStart = Color(0xFF3B82F6); // Blue
  static const Color gradientEnd = Color(0xFF8B5CF6); // Purple

  // Category colors - Professional palette
  static const Color categoryBlue = Color(0xFF3B82F6);
  static const Color categoryGreen = Color(0xFF22C55E);
  static const Color categoryOrange = Color(0xFFF59E0B);
  static const Color categoryPurple = Color(0xFF8B5CF6);
  static const Color categoryTeal = Color(0xFF06B6D4);
  static const Color categoryPink = Color(0xFFEC4899);

  // Glass effect colors (for premium cards - optional)
  static Color glassLight = Colors.white.withOpacity(0.7);
  static Color glassDark = const Color(0xFF1E293B).withOpacity(0.7);
}
