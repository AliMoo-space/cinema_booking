import 'package:cinema_booking/core/design_system/colors/app_colors.dart';
import 'package:cinema_booking/core/design_system/typography/app_text_styles.dart';
import 'package:flutter/material.dart';

@immutable
class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    this.style,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.fontSize,
    this.height,
    this.letterSpacing,
    this.textDirection,
    this.softWrap,
    this.textScaler,
  });

  final String data;

  final TextStyle? style;

  final Color? color;

  final FontWeight? fontWeight;

  final double? fontSize;

  final double? height;

  final double? letterSpacing;

  final TextAlign? textAlign;

  final int? maxLines;

  final TextOverflow? overflow;

  final TextDirection? textDirection;

  final bool? softWrap;

  final TextScaler? textScaler;

  @override
  Widget build(BuildContext context) {
    final textStyle = (style ?? AppTextStyles.bodyMedium).copyWith(
      color:
          color ??
          (style ?? AppTextStyles.bodyMedium).color ??
          AppColors.textPrimary,
      fontWeight: fontWeight,
      fontSize: fontSize,
      height: height,
      letterSpacing: letterSpacing,
    );
    return Text(
      data,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      textDirection: textDirection,
      softWrap: softWrap,
      textScaler: textScaler,
      style: textStyle,
    );
  }
}
