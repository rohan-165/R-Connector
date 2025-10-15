import 'package:dri_flutter/core/extension/build_context_extension.dart';
import 'package:dri_flutter/core/extension/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_colors.dart';
import '../core/localization/app_locale.dart';
import '../core/utils/debounc_utils.dart';
import 'three_dot_loader.dart';

class ButtonWidget extends StatelessWidget {
  final String? lable;
  final VoidCallback onTap;
  final Color? buttonColor, lableColor, borderColor;
  final double? width;
  final double? height;
  final double? horizontal;
  final bool isLoading;
  final String? prifixIcon;
  const ButtonWidget({
    super.key,
    this.lable,
    required this.onTap,
    this.buttonColor,
    this.lableColor,
    this.borderColor,
    this.width,
    this.height,
    this.horizontal,
    this.isLoading = false,
    this.prifixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => DebounceUtils().run(onTap),
      child: Container(
        height: height?.h ?? 48.h,
        alignment: Alignment.center,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: (buttonColor ?? AppColors.primaryColor),
          border: Border.all(color: (borderColor ?? AppColors.primaryColor)),
        ),
        child: isLoading
            ? ThreeDotLoader().padVertical(vertical: 8.h)
            : (prifixIcon ?? '').isNotEmpty
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(prifixIcon!, height: 20.w),
                  10.w.horizontalSpace,
                  Text(
                    lable ?? context.l10(AppLocale.submit),
                    style: context.textTheme.titleLarge?.copyWith(
                      color: lableColor ?? AppColors.whiteColor,
                    ),
                  ),
                ],
              )
            : Text(
                lable ?? context.l10(AppLocale.submit),
                style: context.textTheme.titleLarge?.copyWith(
                  color: lableColor ?? AppColors.whiteColor,
                ),
              ).padHorizontal(horizontal: 20.w).padVertical(vertical: 8.h),
      ).padHorizontal(horizontal: horizontal ?? 20.w),
    );
  }
}

Widget alertButton(
  BuildContext context, {
  required String lable,
  bool isOk = true,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
    alignment: Alignment.center,
    width: 0.3.sw,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.r),
      color: isOk ? (AppColors.primaryColor) : null,
      border: Border.all(
        color: isOk ? AppColors.primaryColor : AppColors.primaryColor,
      ),
    ),
    child: Text(
      lable,
      style: context.textTheme.titleMedium?.copyWith(
        color: isOk ? AppColors.whiteColor : AppColors.primaryColor,
      ),
    ),
  );
}
