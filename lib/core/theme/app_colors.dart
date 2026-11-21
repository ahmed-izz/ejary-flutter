import 'package:flutter/material.dart';

abstract final class AppColors {
  // Light Palette - Warm Organic Modern
  static const Color lightBackground = Color(0xFFF7F5F0); // Warm Linen
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceAlt = Color(0xFFEFECE6); // Soft Sand
  static const Color lightBorder = Color(0xFFE3DFD7);
  static const Color lightTextPrimary =
      Color(0xFF1E211E); // Deep Olive Charcoal
  static const Color lightTextSecondary = Color(0xFF686D65);

  // Dark Palette - Warm Deep Charcoal
  static const Color darkBackground = Color(0xFF141614);
  static const Color darkSurface = Color(0xFF1E211D);
  static const Color darkSurfaceAlt = Color(0xFF272B26);
  static const Color darkBorder = Color(0xFF313630);
  static const Color darkTextPrimary = Color(0xFFF1EFEA);
  static const Color darkTextSecondary = Color(0xFF9EA49B);

  // Brand Accents
  static const Color primary = Color(0xFF2D5A4C); // Deep Sage
  static const Color primaryLight = Color(0xFF6FA392); // Muted Sage (Dark mode)
  static const Color secondary = Color(0xFFC86D51); // Warm Terracotta
  static const Color secondarySoft = Color(0xFFF4E4DF);

  // Semantic
  static const Color success = Color(0xFF3B7A57);
  static const Color warning = Color(0xFFD18B3B);
  static const Color error = Color(0xFFB84A4A);
}
