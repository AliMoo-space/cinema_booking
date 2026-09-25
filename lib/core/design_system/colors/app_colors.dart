import 'package:flutter/material.dart';

@immutable
final class AppColors {
  const AppColors._();

  // ===========================================================================
  // Brand
  // ===========================================================================

  /// Primary - Deep Navy
  /// Navigation, page titles, primary buttons, key structure.
  static const Color primary = Color(0xFF243B53);

  /// Secondary - Steel Blue
  /// Secondary actions, active states, informational emphasis.
  static const Color secondary = Color(0xFF486581);

  /// Accent - Muted Green
  /// Positive highlights, selected insights, subtle emphasis.
  static const Color accent = Color(0xFF5B8C6A);

  /// Text/icons displayed on primary color.
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// Text/icons displayed on secondary color.
  static const Color onSecondary = Color(0xFFFFFFFF);

  /// Text/icons displayed on accent color.
  static const Color onAccent = Color(0xFFFFFFFF);

  // ===========================================================================
  // Semantic
  // ===========================================================================

  /// Success - Approved, present, completed.
  static const Color success = Color(0xFF3F7D5A);

  /// Warning - Pending, late, needs review.
  static const Color warning = Color(0xFFC58B2A);

  /// Error - Rejected, absent, destructive actions.
  static const Color error = Color(0xFFB44A4A);

  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color onWarning = Color(0xFFFFFFFF);
  static const Color onError = Color(0xFFFFFFFF);

  // ===========================================================================
  // Background
  // ===========================================================================

  /// Main application background.
  static const Color background = Color(0xFFF5F7F8);

  static const Color onBackground = Color(0xFF202B33);

  // ===========================================================================
  // Surface
  // ===========================================================================

  /// Cards, tables, modals and forms.
  static const Color surface = Color(0xFFFFFFFF);

  static const Color surfaceLowest = Color(0xFFFFFFFF);
  static const Color surfaceLow = Color(0xFFF5F7F8);
  static const Color surfaceContainer = Color(0xFFF5F7F8);
  static const Color surfaceHigh = Color(0xFFFFFFFF);
  static const Color surfaceHighest = Color(0xFFFFFFFF);

  static const Color onSurface = Color(0xFF202B33);
  static const Color onSurfaceVariant = Color(0xFF6B7785);

  // ===========================================================================
  // Text
  // ===========================================================================

  /// Headings and primary content.
  static const Color textPrimary = Color(0xFF202B33);

  /// Metadata, labels and supporting copy.
  static const Color textSecondary = Color(0xFF6B7785);

  /// Placeholder text.
  static const Color textHint = Color(0xFF6B7785);

  /// Disabled text.
  static const Color textDisabled = Color(0xFF9AA5AF);

  /// White text.
  static const Color textInverse = Color(0xFFFFFFFF);

  // ===========================================================================
  // Border
  // ===========================================================================

  /// Dividers, inputs and card borders.
  static const Color border = Color(0xFFD9E2EC);

  static const Color divider = Color(0xFFD9E2EC);
  static const Color outline = Color(0xFF6B7785);
  static const Color outlineVariant = Color(0xFFD9E2EC);

  // ===========================================================================
  // States
  // ===========================================================================

  static const Color disabled = Color(0xFFE5E9ED);

  static const Color focus = primary;

  static const Color hover = Color(0xFFF5F7F8);

  static const Color pressed = Color(0xFFE8EDF1);

  static const Color selected = Color(0xFFE8F0EB);

  // ===========================================================================
  // Overlay
  // ===========================================================================

  static const Color overlay = Color(0x66000000);
  static const Color scrim = Color(0x99000000);

  // ===========================================================================
  // Common
  // ===========================================================================

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
}