import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import 'package:cinema_booking/core/design_system/colors/app_colors.dart';
import 'package:cinema_booking/core/design_system/spacing/app_radius.dart';
import 'package:cinema_booking/core/design_system/spacing/app_spacing.dart';
import 'package:cinema_booking/core/design_system/typography/app_text_styles.dart';
import 'package:cinema_booking/core/design_system/widgets/text/app_text.dart';

enum AppTextFieldType {
  text,
  email,
  password,
  phone,
  number,
  search,
  multiline,
}

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.type = AppTextFieldType.text,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.autofillHints,
    this.contentPadding,
    this.fillColor,
    this.borderRadius = AppRadius.radius12,
    this.obscureText,
    this.textAlign = TextAlign.start,
    this.initialValue,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.enableInteractiveSelection = true,
    this.mouseCursor,
  });

  final AutovalidateMode autovalidateMode;
  final TextEditingController? controller;
  final bool enableInteractiveSelection;
  final MouseCursor? mouseCursor;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final String? label;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final AppTextFieldType type;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final double borderRadius;
  final bool? obscureText;
  final TextAlign textAlign;
  final String? initialValue;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscure;

  bool get _isPassword => widget.type == AppTextFieldType.password;

  @override
  void initState() {
    super.initState();

    _obscure = widget.obscureText ?? _isPassword;
  }

  Widget? get _prefixIcon {
    if (widget.prefixIcon != null) {
      return widget.prefixIcon;
    }

    switch (widget.type) {
      case AppTextFieldType.search:
        return const Icon(Icons.search_rounded, color: AppColors.textSecondary);

      default:
        return null;
    }
  }

  void _togglePassword() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  TextInputType get _keyboardType {
    if (widget.keyboardType != null) {
      return widget.keyboardType!;
    }

    switch (widget.type) {
      case AppTextFieldType.email:
        return TextInputType.emailAddress;

      case AppTextFieldType.phone:
        return TextInputType.phone;

      case AppTextFieldType.number:
        return const TextInputType.numberWithOptions(decimal: true);

      case AppTextFieldType.multiline:
        return TextInputType.multiline;

      case AppTextFieldType.search:
        return TextInputType.text;

      default:
        return TextInputType.text;
    }
  }

  TextInputAction get _textInputAction {
    if (widget.textInputAction != null) {
      return widget.textInputAction!;
    }

    if (widget.nextFocusNode != null) {
      return TextInputAction.next;
    }

    if (widget.type == AppTextFieldType.multiline) {
      return TextInputAction.newline;
    }

    if (widget.type == AppTextFieldType.search) {
      return TextInputAction.search;
    }

    return TextInputAction.done;
  }

  Iterable<String>? get _autofillHints {
    if (widget.autofillHints != null) {
      return widget.autofillHints;
    }

    switch (widget.type) {
      case AppTextFieldType.email:
        return const [AutofillHints.email];

      case AppTextFieldType.password:
        return const [AutofillHints.password];

      case AppTextFieldType.phone:
        return const [AutofillHints.telephoneNumber];

      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final decoration = InputDecoration(
      hintText: widget.hintText,
      prefixIcon: _prefixIcon,
      suffixIcon: _buildSuffixIcon(),
      filled: true,

      // التغيير: استخدام لون مختلف للحالة المعطلة للحفاظ على وضوح الـ UI.
      fillColor: widget.enabled
          ? widget.fillColor ?? AppColors.surfaceLowest
          : AppColors.disabled,

      counterText: '',
      contentPadding:
          widget.contentPadding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.space16,
            vertical: AppSpacing.space16,
          ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: const BorderSide(color: AppColors.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: const BorderSide(color: AppColors.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),

      // التغيير: إضافة Border خاص بالحالة المعطلة.
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: const BorderSide(color: AppColors.outlineVariant),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          AppText(
            widget.label!,
            style: AppTextStyles.labelMedium.copyWith(
              color: widget.enabled
                  ? AppColors.textPrimary
                  : AppColors.textDisabled,
            ),
          ),
          const Gap(AppSpacing.space8),
        ],
        TextFormField(
          controller: widget.controller,
          initialValue: widget.controller == null ? widget.initialValue : null,
          focusNode: widget.focusNode,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          obscureText: _obscure,
          keyboardType: _keyboardType,
          textInputAction: _textInputAction,
          textCapitalization: widget.type == AppTextFieldType.email
              ? TextCapitalization.none
              : widget.textCapitalization,
          inputFormatters: _inputFormatters,
          autofillHints: _autofillHints,
          textAlign: widget.textAlign,
          maxLength: widget.maxLength,
          minLines: widget.minLines,
          autovalidateMode: widget.autovalidateMode,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          cursorColor: AppColors.primary,
          mouseCursor: widget.mouseCursor,

          // التغيير: استخدام قيمة موجودة في AppSpacing بدل الرقم الثابت 120.
          scrollPadding: const EdgeInsets.all(AppSpacing.space96),

          enableSuggestions: !_isPassword,
          autocorrect: !_isPassword,
          maxLines: widget.type == AppTextFieldType.multiline
              ? (widget.maxLines ?? 5)
              : 1,
          style: AppTextStyles.bodyMedium,
          decoration: decoration,
          onFieldSubmitted: (value) {
            widget.onSubmitted?.call(value);

            if (widget.nextFocusNode != null) {
              FocusScope.of(context).requestFocus(widget.nextFocusNode);
            } else {
              FocusScope.of(context).unfocus();
            }
          },
        ),
      ],
    );
  }

  List<TextInputFormatter>? get _inputFormatters {
    if (widget.inputFormatters != null) {
      return widget.inputFormatters;
    }

    switch (widget.type) {
      case AppTextFieldType.phone:
        return [FilteringTextInputFormatter.digitsOnly];

      case AppTextFieldType.number:
        return [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))];

      default:
        return null;
    }
  }

  Widget? _buildSuffixIcon() {
    if (_isPassword) {
      return IconButton(
        onPressed: _togglePassword,
        splashRadius: 20,
        icon: Icon(
          _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: AppColors.textSecondary,
        ),
      );
    }

    return widget.suffixIcon;
  }
}
