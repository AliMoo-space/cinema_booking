import 'package:flutter/material.dart';

/// =============================================================================
/// App Radius
/// =============================================================================
///
/// Corner radius tokens used across the application.
///
/// Based on the design system.
///
/// Example:
///
/// Container(
///   decoration: BoxDecoration(
///     borderRadius: BorderRadius.circular(AppRadius.radius16),
///   ),
/// )
///
/// =============================================================================

@immutable
abstract final class AppRadius {
  const AppRadius._();

  /// Sharp edges.
  static const double radius0 = 0;

  /// Extra Small
  static const double radius4 = 4;

  /// Small
  static const double radius8 = 8;

  /// Medium
  static const double radius12 = 12;

  /// Large
  static const double radius16 = 16;

  /// Extra Large
  static const double radius20 = 20;

  /// Huge
  static const double radius24 = 24;

  /// Extra Huge
  static const double radius32 = 32;

  /// Fully rounded.
  static const double radiusFull = 9999;
}
