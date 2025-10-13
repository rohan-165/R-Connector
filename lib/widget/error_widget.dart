import 'package:dri_flutter/core/extension/build_context_extension.dart';
import 'package:dri_flutter/core/extension/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/localization/app_locale.dart';
import 'button_widget.dart';

class CustomErrorWidget extends StatelessWidget {
  final double? height;
  final String? title;
  final String? subTitle;
  final VoidCallback onRetry;
  const CustomErrorWidget({
    super.key,
    this.height,
    this.subTitle,
    this.title,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.image, size: height?.h ?? 250.h),
          Text(
            title ?? context.l10(AppLocale.something_went_wrong_title),
            style: context.textTheme.titleLarge,
          ).padBottom(bottom: 5.h),
          Text(
            subTitle ?? context.l10(AppLocale.something_went_wrong_subtitle),
            style: context.textTheme.titleMedium,
          ).padBottom(bottom: 10.h),

          ButtonWidget(
            height: 35.h,
            width: 120.w,
            lable: context.l10(AppLocale.retry),
            onTap: onRetry,
          ).padBottom(bottom: 10.h),
        ],
      ).padHorizontal(horizontal: 10.w),
    );
  }
}
