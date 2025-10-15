import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:r_connector/core/extension/build_context_extension.dart';
import 'package:r_connector/core/extension/widget_extensions.dart';

import 'core/constants/app_colors.dart';

class RootedDeviceScreen extends StatelessWidget {
  const RootedDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 100.w,
              color: AppColors.errorColor,
            ),
            20.verticalSpace,
            Text(
              'Rooted/Jailbroken Device Detected',
              style: context.textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            20.verticalSpace,
            Text(
              'This app cannot run on rooted or jailbroken devices for security reasons. '
              'Please use a non-modified device to continue.',
              style: context.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            30.verticalSpace,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.errorColor,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () => SystemNavigator.pop(),
              child: Text('Exit App', style: TextStyle(color: Colors.white)),
            ),
          ],
        ).padAll(value: 20.w),
      ),
    );
  }
}
