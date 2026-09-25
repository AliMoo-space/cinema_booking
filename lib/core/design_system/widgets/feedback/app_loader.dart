import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:gap/gap.dart';

import 'package:cinema_booking/core/design_system/colors/app_colors.dart';
import 'package:cinema_booking/core/design_system/widgets/text/app_text.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
    this.size = 28,
    this.strokeWidth = 3,
    this.color,
  });

  const AppLoader.small({super.key, this.strokeWidth = 2.5, this.color})
    : size = 18;

  const AppLoader.large({super.key, this.strokeWidth = 4, this.color})
    : size = 40;

  final double size;
  final double strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    // التغيير: جعلنا حجم الـ Loader Responsive باستخدام .w.
    final double resolvedSize = size.w;

    // التغيير: جعلنا سمك الـ Loader Responsive باستخدام .w.
    final double resolvedStrokeWidth = strokeWidth.w;

    return SizedBox.square(
      dimension: resolvedSize,
      child: CircularProgressIndicator(
        strokeWidth: resolvedStrokeWidth,
        color: color ?? AppColors.primary,
      ),
    );
  }
}

class AppFullScreenLoader extends StatelessWidget {
  const AppFullScreenLoader({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLoader.large(),
            if (message != null) ...[const Gap(16), AppText(message!)],
          ],
        ),
      ),
    );
  }
}

class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
  });

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,

        if (isLoading)
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black26,
              child: const Center(child: AppLoader.large()),
            ),
          ),
      ],
    );
  }
}
