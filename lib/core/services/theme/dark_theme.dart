import 'package:r_connector/core/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.darkScaffoldBackgroundColor,
    textTheme: TextTheme(
      displayLarge: context.textTheme.displayLarge?.copyWith(
        color: AppColors.whiteColor,
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        height: 0,
        letterSpacing: 0,
      ),
      displayMedium: context.textTheme.displayMedium?.copyWith(
        color: AppColors.whiteColor,
        fontSize: 28.sp,
        fontWeight: FontWeight.w500,
        height: 0,
        letterSpacing: 0,
      ),
      displaySmall: context.textTheme.displaySmall?.copyWith(
        color: AppColors.whiteColor,
        fontSize: 28.sp,
        fontWeight: FontWeight.w500,
        height: 0,
        letterSpacing: 0,
      ),
      headlineLarge: context.textTheme.headlineLarge?.copyWith(
        color: AppColors.whiteColor,
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        height: 0,
        letterSpacing: 0,
      ),
      headlineMedium: context.textTheme.headlineMedium?.copyWith(
        color: AppColors.whiteColor,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        height: 0,
        letterSpacing: 0,
      ),
      headlineSmall: context.textTheme.headlineSmall?.copyWith(
        color: AppColors.whiteColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        height: 0,
        letterSpacing: 0,
      ),
      titleLarge: context.textTheme.titleLarge?.copyWith(
        color: AppColors.whiteColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        height: 0,
        letterSpacing: 0,
      ),
      titleMedium: context.textTheme.titleMedium?.copyWith(
        color: AppColors.whiteColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 0,
        letterSpacing: 0,
      ),
      titleSmall: context.textTheme.titleSmall?.copyWith(
        color: AppColors.whiteColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        height: 0,
        letterSpacing: 0,
      ),
      bodyLarge: context.textTheme.bodyLarge?.copyWith(
        color: AppColors.whiteColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        height: 0,
        letterSpacing: 0,
      ),
      bodyMedium: context.textTheme.bodyMedium?.copyWith(
        color: AppColors.whiteColor,
        fontSize: 15.sp,
        fontWeight: FontWeight.normal,
        height: 0,
        letterSpacing: 0,
      ),
      bodySmall: context.textTheme.bodySmall?.copyWith(
        color: AppColors.whiteColor,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        height: 0,
        letterSpacing: 0,
      ),
      labelLarge: context.textTheme.labelLarge?.copyWith(
        color: AppColors.whiteColor,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        height: 0,
        letterSpacing: 0,
      ),
      labelMedium: context.textTheme.labelMedium?.copyWith(
        color: AppColors.whiteColor,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        height: 0,
        letterSpacing: 0,
      ),
      labelSmall: context.textTheme.labelSmall?.copyWith(
        color: AppColors.whiteColor,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        height: 0,
        letterSpacing: 0,
      ),
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.statusBarColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      toolbarHeight: 56.h,
      centerTitle: true,

      elevation: 1,
    ),

    cardColor: AppColors.darkGreyColor,
    cardTheme: CardThemeData(
      color: AppColors.darkGreyColor,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0.r),
        side: BorderSide(color: AppColors.darkGreyColor, width: 1.0),
      ),
    ),

    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      surface: AppColors.darkGreyColor,
      error: AppColors.errorColor,
      onPrimary: AppColors.whiteColor,
      onSecondary: AppColors.whiteColor,
      onSurface: AppColors.whiteColor,
    ),
  );
}
