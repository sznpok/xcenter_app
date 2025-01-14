import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      this.icon,
      required this.label,
      this.labelColor,
      this.color = AppColors.primaryColor,
      this.borderColor,
      this.buttonStyle,
      this.height,
      this.loading = false,
      this.fontweight = FontWeight.w500,
      this.loadingColor = AppColors.secondaryColor});

  final Function()? onPressed;
  final String label;
  final double? height;
  final Color color;
  final Color? labelColor;
  final Color? borderColor;
  final IconData? icon;
  final Color loadingColor;
  final TextStyle? buttonStyle;
  final bool loading;
  final FontWeight fontweight;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: height ?? 48.sp,
        minWidth: double.infinity,
      ),
      child: icon == null
          ? ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                    side: BorderSide(color: borderColor ?? color, width: 0.5),
                  ),
                ),
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.all(color),
              ),
              onPressed: loading ? null : onPressed,
              child: loading
                  ? ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 20.sp,
                        maxHeight: 20.sp,
                      ),
                      child: CircularProgressIndicator(
                        color: loadingColor,
                        backgroundColor: color,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      label,
                      style: buttonStyle ??
                          TextStyle(
                            fontWeight: fontweight,
                            fontSize: 16.spMin,
                            color: labelColor ?? AppColors.secondaryColor,
                          ),
                    ),
            )
          : ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                    side: BorderSide(color: borderColor ?? color, width: 1),
                  ),
                ),
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.all(color),
              ),
              onPressed: loading ? null : onPressed,
              child: loading
                  ? LimitedBox(
                      maxWidth: 20.sp,
                      maxHeight: 20.sp,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        backgroundColor: color,
                        strokeWidth: 2,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          color: labelColor ?? AppColors.secondaryColor,
                          size: 20.sp,
                        ),
                        5.horizontalSpace,
                        Text(
                          label,
                          style: buttonStyle ??
                              TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.spMin,
                                color: labelColor ?? AppColors.secondaryColor,
                              ),
                        ),
                      ],
                    ),
            ),
    );
  }
}
