import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import 'navigator_key.dart';

showSnackBar({
  required String content,
  Color color = AppColors.green,
}) async {
  ScaffoldMessenger.of(RootNavigatorKey.context).hideCurrentSnackBar();
  ScaffoldMessenger.of(RootNavigatorKey.context).showSnackBar(
    SnackBar(
      elevation: 0,
      backgroundColor: color,
      margin: EdgeInsets.only(
        bottom: ScreenUtil().screenHeight * 0.01,
        right: ScreenUtil().screenWidth * 0.02,
        left: ScreenUtil().screenWidth * 0.02,
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      content: Text(
        content,
        style: Theme.of(RootNavigatorKey.context).textTheme.bodySmall!.copyWith(
              color: AppColors.white,
            ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
  );
}
