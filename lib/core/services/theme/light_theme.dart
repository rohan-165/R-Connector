import 'package:r_connector/core/extension/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    textTheme: TextTheme(
      displayLarge: context.textTheme.displayLarge?.copyWith(
        color: AppColors.blackColor,
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        height: 0,
        letterSpacing: 0,
      ),
      displayMedium: context.textTheme.displayMedium?.copyWith(
        color: AppColors.blackColor,
        fontSize: 30.sp,
        fontWeight: FontWeight.w600,
        height: 0,
        letterSpacing: 0,
      ),
      displaySmall: context.textTheme.displaySmall?.copyWith(
        color: AppColors.blackColor,
        fontSize: 28.sp,
        fontWeight: FontWeight.w500,
        height: 0,
        letterSpacing: 0,
      ),
      headlineLarge: context.textTheme.headlineLarge?.copyWith(
        color: AppColors.blackColor,
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        height: 0,
        letterSpacing: 0,
      ),
      headlineMedium: context.textTheme.headlineMedium?.copyWith(
        color: AppColors.blackColor,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        height: 0,
        letterSpacing: 0,
      ),
      headlineSmall: context.textTheme.headlineSmall?.copyWith(
        color: AppColors.blackColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        height: 0,
        letterSpacing: 0,
      ),
      titleLarge: context.textTheme.titleLarge?.copyWith(
        color: AppColors.blackColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        height: 0,
        letterSpacing: 0,
      ),
      titleMedium: context.textTheme.titleMedium?.copyWith(
        color: AppColors.blackColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 0,
        letterSpacing: 0,
      ),
      titleSmall: context.textTheme.titleSmall?.copyWith(
        color: AppColors.blackColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        height: 0,
        letterSpacing: 0,
      ),
      bodyLarge: context.textTheme.bodyLarge?.copyWith(
        color: AppColors.blackColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        height: 0,
        letterSpacing: 0,
      ),
      bodyMedium: context.textTheme.bodyMedium?.copyWith(
        color: AppColors.blackColor,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        height: 0,
        letterSpacing: 0,
      ),
      bodySmall: context.textTheme.bodySmall?.copyWith(
        color: AppColors.darkGreyColor,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        height: 0,
        letterSpacing: 0,
      ),
      labelLarge: context.textTheme.labelLarge?.copyWith(
        color: AppColors.darkGreyColor,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        height: 0,
        letterSpacing: 0,
      ),
      labelMedium: context.textTheme.labelMedium?.copyWith(
        color: AppColors.darkGreyColor,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        height: 0,
        letterSpacing: 0,
      ),
      labelSmall: context.textTheme.labelSmall?.copyWith(
        color: AppColors.darkGreyColor,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        height: 18.sp,
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
      titleTextStyle: context.textTheme.headlineMedium?.copyWith(
        color: AppColors.whiteColor,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        height: 0,
        letterSpacing: 0,
      ),

      elevation: 0,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.buttonColor,
      textTheme: ButtonTextTheme.primary,
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.whiteColor,
      surface: AppColors.whiteColor,
      error: AppColors.errorColor,
      onPrimary: AppColors.whiteColor,
      onSecondary: AppColors.whiteColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        textStyle: context.textTheme.bodyMedium?.copyWith(
          color: AppColors.primaryColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          height: 0,
          letterSpacing: 0,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.whiteColor,
        backgroundColor: AppColors.buttonColor,
        textStyle: context.textTheme.bodyMedium?.copyWith(
          color: AppColors.whiteColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    ),
  );
}
