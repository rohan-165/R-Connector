import 'package:r_connector/core/extension/build_context_extension.dart';
import 'package:r_connector/core/extension/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_colors.dart';
import '../core/localization/app_locale.dart';
import '../core/services/get_it/service_locator.dart';
import '../core/services/navigation_service.dart';
import 'button_widget.dart';

class AlertDialogWidget extends StatelessWidget {
  final String? icon;
  final bool iconColor;
  final String lable;
  final String? message;
  final Function()? okTap;
  final Function()? cancelTap;
  final String? buttonLable;
  final String? secondbuttonLable;
  final Widget? child;
  const AlertDialogWidget({
    super.key,
    this.icon,
    this.iconColor = true,
    required this.lable,
    this.message,
    this.okTap,
    this.cancelTap,
    this.buttonLable,
    this.secondbuttonLable,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: context.isDark
                ? AppColors.darkGreyColor
                : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(
              color: context.isDark
                  ? AppColors.darkGreyColor
                  : AppColors.whiteColor,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                lable,
                textAlign: TextAlign.center,
                style: context.textTheme.titleLarge,
              ).padBottom(bottom: 10.h).padTop(),
              if (child != null) ...{child!},
              if ((message ?? '').isNotEmpty) ...{
                Text(
                  message ?? '',
                  textAlign: TextAlign.center,
                ).padBottom(bottom: 20.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    alertButton(
                          context,
                          lable:
                              secondbuttonLable ??
                              context.l10(AppLocale.cancel),
                          isOk: false,
                        )
                        .padRight(right: 10.w)
                        .onTap(
                          cancelTap != null
                              ? () => cancelTap!()
                              : () => getIt<NavigationService>().goBack(),
                        ),
                    alertButton(
                      context,
                      lable: buttonLable ?? context.l10(AppLocale.ok),
                    ).onTap(
                      okTap != null
                          ? () => okTap!()
                          : () => getIt<NavigationService>().goBack(),
                    ),
                  ],
                ),
              },
            ],
          ),
        ),
        Positioned(
          top: -25,
          left: 0.w,
          right: 0.w,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.isDark
                    ? AppColors.darkGreyColor
                    : AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(90),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
              padding: EdgeInsets.all(5.w),
              child: Image.asset(
                icon ?? '',
                height: 30.w,
                width: 30.w,
                color: iconColor ? AppColors.primaryColor : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
