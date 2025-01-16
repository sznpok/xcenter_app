import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_colors.dart';
import '../../../utils/navigator_key.dart';

void showCustomBottomSheet({
  required Widget child,
  double? height,
  isDismissible = true,
  VoidCallback? onDismiss,
}) {
  showModalBottomSheet(
    context: RootNavigatorKey.context,
    isDismissible: isDismissible,
    enableDrag: isDismissible,
    constraints: BoxConstraints(
      minHeight: height ?? 0.3.sh,
      maxHeight: 0.88.sh,
      minWidth: 1.sw,
      maxWidth: 1.sw,
    ),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    backgroundColor: AppColors.backgroundColor,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 10.sp,
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: child,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 50.sp,
                  height: 5.sp,
                  decoration: BoxDecoration(
                    color: AppColors.textColor,
                    borderRadius: BorderRadius.circular(2.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  ).whenComplete(() {
    onDismiss?.call();
  });
}
