import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medicine_cabinet/core/constants/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.isPassword = false,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintTextColor,
    this.hintStyle,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.keyboardType,
    this.suffixWidget,
    this.prefixIcon,
    this.prefix,
    this.action,
    this.focusNode,
    this.borderRadius,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.enabled = true,
    this.fillColor,
    this.filled = true,
    this.contentPadding,
    this.style,
    this.enabledBorderColor,
    this.focusedBorderColor,
  });

  final TextEditingController? controller;
  final bool isPassword;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final Color? hintTextColor;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function()? onEditingComplete, onTap;
  final TextInputType? keyboardType;
  final Widget? suffixWidget, prefixIcon, prefix;
  final TextInputAction? action;
  final FocusNode? focusNode;
  final BorderRadius? borderRadius;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final bool enabled;
  final Color? fillColor;
  final bool filled;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  void _toggleObscureText() {
    setState(() => obscureText = !obscureText);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultFillColor = isDark
        ? AppColors.surfaceAltDark
        : const Color(0xFFF9FBFA);
    final defaultBorderColor = isDark
        ? AppColors.borderDark
        : AppColors.borderLight;
    final defaultFocusedColor = isDark
        ? AppColors.primaryDark
        : AppColors.primaryLight;
    final defaultTextColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onTap: widget.onTap,
      obscureText: widget.isPassword ? obscureText : false,
      keyboardType: widget.keyboardType,
      textInputAction: widget.action ?? TextInputAction.next,
      focusNode: widget.focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      minLines: widget.minLines,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      style: widget.style ??
          TextStyle(
            fontSize: 15.sp,
            color: defaultTextColor,
            fontWeight: FontWeight.w500,
          ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: widget.labelStyle ??
            TextStyle(
              fontSize: 14.sp,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              fontWeight: FontWeight.w500,
            ),
        fillColor: widget.fillColor ?? defaultFillColor,
        filled: widget.filled,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            TextStyle(
              fontSize: 14.sp,
              color: widget.hintTextColor ??
                  (isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
              fontWeight: FontWeight.w400,
            ),
        errorMaxLines: 3,
        errorStyle: TextStyle(
          color: isDark ? AppColors.errorDark : AppColors.errorLight,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: widget.prefixIcon,
        prefix: widget.prefix,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: _toggleObscureText,
                child: Icon(
                  obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  size: 22.r,
                ),
              )
            : widget.suffixWidget,
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
        border: _buildInputBorder(widget.enabledBorderColor ?? defaultBorderColor, 1.w),
        enabledBorder: _buildInputBorder(widget.enabledBorderColor ?? defaultBorderColor, 1.w),
        focusedBorder: _buildInputBorder(widget.focusedBorderColor ?? defaultFocusedColor, 1.5.w),
        errorBorder: _buildInputBorder(isDark ? AppColors.errorDark : AppColors.errorLight, 1.w),
        focusedErrorBorder: _buildInputBorder(isDark ? AppColors.errorDark : AppColors.errorLight, 1.5.w),
        disabledBorder: _buildInputBorder(
          (widget.enabledBorderColor ?? defaultBorderColor).withValues(alpha: 0.5),
          1.w,
        ),
      ),
    );
  }

  OutlineInputBorder _buildInputBorder(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(14.r),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}


