import 'package:flutter/material.dart';
import 'package:cinema_booking/core/design_system/widgets/inputs/app_text_field.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.hintText = 'Search...',
    this.enabled = true,
    this.autofocus = false,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  final String hintText;

  final bool enabled;
  final bool autofocus;

  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      hintText: hintText,
      enabled: enabled,
      autofocus: autofocus,
      suffixIcon: suffixIcon,
      type: AppTextFieldType.search,
      textInputAction: TextInputAction.search,
    );
  }
}
