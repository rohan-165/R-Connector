import 'package:dri_flutter/core/extension/build_context_extension.dart';
import 'package:dri_flutter/core/extension/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_colors.dart';
import '../core/localization/app_locale.dart';

class NoDataWidget extends StatelessWidget {
  final double? height;
  final String? title;
  final String? subtitle;
  const NoDataWidget({super.key, this.height, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 100.r,
            backgroundColor: AppColors.primaryColor.withAlpha(40),
            child: Icon(Icons.image, size: height?.h ?? 150.h),
          ).padBottom(),
          Text(
            title ?? context.l10(AppLocale.no_data_title),
            style: context.textTheme.titleLarge,
          ).padBottom(bottom: 10.h),
          Text(
            subtitle ?? context.l10(AppLocale.no_data_subtitle),
            style: context.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ).padBottom(bottom: 10.h),
        ],
      ).padHorizontal(horizontal: 10.w),
    );
  }
}
