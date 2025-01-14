import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.name,
    this.label = '',
    this.initialValue,
    this.onTap,
    this.onSaved,
    this.hintText,
    this.validator,
    this.onChanged,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
    this.focusNode,
    this.keyboardType,
    this.obscureText = false,
    this.textInputAction = TextInputAction.done,
    this.inputFormatters,
    this.maxLength,
    this.readOnly = false,
  });

  final String name;
  final String label;
  final int? maxLines;
  final bool obscureText;
  final String? initialValue;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    BorderRadius customBorderRadius = BorderRadius.circular(8.sp);
    return TextFormField(
      inputFormatters: inputFormatters,
      onTap: onTap,
      readOnly: readOnly,
      initialValue: initialValue,
      onSaved: onSaved,
      maxLines: maxLines ?? 1,
      validator: validator,
      onChanged: onChanged,
      maxLength: maxLength,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.primaryColor.withOpacity(0.1),
        alignLabelWithHint: true,
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          color: AppColors.textColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.textColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffixIconColor: AppColors.primaryColor,
        border: OutlineInputBorder(
          borderRadius: customBorderRadius,
          gapPadding: 0,
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 0.5.sp,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: customBorderRadius,
          gapPadding: 0,
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 0.5.sp,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: customBorderRadius,
          gapPadding: 0,
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 0.5.sp,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: customBorderRadius,
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 0.5.sp,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: customBorderRadius,
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 0.5.sp,
          ),
        ),
        constraints: maxLines == 1
            ? BoxConstraints(minHeight: 48.sp, maxHeight: 48.sp)
            : null,
      ),
    );
  }
}
