// ignore: unnecessary_import
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../colors/app_colors.dart';
@immutable
final class AppTextStyles {
  const AppTextStyles._();

  // ============================================================
  // Font Families
  // ============================================================

  static const String headingFontFamily = 'Inter';
  static const String bodyFontFamily = 'Inter';

  // ============================================================
  // Display
  // ============================================================

  static TextStyle displayLarge = TextStyle(
    fontFamily: headingFontFamily,

    // التغيير: استخدمنا .sp بدل رقم ثابت عشان حجم الخط يكون Responsive.
    fontSize: 40.sp,
    fontWeight: FontWeight.w700,

    // التغيير: الـ height يفضل Ratio ثابت، ومش بنستخدم .h هنا.
    height: 48 / 40,

    color: AppColors.textPrimary,
  );

  static TextStyle displayMedium = TextStyle(
    fontFamily: headingFontFamily,

    // التغيير: حجم الخط أصبح Responsive باستخدام .sp.
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    height: 40 / 32,
    color: AppColors.textPrimary,
  );

  static TextStyle displaySmall = TextStyle(
    fontFamily: headingFontFamily,

    // التغيير: استخدمنا .sp عشان الحجم يتناسب مع حجم الشاشة.
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    height: 36 / 28,
    color: AppColors.textPrimary,
  );

  // ============================================================
  // Headline
  // ============================================================

  static TextStyle headlineLarge = TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    height: 36 / 28,
    color: AppColors.textPrimary,
  );

  static TextStyle headlineMedium = TextStyle(
    fontFamily: headingFontFamily,

    // التغيير: استخدمنا .sp بدل الحجم الثابت.
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    height: 32 / 24,
    color: AppColors.textPrimary,
  );

  static TextStyle headlineSmall = TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
    color: AppColors.textPrimary,
  );

  // ============================================================
  // Title
  // ============================================================

  static TextStyle titleLarge = TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
    color: AppColors.textPrimary,
  );

  static TextStyle titleMedium = TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 24 / 16,
    color: AppColors.textPrimary,
  );

  static TextStyle titleSmall = TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 20 / 14,
    color: AppColors.textPrimary,
  );

  // ============================================================
  // Body
  // ============================================================

  static TextStyle bodyLarge = TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    color: AppColors.textPrimary,
  );

  static TextStyle bodyMedium = TextStyle(
    fontFamily: bodyFontFamily,

    // التغيير: استخدمنا .sp بدل fontSize ثابت.
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: AppColors.textPrimary,
  );

  static TextStyle bodySmall = TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    color: AppColors.textSecondary,
  );

  // ============================================================
  // Label
  // ============================================================

  static TextStyle labelLarge = TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 20 / 14,
    color: AppColors.textPrimary,
  );

  static TextStyle labelMedium = TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    color: AppColors.textSecondary,
  );

  static TextStyle labelSmall = TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    height: 16 / 11,
    color: AppColors.textSecondary,
  );

  // ============================================================
  // Custom Styles
  // ============================================================

  static TextStyle hint = TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: AppColors.textHint,
  );

  static TextStyle disabled = TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: AppColors.textDisabled,
  );

  static TextStyle inverse = TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: AppColors.textInverse,
  );
}
